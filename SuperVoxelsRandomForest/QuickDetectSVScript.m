% Detect SV Script Version
tic

imagestack=getfield(load('AC4_matrices.mat'),'imageAC4');
count=size(imagestack,3);

model=getfield(load('RFModel500_5.mat'),'RFModel');
CodeBook=getfield(load('CodeBook.mat'),'CodeBook');

BinaryResult=zeros(size(imagestack));
MitoSV=cell(1,100);
for i=1:1:1
    tic
    I=imagestack(:,:,i);
    [SVI,bw,SVCell]=SuperVoxelize(I,CodeBook);
    [BW,mito]=DetectSV(SVCell,model,I);
    MitoSV{1,i}=mito;
    BinaryResult(:,:,i)=BW;
    disp(i);
    toc
end;

CC=bwconncomp(BinaryResult,8);
for i=1:1:CC.NumObjects
    px=CC.PixelIdxList{i};
    if size(px,1)<200
        BinaryResult(px)=0;
    end;
end;

BinaryResult=BinaryResult>0;

%save('RFResult_1','BinaryResult','MitoSV');

toc
