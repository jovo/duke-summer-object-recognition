close all;
clear all;
%image representing F(x,y)
I1=imread('QuarterImage.png');
grayF=double(rgb2gray(I1));
result=grayF;
grayF=NormalizeImage(grayF);
figure, imshow(uint8(grayF));
[xMax, yMax]=size(grayF);

mini=50;
maxi=0;
for X=21:1:xMax;
    for Y=21:1:yMax;
        [result,mini,maxi]=CorrelationHelper(grayF, X, Y, 20, mini, maxi, .00055, result);
    end;
end;

disp(mini);
disp(maxi);
figure, imshow(uint8(result));