function [ IDX,C ] = KMeansR25( R25VectorsMatrix )
%R25VectorsMatrix K by 25 matrix where K is the number of testsamples 
%Outputs KMeans vectors

[IDX,C]=kmeans(double(R25VectorsMatrix),100);

end

