function [ result, mini, maxi ] = correlationGaussian( imageF, x, y, r, mini, maxi, cutoff, result )

%Computes correlation of two images
%Detailed explanation goes here
%correlationMatrix=zeros(121,121);
[xMax, yMax]=size(imageF);

correlation=0;
for i=-1*r:1:r;
    if x+i>xMax
        break;
    end;
    for j=-1*r:1:r;
        if y+j>yMax
            break;
        end;
        if imageF(x+i,y+j)>150
            continue;
        end;
        correlation=correlation+imageF(x+i,y+j)*GaussianCompute(i,j,r);
    end;
end;

if correlation>37
    result(x,y)=255;
    %t=0:.1:2*pi;
    %imageF(floor(x+r*cos(t)),floor(y+r*sin(t)))=255; 
    %result(floor(x+5*cos(t)),floor(y+5*sin(t)))=255;
end;

if correlation>maxi
    maxi=correlation;
end;

if correlation<mini
    mini=correlation;
end;

end

