function [ X,Y ] = KNNUpdateDir(centroids,passDir,failDir)
%Using KNN to make R100 vectors of passing and failing training data
%centroids refers to the K-Means cetroids
%X and Y are the classifier inputs

fileP=dir(passDir);
[sizeP,temp1]=size(fileP);

fileF=dir(failDir);
[sizeF,temp2]=size(fileF);

X=[];
Y=[];
for i=1:1:sizeP;
    data=fileP(i);
    if isequal(strfind(data.name,'train'),[])==0 %name contrains 'train'
        countKMeans=zeros(1,100);
        R25Patches=MakeR25Vectors(strcat(passDir,'/',data.name));
        IDX=knnsearch(centroids,R25Patches);
        [sizeIDX,temp3]=size(IDX);
        for ind=1:1:sizeIDX;
            countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
        end;
        X=[X;countKMeans];
        Y=[Y;[1]];
    end;
end;

for i=1:1:sizeF;
    data=fileF(i);
    countKMeans=zeros(1,100);
    if isequal(strfind(data.name,'train'),[])==0 %name contrains 'train'
        R25Patches=MakeR25Vectors(strcat(failDir,'/',data.name));
        IDX=knnsearch(centroids,R25Patches);
        [sizeIDX,temp3]=size(IDX);
        for ind=1:1:sizeIDX;
            countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
        end;
        X=[X;countKMeans];
        Y=[Y;[0]];
    end;
end;
end
