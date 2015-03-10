function [ result ] = GaussianMatrix( r )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

result=zeros(r+1,r+1);

for i=-1*r:1:r;
    for j=-1*r:1:r;
        result(i+r+1,j+r+1)=GaussianCompute(i,j,r);
    end;
end;


end

