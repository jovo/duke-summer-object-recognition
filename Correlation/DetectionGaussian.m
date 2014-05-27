%image representing F(x,y)
I1=imread('image.png');
grayF=double(rgb2gray(I1));

disp(gaussmf(-4,[25, 1]));

%figure, imshow(uint8(grayF));

[xMax, yMax]=size(grayF);

solution=[];

for X=1:xMax/4;
    for Y=1:yMax/4;
        correlation=correlationGaussian(grayF, X, Y, 2.5);
        solution(X,Y)=correlation;
        if correlation>300000
            disp(correlation);
            grayF(X,Y)=255;
        end;
    end;
end;

figure, imshow(uint8(grayF));

