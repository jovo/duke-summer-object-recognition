######################################################

######################################################
#    ReadMe
#
# Author: Courtney Smith
# Duke University, Summer Research
# email: csmith89@uwyo.edu
#
#                       Revision History
# Author            Date                Comment
# C.Smith      11-Jun-2014          Initial Release
#
#####################################################



###################### Overview ######################

Applies multiple gabor filters to image.  (Number of filters depends on size of angle given,
for example an angle of 10 (degrees) will apply 18 filters (for 180 degrees).


######################  Usage ###################### 
Usage:
 [Eim, Oim, Aim] =  gabor_filt(im, wavelength, angle, kx, ky, showfilter)

Inputs:
        im         - Image to be processed.
        wavelength - Wavelength in pixels of Gabor filter to construct.
        The larger the wavelength, the stronger the gabor filter
        startangle - Angle to start with. Good idea to start with 0.
        angle      - Angle to be added to previous angle.  The smaller
        the angle, the more filters you are applying to your image.
        kx, ky     - Scale factors specifying the filter sigma relative
                     to the wavelength of the filter.  This is done so
                     that the shapes of the filters are invariant to the
                     scale.  kx controls the sigma in the x direction
                     which is along the filter, and hence controls the
                     bandwidth of the filter.  ky controls the sigma
                     across the filter and hence controls the
                     orientational selectivity of the filter. 

Returns:
        Eim - Result from filtering with the even (cosine) Gabor filter
        Oim - Result from filtering with the odd (sine) Gabor filter
        Aim - Amplitude image = sqrt(Eim.^2 + Oim.^2)

Figures:
        (Optional) Figure of original slide with one-angle filter
        Figure of original slide
        Figure of original slide with even gabor filters




###################### Examples ######################

    For those using     AC4_matrices.mat, here's are two example scripts:


%%%%%%%%%%%%%%%%%%Gabor Filters on full slide%%%%%%%%
close all
clear all
struct=load('AC4_matrices.mat');
field=getfield(struct,'imageAC4');
grayI=mat2gray(field);
slide=10;
I= grayI(:,:,slide);
 
gabor_filt(I, 8, 0, 10, 0.12, 0.12);






%%%%%%%%%%%%%%%%%Gabor Filters on cropped slide%%%%%%%%


 close all
clear all
struct=load('AC4_matrices.mat');
field=getfield(struct,'imageAC4');
grayI=mat2gray(field);
slide=10;
I= grayI(:,:,slide);
figure, imshow(I); 
%%%%Select an area in the image you would like to work in%%%%
%%%%(Such as an area around a mitochondria)%%%%%%
[y,x]=getpts;
x1=min(x)
x2=max(x)
y1=min(y)
y2=max(y)

close
I = double(grayI(x1:x2, y1:y2, slide));
gabor_filt(I, 8, 0, 10, 0.12, 0.12);



###################### Notes ######################
(Derived from code by:
Peter Kovesi  
School of Computer Science & Software Engineering
The University of Western Australia
pk at csse uwa edu au
http://www.csse.uwa.edu.au/~pk

October 2006)







