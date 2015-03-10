function [ IDX,C ] = KMeansR100( R100VectorsMatrix )
%R25VectorsMatrix K by 25 matrix where K is the number of testsamples 
%Outputs KMeans vectors
tic
[IDX,C]=kmeans(double(R100VectorsMatrix),100);
toc
end

