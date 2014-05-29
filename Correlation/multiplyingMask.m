function [ imageF, mini ] = multiplyingMask( imageF, x, y, r, mini, cutoff )

%Computes correlation of two images
%Detailed explanation goes here
%correlationMatrix=zeros(121,121);
[xMax, yMax]=size(imageF);

for i=-1*2*r:1:2*r;
    if x+i>xMax
        break;
    end;
    for j=-1*2*r:1:2*r;
        if y+j>yMax
            break;
        end;
        if imageF(x+i,y+j)>150
            continue;
        end;
        correlation=imageF(x+i,y+j)*GaussianCompute(i,j,r);
        %correlationMatrix(i+61,j+61)=correlation;
        if correlation<cutoff
            imageF(x+i,y+j)=255;
        end;
        if correlation<mini
            mini=correlation;
        end;
    end;
end;
    
end

