function [BinaryResult, MitoSV] = DetectionAPI( imagestack,model,CodeBook )
% Mitochondria Detection helper program
%
% Input:
% imagestack:image cube cutout from OCP API
% 
% model: Random Forest Model
% 
% CodeBook: codebook matrix for generating Bag-of-Words features 
%
% Output:
% BinaryResult: Binary image cube of where mitochondria were detected im
% imagestack
%
% MitoSV: Cell of SuperVoxels which were detected as mitochondria
% 


tic
%% Detect Mitochondria

count=size(imagestack,3);

BinaryResult=zeros(size(imagestack));
MitoSV=cell(1,100);

for i=1:1:count
    %tic
    I=imagestack(:,:,i);
    [SVI,bw,SVCell]=SuperVoxelize(I,CodeBook); % Get SuperVoxels
    [BW,mito]=DetectSV(SVCell,model,I); % Detect SuperVoxels
    MitoSV{1,i}=mito;
    %figure, imshow(uint8(255*double(BW)+double(imagestack(:,:,i))));
    BinaryResult(:,:,i)=BW;
    disp(strcat('Processed image:',num2str(i)));
    %toc
end;

%% Remove small areas from image contours
CC=bwconncomp(BinaryResult,8);
for i=1:1:CC.NumObjects
    px=CC.PixelIdxList{i};
    if size(px,1)<200
        BinaryResult(px)=0;
    end;
end;

BinaryResult=BinaryResult>0;

toc
end

