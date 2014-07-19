function [mito,notMito]=TrainingData(imagestack,TruthData,CodeBook,Start,End)
% Gets training data from an imagestack and TruthData
%
% Inputs:
% imagestack: 3D orignal image cube 
% 
% TruthData: logical matrix representing truth locations of mitochondria
% in imagestack
% 
% CodeBook: codebook to use to Bag-of-Words features
% 
% Start: starting z index for which to get the training data
% 
% End: ending z index for which to get the training data
%
% 
% Outputs:
% mito: cell of SuperVoxels which represent true mitochondria
%
% notMito: cell of SuperVoxels which represent false mitochondria 

%%
tic

mito={};
notMito={};
for i=Start:1:End
    %tic
    I=imagestack(:,:,i); % image from imagestack
    BW=TruthData(:,:,i); 
    %[y,x]=find(BW);
    %coor=[y,x];
    [SPI,bw,SVCell]=SuperVoxelize(I,CodeBook); % SuperVoxelize image
    % count how much SuperVoxels overlap with TruthData
    SVCount=zeros(size(SVCell,2),1);
    for j=1:1:size(SVCell,2)
        sv=SVCell{1,j};
        coor=sv.SVCoor;
        for k=1:1:size(coor,1)
            y=coor(k,1);
            x=coor(k,2);
            if BW(y,x)>0
                SVCount(j,1)=SVCount(j,1)+1;
            end;
        end;
    end;
    for k=1:1:size(SVCell,2)
        sv=SVCell{1,k};
        if SVCount(k,1)/size(sv.SVCoor,1)>.15 % 15% overlap, the supervoxel is truth
            mito{end+1}=sv;
            SVCell{1,k}=[];
        end;
    end;
    SVCell=SVCell(~cellfun(@isempty, SVCell));
    for j=1:1:size(SVCell,2)
        notMito{end+1}=SVCell{1,j};
    end;
    disp(strcat('Processed image:',num2str(i)));
    %toc
end;
toc