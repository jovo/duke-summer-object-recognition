function [ BinaryResult,mito] = DetectSV(SVCell,model,I)
% Detection of Mitochondria using Random Forest with Super Voxels
%
%
% Input:
% SVCell: Cell of SuperVoxels (SuperVoxel class objects) which are to be classified
%
% model: Random Forest model used for mitochondria classification
%
% I: Image which the supervoxels are from
% 
% Output:
% BW: Binary image of size I where mitochondria are detected via
% SuperVoxels and image contours
% 
% mito: Cell of detected SuperVoxels where mitochondria occur
%

%% Construct matrix of feature vectors
X=zeros(size(SVCell,2),size(SVCell{1,1}.FVector,2));
indX=1;
for i=1:1:size(SVCell,2)
    sv=SVCell{1,i};
    X(indX,:)=sv.FVector;
    indX=indX+1;
end;

%% Use Random Forest to predict correct SuperVoxels
[L,P]=classRF_predict(X,model);
mito=cell(1,size(L,1));
mi=1;
for i=1:1:size(L,1)
    %if P(i,2)/500>.45
    if L(i,1)==1
        mito{1,mi}=SVCell{1,i};
        mi=mi+1;
    end;
end;
mito=mito(~cellfun(@isempty, mito));

%% Getting Centroids to use with Image Contour
CM=zeros(size(mito,2),2);
CMi=1;
for i=1:1:size(mito,2)
    sv=mito{1,i};
    coor=sv.SVCoor;
    Centroid=double(sum(coor))/size(coor,1);
    yC=round(Centroid(1,1));
    xC=round(Centroid(1,2));
    CM(CMi,:)=[yC,xC];
    CMi=CMi+1;
end;

%% Using image contours to refine SuperVoxels
y=CM(:,2);
x=CM(:,1);

BinaryResult=activecontour_2(I,20,20,y,x);
BinaryResult=BinaryResult>0;
        
end

