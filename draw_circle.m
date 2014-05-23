function [circle] = draw_circle(center, radius, imgsize)

% draws a circle given the center and radius and the size of image
% to return.

xsize = imgsize(2);
ysize = imgsize(1);

circle(1:ysize, 1:xsize) = 0;

for theta=1:1:360

  pt = center + radius * [cos(theta*pi/180) sin(theta*pi/180)];
  xp = fastsearch(pt(1), 1, xsize, 1);
  yp = fastsearch(pt(2), 1, ysize, 1);
  
  if ((xp ~= 0) && (yp ~= 0))
    circle(yp, xp) = 1.0;
  end

end