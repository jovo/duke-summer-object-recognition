% GABOR_FILT - applies multiple gabor filters to image
%
% Usage:
%  [Eim, Oim, Aim] =  gabor_filt(im, wavelength, angle, kx, ky, showfilter)
%
% Arguments:
%         im         - Image to be processed.
%         wavelength - Wavelength in pixels of Gabor filter to construct.
%         The larger the wavelength, the stronger the gabor filter
%         startangle - Angle to start with. Good idea to start with 0.
%         angle      - Angle to be added to previous angle.  The smaller
%         the angle, the more filters you are applying to your image.
%         kx, ky     - Scale factors specifying the filter sigma relative
%                      to the wavelength of the filter.  This is done so
%                      that the shapes of the filters are invariant to the
%                      scale.  kx controls the sigma in the x direction
%                      which is along the filter, and hence controls the
%                      bandwidth of the filter.  ky controls the sigma
%                      across the filter and hence controls the
%                      orientational selectivity of the filter. 



%     For those using     AC4_matrices.mat, here's a good example script:
% 
%     close all
%     clear all
%     struct=load('AC4_matrices.mat');
%     field=getfield(struct,'imageAC4');
%     grayI=mat2gray(field);
%     slide=10;  %%%%Slide to apply Gabor Filters to%%%%
%     I= grayI(:,:,slide);
% 
%     gabor_filt(I, 8, 0, 10, 0.12, 0.12);


% 
% Returns:
%         Eim - Result from filtering with the even (cosine) Gabor filter
%         Oim - Result from filtering with the odd (sine) Gabor filter
%         Aim - Amplitude image = sqrt(Eim.^2 + Oim.^2)
% 
% Figures:
%         (Optional) Figure of original slide with one-angle filter
%         Figure of original slide
%         Figure of original slide with even gabor filters

% New Code by: 
% Courtney Smith
% csmith89@uwyo.edu
% June 2014


% (Derived from code by:
% Peter Kovesi  
% School of Computer Science & Software Engineering
% The University of Western Australia
% pk at csse uwa edu au
% http://www.csse.uwa.edu.au/~pk
% 
% October 2006)

function [Eim, Oim, Aim] = gabor_filt(im, wavelength, startangle, angle, kx, ky)

   %%%%How many filters you will end up having%%%%
    N=180/angle;
    
    
    
    im = double(im);
    [rows, cols] = size(im);
    newim = zeros(rows,cols);
    
    % Construct even and odd Gabor filters
    sigmax = wavelength*kx;
    sigmay = wavelength*ky;
    
    sze = round(3*max(sigmax,sigmay));
    [x,y] = meshgrid(-sze:sze);
    evenFilter1 = exp(-(x.^2/sigmax^2 + y.^2/sigmay^2)/2)...
	     .*cos(2*pi*(1/wavelength)*x);
    
    oddFilter1 = exp(-(x.^2/sigmax^2 + y.^2/sigmay^2)/2)...
	     .*sin(2*pi*(1/wavelength)*x); 
    evenFilter = zeros(size(evenFilter1,1), size(evenFilter1,2),N);
    oddFilter = zeros(size(oddFilter1,1), size(oddFilter1,2),N);
    %%%%Creating Filters%%%%
     for i=1:N
         ang=startangle + angle.*(i-1);
    evenFilter(:,:,i) = imrotate(evenFilter1, ang, 'bilinear', 'crop');
    size(evenFilter(i));
    oddFilter(:,:,i) = imrotate(oddFilter1, ang, 'bilinear', 'crop');  
    
    %%%%Filtering%%%%
    if i==1
    Eim(:,:,1) = filter2(evenFilter(:,:,1),im,'same');
    Oim(:,:,1) = filter2(oddFilter(:,:,1),im,'same');
    else
        Eim(:,:,1) = filter2(evenFilter(:,:,1),im,'same');
    Eim(:,:,i) = filter2(evenFilter(:,:,i),Eim(:,:,i-1),'same');% Even filter result
    Oim(:,:,i) = filter2(oddFilter(:,:,i),Oim(:,:,i-1),'same');  % Odd filter result
    Aim = sqrt(Eim(i).^2 + Oim(i).^2);  % Amplitude 
    end

     end
    
  %%% Show specific filters on slide (Optional)%%%
%     Eim = filter2(evenFilter(:,:,1),im,'same');
%     figure, imshow(Eim); title('evenfilter');
%     Oim = filter2(abs(oddFilter(:,:,2)),im,'same');
%     figure, imshow(Oim); title('oddfilter');
%     
    %%%%Shows Original Slide with Even Gabor Filters%%%%
 %figure, imshow(im);
 %figure, imshow(Eim(:,:,N), [min(Eim(:)),max(Eim(:))]); title('filterEIM');

    end
    
    