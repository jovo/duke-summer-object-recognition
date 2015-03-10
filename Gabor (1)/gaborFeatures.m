function [gaborFeatureVect] = gaborFeatures(img,gaborArray,d1,d2)
tic
% GABORFEATURES extracts the Gabor features of the image.
% It creates a column vector, consisting of the image's Gabor features.
% The feature vectors are normalized to zero mean and unit variance.
%
%
% Inputs:
%       img         :	Matrix of the input image 
%       gaborArray	:	Gabor filters bank created by the function gaborFilterBank
%       d1          :	The factor of downsampling along rows.
%                       d1 must be a factor of n if n is the number of rows in img.
%       d2          :	The factor of downsampling along columns.
%                       d2 must be a factor of m if m is the number of columns in img.
%               
% Output:
%         gaborFeatureVect: 
%                             A column vector with length (u*v*5).
%                             This vector holds the the mean, median, variance, 
%                             the 25th and 75th percentile of the image mean for
%                             u*v images (conv. with gabor atoms).
%       featureVector	:   A column vector with length (m*n*u*v)/(d1*d2). 
%                           This vector is the Gabor feature vector of an 
%                           m by n image. u is the number of scales and
%                           v is the number of orientations in 'gaborArray'.
%
%
% Sample use:
% 
% img = imread('cameraman.tif');
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank
% gaborFeatureVect = gaborFeatures(img,gaborArray,1,1);   % Extracts Gabor feature vector.
% 
% Original Script from:
%  
%   
%   M. Haghighat, S. Zonouz, M. Abdel-Mottaleb, "Identification Using 
%   Encrypted Biometrics," Computer Analysis of Images and Patterns, 
%   Springer Berlin Heidelberg, pp. 440-448, 2013.
% 
% 
% (C)	Mohammad Haghighat, University of Miami
%       haghighat@ieee.org
%       I WILL APPRECIATE IF YOU CITE OUR PAPER IN YOUR WORK.


if (nargin ~= 4)    % Check correct number of arguments
    error('Use correct number of input arguments!')
end

if size(img,3) == 3	% % Check if the input image is grayscale
    img = rgb2gray(img);
end

img = double(img);


%% Filtering

% Filter input image by each Gabor filter
[u,v] = size(gaborArray);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = conv2(img,gaborArray{i,j},'same');
        % J{u,v} = filter2(G{u,v},I);
    end
end


% %% Feature Extraction
% 
% % Extract feature vector from input image
% [n,m] = size(img);
% s = (n*m)/(d1*d2);
% l = s*u*v;
% featureVector = zeros(l,1);
% c = 0;
% for i = 1:u
%     for j = 1:v
%         
%         c = c+1;
%         gaborAbs = abs(gaborResult{i,j});
%         gaborAbs = downsample(gaborAbs,d1);
%         gaborAbs = downsample(gaborAbs.',d2);
%         gaborAbs = reshape(gaborAbs.',[],1);
%         
%         % Normalized to zero mean and unit variance. (if not applicable, please comment this line)
%         gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
%         
%         featureVector(((c-1)*s+1):(c*s)) = gaborAbs;
%         
%     end
% end
%% New Feature Extraction

gaborFeatureVect=[];

q=0;
B=reshape(gaborResult.',u*v,1);
for ii=1:length(B)
    gaborFeatureVect=[gaborFeatureVect;mean(mean(B{ii,1}))];
    gaborFeatureVect=[gaborFeatureVect;var(var(double(B{ii,1})))];
    gaborFeatureVect=[gaborFeatureVect;median(median(B{ii,1}))];
    gaborFeatureVect=[gaborFeatureVect;prctile(mean(B{ii,1}),25)];
    gaborFeatureVect=[gaborFeatureVect;prctile(mean(B{ii,1}),75)];
end

gaborFeatureVect=abs(gaborFeatureVect);
 toc


% %% Show filtered images
% 
% % Show real parts of Gabor-filtered images
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(real(gaborResult{i,j}),[]);
%     end
% end
% 
% 
% % Show magnitudes of Gabor-filtered images
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(abs(gaborResult{i,j}),[]);
%     end
% end

% %% Show filtered image
% 
% % Show real parts of Gabor-filtered images
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
%    
%         imshow(real(gaborResult{2,4}),[]);
% 
% 
% 
% % Show magnitudes of Gabor-filtered images
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
%        
%     
%         imshow(abs(gaborResult{2,4}),[]);
end