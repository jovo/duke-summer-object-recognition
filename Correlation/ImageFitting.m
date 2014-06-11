%image representing F(x,y)
I1=imread('CroppedCircles.png');
grayF=double(rgb2gray(I1));

figure, imshow(uint8(grayF));

[xMax, yMax]=size(grayF);
mini=50;
for X=41:1:xMax;
    for Y=41:1:yMax;
        [grayF,mini]=multiplyingMask(grayF, X, Y, 20, mini, .00053);
        disp(mini);
    end;
end;

figure, imshow(uint8(grayF));
