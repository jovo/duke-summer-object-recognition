function [ correlation ] = correlationGaussian( imageF, x, y, r )

%Computes correlation of two images
%   Detailed explanation goes here


correlation=0;

innerSum=0;
for i=-1*25:1:25;
    innerSum=innerSum+gaussmf(y+i,[r, 1])*imageF(x,y); 
end;

for j=-1*25:1:25;
    correlation=correlation+gaussmf(x+j, [r,1]);
end;

correlation=innerSum*correlation;
end

