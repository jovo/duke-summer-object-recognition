function [label,score] = ClassifyBOW(SVMModel,testCell,centroids )
%Classifies mitochondria using Bag of Words technique
%   Detailed explanation goes here

sz=size(testCell,2);


testMat=[];

for i=1:1:sz;
    I=testCell{1,i};
    countKMeans=zeros(1,100);
    R100Mat=MakeR100Vectors(I);
    IDX=knnsearch(double(centroids),double(R100Mat));
    [sizeIDX,temp3]=size(IDX);
    for ind=1:1:sizeIDX;
        countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
    end;
    countKMeans=countKMeans/sum(countKMeans);
    testMat=[testMat;countKMeans];
end;

[label,score]=predict(SVMModel,testMat);

end

