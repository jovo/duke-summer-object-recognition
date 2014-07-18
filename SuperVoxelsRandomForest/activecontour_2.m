% close all
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
%figure, imshow(I);
% [IDX, C]=kmeans(double(I),2);
%disp('Choose center points');
%[y x]=getpts;
mask = true(size(I));

%close


[imgH,imgW,~] = size(I);
bwAll=zeros(imgH, imgW);

%figure
for ii=1:length(y)

% circle params
t = linspace(0, 2*pi, 50);   % approximate circle with 50 points
% r = 30;                      % radius
c = [y(ii,1) x(ii,1)];               % center

% get circular mask
mask = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), imgH, imgW);

bwAll=[bwAll + mask];


end

%figure, imshow(bwAll);
%     maxIterations = 40; 
[bw] = activecontour(I, bwAll, maxIterations, 'Chan-Vese');
 
%     imshow(immultiply(I,bw));
%     bwAll=immultiply(I,bw);

%result=bw;
%figure,


%L = repmat(I, [1, 1, 3]);
%L(:, :, 2:3) = L(:, :, 2:3) - repmat(immultiply(I,bw), [1, 1, 2]);


%Numerical precision: clamp to region [0, 1]
% L(L < 0) = 0;
% L(L > 1) = 1;
%imagesc(L);

% imshow( immultiply(I,bw) )
% figure, 
% hImg = imshow(I); set(hImg, 'AlphaData', bw);


end