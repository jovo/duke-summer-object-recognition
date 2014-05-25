close all
clear all

% RGB=imread('coins3.jpg'
% I=rgb2gray(RGB);
% BW=edge(I, 'canny');
% %figure, imshow(BW);
% BI=im2bw(BW,.5);
dist = 2;
thresh = [0.1 0.45];
coin=imread('coins3.jpg','jpg');
%coin = imsharpen(I,'Radius',.3,'Amount',.1);
figure, imshow(coin);
%coin=edge(rgb2gray(I),'canny');
%coin = rgb2gray(I); 
ecoin = edge(coin(:,:,1), 'canny', thresh);
%figure, imshow(ecoin);

%radii of the coins to be detected
rbv = [22.5, 26, 28, 28.5, 32.5, 33, 37.5];

%x,y coordinates of centers to consider
xbv = 1:dist:size(ecoin, 2);
ybv = 1:dist:size(ecoin, 1);

%himg has the hough transform image
himg = hough_circle(ecoin, xbv, ybv, rbv);
%figure, imshow(himg); 

%final image with circles marked
circimg = mark_circles(coin, himg, rbv);

figure, imshow(circimg);
%disp('done')

