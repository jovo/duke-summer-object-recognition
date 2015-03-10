function [X,Y] = RFClassifierInputsSV(mito,notMito)
% Creates inputs for Random Forest Classifier
%
% Inputs:
% mito: cell of mitochondria SuperVoxels
% 
% notMito: cell of not-mitochondria SuperVoxels
%
% Output:
% X: matrix with rows as observations and columns as features
%
% Y: column matrix of category (1 for mitochondria, 0 for not-mitochondria)
%
%% Initiate X and Y
tic
X=zeros(size(mito,2)+size(notMito,2),size(mito{1,1}.FVector,2));
Y=zeros(size(mito,2)+size(notMito,2),1);

%ProjSV=getfield(load('ProjSV'),'ProjSV');

%% Make X and Y for truth mitochondria
ind=1;
for i=1:1:size(mito,2)
    SV=mito{1,i};
    FV=SV.FVector;
    X(ind,:)=FV;
    Y(ind,1)=1;
    ind=ind+1;
end;

%% Make X and Y for false mitochondria
for i=1:1:size(notMito,2)
    SV=notMito{1,i};
    FV=SV.FVector;
    X(ind,:)=FV;
    %Y(ind,1)=0;
    ind=ind+1;
end;

%X=X*ProjSV;

toc
end

