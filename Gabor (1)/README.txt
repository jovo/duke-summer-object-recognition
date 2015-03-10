{\rtf1\ansi\ansicpg1252\cocoartf1265\cocoasubrtf200
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural

\f0\fs24 \cf0 ######################################################\
# (c) 2014 Duke University RTG\
#  All Rights Reserved.\
######################################################\
#    ReadMe\
#\
# Author: Courtney Smith\
# \
# email: csmith89@uwyo.edu\
#\
\
#####################################################\
% Original Script from:\
%  \
%   \
%   M. Haghighat, S. Zonouz, M. Abdel-Mottaleb, "Identification Using \
%   Encrypted Biometrics," Computer Analysis of Images and Patterns, \
%   Springer Berlin Heidelberg, pp. 440-448, 2013.\
% \
% \
% (C)	Mohammad Haghighat, University of Miami\
%       haghighat@ieee.org\
\
\
###################### Overview ######################\
\
This computes gabor filters to convolve with images, and returns a feature vector including:\
mean\
variance\
median\
25th and 75th percentile of the mean\
\
\
\
\
###################### Examples ######################\
% img=imread(\'91mito.png\'92); %%%Use your own image here\
% gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank\
% gaborFeatureVect = gaborFeatures(img,gaborArray,1,1);   % Extracts Gabor feature vector.\
\
\
\
###################### Notes ######################\
\
\
\
}