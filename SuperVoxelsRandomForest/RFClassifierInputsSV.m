function [X,Y] = RFClassifierInputsSV(mito,notMito)
%Creates inputs for Random Forest Classifier
%   Detailed explanation goes here
tic
X=zeros(size(mito,2)+size(notMito,2),size(mito{1,1}.FVector,2));
Y=zeros(size(mito,2)+size(notMito,2),1);

%ProjSV=getfield(load('ProjSV'),'ProjSV');

ind=1;
for i=1:1:size(mito,2)
    SV=mito{1,i};
    FV=SV.FVector;
    X(ind,:)=FV;
    Y(ind,1)=1;
    ind=ind+1;
end;

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

