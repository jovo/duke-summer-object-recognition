close all
clear all

struct=load('AC4_matrices.mat');
field=getfield(struct,'annoTruthAC4');
grayI=mat2gray(field);
figure, imshow(grayI(:,:,1));

I=grayI(:,:,1);

dist = 2;
thresh = [0.1 0.45];
 
edgeI = edge(I(:,:,1), 'canny', thresh);
figure, imshow(edgeI);
hold on
%radii of the coins to be detected
%rbv = [22.5, 26, 28, 28.5, 32.5, 33, 38.5];
rbv=[26]

%x,y coordinates of centers to consider
xbv = 1:dist:size(edgeI, 2);
ybv = 1:dist:size(edgeI, 1);

%himg has the hough transform image
himg = hough_circle(edgeI, xbv, ybv, rbv);
%figure, imshow(himg); 

%final image with circles marked
circimg = mark_circles(I, himg, rbv);

figure, imshow(circimg);

%disp('done')

