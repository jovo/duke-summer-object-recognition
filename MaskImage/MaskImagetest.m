close all
clear all
image = double(rgb2gray(imread('image.png')))/255;
%image = (imread('image.png'));
mask = imread('colors2.png');%Be sure that this is a PNG!
% %%%%%%%Green Highlighted Object%%%%%%%%%%%
% RValue = 36;
% GValue = 255;
% BValue = 0;
% %Create the binary mask for the chosen color
% binaryMask = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;

% %%%%%%%Pink Highlighted Object%%%%%%%%%%%
% RValue = 214;
% GValue = 23;
% BValue = 194;
% %Create the binary mask for the chosen color
% binaryMask = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;

% %%%%%%%Blue Highlighted Object%%%%%%%%%%%
% RValue = 0;
% GValue = 96;
% BValue = 255;
% %Create the binary mask for the chosen color
% binaryMask = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;

%%%%%%%Red Highlighted Object%%%%%%%%%%%
RValue = 255;
GValue = 0;
BValue = 0;
%Create the binary mask for the chosen color
binaryMask = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;


%Make a random image and show how to mask out a section of it
subplot(1, 2, 1);
imshow(image);
subplot(1, 2, 2);
image(binaryMask == 0) = 0;
imshow(image);
% subplot(1, 3, 3);
% image(binaryMask1 == 0) = 0;
% imshow(image);

%Show how to make a histogram of stuff within the mask
figure;
hist(image(binaryMask == 1));

% figure;
% hist(image(binaryMask1 == 1));