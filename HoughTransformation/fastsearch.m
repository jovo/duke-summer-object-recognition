function [count] = fastsearch(value, a, n, d, varargin)

% compute integer indices corresponding to nearest bin in which
% value falls.
% a - first element of the bin
% d - distance between values in adjacent bins
% n - number of bins
% nargin > 4 => saturate bin number if value is out of bounds
% else just return 0.

count = ((value - a)/d) + 1;
count = round(count);

if ((count < 1) || (count > n))
  if (nargin == 4)
    count = 0;
  elseif (count < 1)
    count = 1;
  elseif (count > n)
    count = n;
  end  
else
%  fprintf('%d %d %d %d %d\n',a, n, d, value, count);
end