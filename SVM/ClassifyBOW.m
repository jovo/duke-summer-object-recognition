function [label,score] = ClassifyBOW(SVMModel,testFileName,centroids )
%Classifies mitochondria using Bag of Words technique
%   Detailed explanation goes here

file=dir(testFileName);

[sizeFile,temp1]=size(file);

testMat=[];

for i=1:1:sizeFile;
    data=file(i);
    if isequal(strfind(data.name,'testcase'),[])==0 %name contains 'testcase'
        countKMeans=zeros(1,100);
        R25Mat=MakeR25Vectors(strcat(testFileName,'/',data.name));
        IDX=knnsearch(centroids,R25Mat);
        [sizeIDX,temp3]=size(IDX);
        for ind=1:1:sizeIDX;
            countKMeans(IDX(ind))=countKMeans(IDX(ind))+1;
        end;
        testMat=[testMat;countKMeans];
    end;
end;

[label,score]=predict(SVMModel,testMat);

end

