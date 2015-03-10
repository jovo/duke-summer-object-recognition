% close all
function activecontour_2(I, radius,maxIterations)
%This function takes an image or slide, and given centerpoints, and a
%radius, will use an active contour to find the boundaries of an object in
%the image.
%Inputs:
%                 I = some image/slide
%                 radius = radius of circle bounding  object before 
%                            contour is applied
%                 maxIterations= maximum number of iterations to perform when using contour

r=radius;
figure, imshow(I);
% [IDX, C]=kmeans(double(I),2);
disp('Choose center points');
[y x]=getpts;
mask = true(size(I));

close


[imgH,imgW,~] = size(I);
bwAll=zeros(imgH, imgW);

figure
for ii=1:length(y)

%# circle params
t = linspace(0, 2*pi, 50);   %# approximate circle with 50 points
% r = 30;                      %# radius
c = [y(ii,1) x(ii,1)];               %# center

%# get circular mask
mask = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), imgH, imgW);

bwAll=[bwAll + mask];



end
%     maxIterations = 40; 
    [bw] = activecontour(I, bwAll, maxIterations, 'Chan-Vese');
 
%     imshow(immultiply(I,bw));
%     bwAll=immultiply(I,bw);


imshow( immultiply(I,bw) )
% figure, 
% hImg = imshow(I); set(hImg, 'AlphaData', bw);


end