function [circimg] = mark_circles(inimg, himg, rbv)

imsize = size(inimg);

circgray(1:imsize(1), 1:imsize(2)) = 0;

for rcount = 1:size(rbv,2)
  
  % thrshold hough space to get points with maximal chance of being 
  % the centers of a circle.
  % label the image and compute centroid of each point cluster
  % consider the centroids as the centers of the detected circles
  
  bwh = im2bw(himg(:,:,1,rcount), 0.67);
  bwh = imdilate(bwh, ones(3, 3));
  bwh = imerode(bwh, ones(3, 3));
  bwh = bwlabel(bwh);
  
  %stat = imfeature(bwh, 'Centroid'); 
  stat = regionprops(bwh, 'Centroid');
  
  for coin = 1:size(stat,1)
    center = stat(coin).Centroid;
    circgray = circgray + draw_circle(center, rbv(rcount), imsize);    
  end

end

circimg = im2double(inimg);
circimg(:,:,1) = circimg(:,:,1) + circgray;
%circimg(:,:,2) = circimg(:,:,2) + circgray;
%circimg(:,:,3) = circimg(:,:,3) + circgray;
circimg = imadjust(circimg, [0 1], [0 1]);
end