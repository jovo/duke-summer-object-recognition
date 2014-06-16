struct=load('AC4_matrices.mat');
field=getfield(struct,'imageAC4');
allI=mat2gray(field);
grayI=double(allI(:,:,1));

crop=255-rgb2gray(imread('crop3.png'));

cBW=im2bw(crop);
figure,imshow(cBW);

area=regionprops(cBW,'Area');
areaMat=cell2mat(struct2cell(area));
disp(areaMat);
maxi=max(areaMat)
size(crop)

all=regionprops(cBW,'All');