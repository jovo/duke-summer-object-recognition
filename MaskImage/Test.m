clear all
close all
% uiopen('/Users/user/Documents/MATLAB/ObjectDetection/colors.png',1)
colors='colors.png'
imagesc(colors)
X=rand(size(colors));
Y=X;
Y(boundary>0)=0;
imagesc(Y)
hist(X(boundary==0))
