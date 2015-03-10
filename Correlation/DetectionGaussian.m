close all;
clear all;
%image representing F(x,y)
I1=imread('image.png');
grayF=double(rgb2gray(I1));
result=grayF;
grayF=NormalizeImage(grayF);
figure, imshow(uint8(grayF));
[xMax, yMax]=size(grayF);

G=GaussianMatrix(20);
X=xcorr2(grayF,G);
[xdim,ydim]=size(X);
disp(min(min(X)));
for i=1+21:1:xdim-21;
    for j=1+21:1:ydim-21;
        if(50<uint8(X(i,j)) && uint8(X(i,j))<60)
            result(i-21,j-21)=255;
        end;
    end;
end;
disp(size(X));
disp(size(result));
disp(size(G));
figure, imshow(uint8(X));
figure, imshow(uint8(result));

% mini=50;
% maxi=0;
% for X=41:1:xMax;
%     for Y=41:1:yMax;
%         [result,mini,maxi, correlation]=CorrelationHelper(grayF, X, Y, 20, mini, maxi, .00055, result);
%     end;
% end;
% 
% disp(mini);
% disp(maxi);
% figure, imshow(uint8(result));