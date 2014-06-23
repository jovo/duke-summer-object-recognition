function [X,Y] = BOWClassifierInputs(centroids,passCell,failCell)
%Using KNN to make R100 vectors of passing and failing training data
%centroids refers to the K-Means cetroids
%X and Y are the classifier inputs
tic
szP=size(passCell,2);
szF=size(failCell,2);

X=[];
Y=[];

for i=1:1:szP;
    countKMeans=zeros(1,100);
    R100Patches=MakeR100Vectors(passCell{1,i});
    IDX=knnsearch(double(centroids),double(R100Patches));
    [sizeIDX,temp3]=size(IDX);
    for ind=1:1:sizeIDX;
        countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
    end;
    X=[X;countKMeans];
    Y=[Y;[1]];
end;

for i=1:1:szF;
    countKMeans=zeros(1,100);
    R100Patches=MakeR100Vectors(failCell{1,i});
    IDX=knnsearch(double(centroids),double(R100Patches));
    [sizeIDX,temp3]=size(IDX);
    for ind=1:1:sizeIDX;
        countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
    end;
    X=[X;countKMeans];
    Y=[Y;[0]];
end;

toc
end

