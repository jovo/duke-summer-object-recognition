function [ label, score ] = ClassifyMitochondria( SVMModel,testFile, numIm )
%Outputs a vector of truth values (i.e., whether the testcases are
%mitochondria)
%the images are labeled testcase#.png in the test file
testMat=zeros(numIm,12);
for i=1:1:numIm;
    prop=RegionPropVector(strcat(testFile,'/testcase',int2str(i),'.png'));
    for j=1:1:12;
        testMat(i,j)=prop(j,1);
    end;
end;


[label,score]=predict(SVMModel,testMat);


end

