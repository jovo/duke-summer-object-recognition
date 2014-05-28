%image representing F(x,y)
I1=imread('QuarterImage.png');
grayF=double(rgb2gray(I1));

figure, imshow(uint8(grayF));

[xMax, yMax]=size(grayF);
mini=1;
for X=41:1:xMax;
    for Y=41:1:yMax;
        [grayF,mini]=correlationGaussian(grayF, X, Y, 20, mini, .00055);
        %disp(mini);
    end;
end;

figure, imshow(uint8(grayF));
