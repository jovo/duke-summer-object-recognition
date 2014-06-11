function [ result ] = NormalizeImage( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

maxi=max(max(image));
mini=min(min(image));

result=(image-mini)*(255)/(maxi-mini);
end

