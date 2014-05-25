close all
clear all
image = double(rgb2gray(imread('image.png')))/255;
image2 = double(rgb2gray(imread('image.png')))/255;
image3 = double(rgb2gray(imread('image.png')))/255;
image4 = double(rgb2gray(imread('image.png')))/255;
%image = (imread('image.png'));
mask = imread('colors2.png');%Be sure that this is a PNG!

%%%%%%%Green Highlighted Object%%%%%%%%%%%
RValue = 36;
GValue = 255;
BValue = 0;
%Create the binary mask for the chosen color
binaryMask = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;

%%%%%%%Pink Highlighted Object%%%%%%%%%%%
RValue = 214;
GValue = 23;
BValue = 194;
%Create the binary mask for the chosen color
binaryMask1 = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;


%%%%%%%Blue Highlighted Object%%%%%%%%%%%
RValue = 0;
GValue = 96;
BValue = 255;
%Create the binary mask for the chosen color
binaryMask2 = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;

%%%%%%%Red Highlighted Object%%%%%%%%%%%
RValue = 255;
GValue = 0;
BValue = 0;
%Create the binary mask for the chosen color
binaryMask3 = mask(:, :, 1) == RValue & mask(:, :, 2) == GValue & mask(:, :, 3) == BValue;





%%%Figures with Original Image, Mask, and Histogram%%%
%%%%%%%Green%%%%%%
figure;
subplot(2, 2,1);
imshow(image);
subplot(2, 2, 2);
image(binaryMask == 0) = 1;
imshow(image);
subplot(2, 1, 2);
hist(image(binaryMask == 1));

%%%%%%%Pink%%%%%%
figure;
subplot(2, 2,1);
imshow(image2);
subplot(2, 2, 2);
image2(binaryMask1 == 0) = 1;
imshow(image2);
subplot(2, 1, 2);
hist(image2(binaryMask1 == 1));

%%%%%%%Blue%%%%%%
figure;
subplot(2, 2,1);
imshow(image3);
subplot(2, 2, 2);
image3(binaryMask2 == 0) = 1;
imshow(image3);
subplot(2, 1, 2);
hist(image3(binaryMask2 == 1));

%%%%%%%Red%%%%%%
figure;
subplot(2, 2,1);
imshow(image4);
subplot(2, 2, 2);
image4(binaryMask3 == 0) = 1;
imshow(image4);
subplot(2, 1, 2);
hist(image4(binaryMask3 == 1));
