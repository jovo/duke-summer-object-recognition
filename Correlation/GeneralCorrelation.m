close all;
clear all;
%image representing F(x,y)
I1=imread('image.png');
grayF=double(rgb2gray(I1));
result=grayF;
grayF=NormalizeImage(grayF);

figure, imshow(uint8(grayF));
[xO,yO]=size(grayF);

crop=double(rgb2gray(imread('crop.png')));
[xC,yC]=size(crop);

X=normxcorr2(crop,grayF);

disp(max(max(X)));

for i=1+xC/2:1:xO-xC/2;
    for j=1+yC/2:1:yO-yC/2;
        if(.4<X(i,j))
            result(i-xC/2,j-yC/2)=255;
        end;
    end;
end;
figure, surf(X), shading flat
figure, imshow(uint8(X));
figure, imshow(uint8(result));