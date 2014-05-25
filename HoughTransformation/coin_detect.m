function [circimg, himg] = coin_detect(imfile, varargin)

% dist is the diatance between cells in the hough space of circle centers
% thresh define low and high thresholds for the canny edge detector
 
dist = 2;
thresh = [0.1 0.45];

if (nargin > 2)
  dist = varargin(1);
  thresh = varargin(2);
elseif (nargin > 1)
  if (size(varargin(1), 2) == 1)
    dist = varargin(1);
  elseif (size(varargin(1), 2) == 2)
    thresh = varargin(1);
  end
end

