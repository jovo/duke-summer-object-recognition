function [bw]=activecontour_2(I, radius,maxIterations,y,x)
%This function takes an image or slide, and given centerpoints, and a
%radius, will use an active contour to find the boundaries of an object in
%the image.
%Inputs:
%                 I = some image/slide
%                 radius = radius of circle bounding  object before 
%                            contour is applied
%                 maxIterations= maximum number of iterations to perform when using contour

r=radius;
mask = true(size(I));

[imgH,imgW,~] = size(I);
bwAll=zeros(imgH, imgW);

%figure
for ii=1:length(y)

    % circle params
    t = linspace(0, 2*pi, 50);   % approximate circle with 50 points
    c = [y(ii,1) x(ii,1)];               % center

    % get circular mask
    mask = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), imgH, imgW);

    bwAll=[bwAll + mask];
end
 
[bw] = activecontour(I, bwAll, maxIterations, 'Chan-Vese');
 
end