function [ R100VMatrix ] = MakeR100Vectors( image )
%Makes R100 vectors to be used with K-Means for Bag-of-Words
%
% Input:
% image: image from which to extract all 10-by-10 (R100) regions
% 
% Output:
% R100VMatrix: n by 100 MAtrix of the R100 Vectors for an image
%
%% Read in image
if ischar(image)==1
    I=imread(image);
else
    I=image;
end;

%% Pre-allocate Data and Make R100 Matrix
[ySize,xSize]=size(I);
R100VMatrix=zeros((xSize-9)*(ySize-9),100);
ind=1;

for y=1:1:ySize-9;
    for x=1:1:xSize-9;
        %crop
        C=I(y:y+9,x:x+9);
        R100VMatrix(ind,:)=[C(1,:),C(2,:),C(3,:),C(4,:),C(5,:),...
            C(6,:),C(7,:),C(8,:),C(9,:),C(10,:)];
        ind=ind+1;
    end;
end;

end