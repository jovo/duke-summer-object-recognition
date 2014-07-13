% Detect SV Script Version
tic

imagestack=getfield(load('AC4_matrices.mat'),'imageAC4');
count=size(imagestack,3);

model=getfield(load('RFModel500_5.mat'),'RFModel');
CodeBook=getfield(load('CodeBook.mat'),'CodeBook');

BinaryResult=zeros(size(imagestack));
MitoSV={};
for i=1:1:count
    %tic
    I=imagestack(:,:,i);
    [SVI,bw,SVCell]=SuperVoxelize(I,CodeBook);
    [Imarked,RGBI,M,BW,mito]=DetectSV(SVCell,model,I);
    %figure, imshow(RGBI);
    %figure, imshow(uint8(SVI));
    %figure, imshow(BW);
    MitoSV{end+1}=mito;
    BinaryResult(:,:,i)=BW;
    disp(i);
    %toc
end;

%save('RFResult_1','BinaryResult','MitoSV');

toc
