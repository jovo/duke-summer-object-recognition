function [ R25VMatrix ] = MakeR25Vectors( image )
%Makes R25 vectors to be used with K-Means for Bag-of-Words

if ischar(image)==1
    I=imread(image);
else
    I=image;
end;

[ySize,xSize]=size(I);
R25VMatrix=[];

for y=1:1:ySize-4;
    for x=1:1:xSize-4;
        %crop
        C=I(y:y+4,x:x+4);
        vector=[C(1,1:5),C(2,1:5),C(3,1:5),C(4,1:5),C(5,1:5)];
        R25VMatrix=[R25VMatrix;vector];
    end;
end;

end