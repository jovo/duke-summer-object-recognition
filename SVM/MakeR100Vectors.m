function [ R100VMatrix ] = MakeR100Vectors( image )
%Makes R100 vectors to be used with K-Means for Bag-of-Words

if ischar(image)==1
    I=imread(image);
else
    I=image;
end;

[ySize,xSize]=size(I);
R100VMatrix=[];

for y=1:1:ySize-9;
    for x=1:1:xSize-9;
        %crop
        C=I(y:y+9,x:x+9);
        vector=[];
        for i=1:1:10;
            vector=[vector,C(i,1:10)];
        end;
        R100VMatrix=[R100VMatrix;vector];
    end;
end;

end