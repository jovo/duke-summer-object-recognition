function [himg] = hough_circle(edgeimage, xbinvec, ybinvec, rbinvec)

% computes the hough transform

% xbins, ybins and rbins are the number of bins in hough space
xbins = size(xbinvec, 2);
ybins = size(ybinvec, 2);
rbins = size(rbinvec, 2);

% a, d are the first term and common difference for the A.P. formed 
% by xbinvec and ybinvec which are cells in the h-space of circle centers 
xa = xbinvec(1);
ya = ybinvec(1);
xd = xbinvec(2) - xa;
yd = ybinvec(2) - ya;

% rows, cols contain edge pixel co-ordinates
[rows, cols] = find(edgeimage);

% hspace is our accumulator array
hspace(1:ybins, 1:xbins, 1, 1:rbins) = 0;

fprintf('xbins %d ybins %d rbins %d\n', xbins, ybins, rbins);
fprintf('edge pixels %d\n', size(rows, 1));

for ecount = 1:size(rows, 1) 
  %fprintf('edge pixels processed:  %d\t total: %d\n', ecount, size(rows,1));
  xp = cols(ecount);
  yp = rows(ecount);
  
  for rcount = 1:rbins
    radius = rbinvec(rcount);
    rsqr = radius * radius;
    
    xstart = fastsearch(xp-(radius/sqrt(2)), xa, xbins, xd, 1);
    xfinish = fastsearch(xp+(radius/sqrt(2)), xa, xbins, xd, 1);
    ystart = fastsearch(yp-(radius/sqrt(2)), ya, ybins, yd, 1);
    yfinish = fastsearch(yp+(radius/sqrt(2)), ya, ybins, yd, 1);
    
    %fill cells along x-axis spanning an angle starting 45 degrees to the 
    %left of the vertical and ending 45 degrees to the right of vertical
    for xcount = xstart:xfinish
             	 
      xc = xbinvec(xcount);
      
      xsqr = (xp - xc)*(xp - xc);
      
      if (rsqr >= xsqr)
	ysqrt = sqrt(rsqr - xsqr);
		
	yc = yp + ysqrt;
	ycount = fastsearch(yc, ya, ybins, yd);	
	if (ycount ~= 0)
	  acc_count = hspace(ycount, xcount, 1, rcount);
	  hspace(ycount, xcount, 1, rcount) = acc_count + 1;
	end
	
	yc = yp - ysqrt;
	ycount = fastsearch(yc, ya, ybins, yd);
	if (ycount ~= 0)
	  acc_count = hspace(ycount, xcount, 1, rcount);
	  hspace(ycount, xcount, 1, rcount) = acc_count + 1;
	end
 
      end	
    
    end %for xcount
    
    
    %fill cells along y-axis spanning an angle starting 45 degrees
    %above the horizontal and ending 45 degrees below the horizontal 
    for ycount = ystart:yfinish
        	 
      yc = ybinvec(ycount);
      
      ysqr = (yp - yc)*(yp - yc);
      
      if (rsqr >= ysqr)
	xsqrt = sqrt(rsqr - ysqr);
	
	xc = xp + xsqrt;
	xcount = fastsearch(xc, xa, xbins, xd);
	if (xcount ~= 0)
	  acc_count = hspace(ycount, xcount, 1, rcount);
	  hspace(ycount, xcount, 1, rcount) = acc_count + 1;
	end
	
	xc = xp - xsqrt;
	xcount = fastsearch(xc, xa, xbins, xd);
	if (xcount ~= 0)
	  acc_count = hspace(ycount, xcount, 1, rcount);
	  hspace(ycount, xcount, 1, rcount) = acc_count + 1;
	end
 
      end	
    
    end %for ycount
  
  end

end
  
% rescale the hough image to original size by interpolation
for rcount = 1:rbins
  himg(:, :, 1, rcount) = imresize(hspace(:, :, 1, rcount), yd, 'bicubic');
  himg(:, :, 1, rcount) = himg(:, :, 1, rcount)/max(max(himg(:, :,  1, rcount)));
end  
