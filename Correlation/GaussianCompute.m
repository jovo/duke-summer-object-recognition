function [ result ] = GaussianCompute( x, y, SD )
%Computes 2D Gaussian centered at origin

result=((2*pi*SD^2)^(-1))*exp((-1)*(x^2+y^2)/(2*SD^2));

end

