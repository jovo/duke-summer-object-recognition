function [ CodeBook ] = MakeCodeBook( R100MatFull )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic
CodeBook=vl_kmeans(double(R100MatFull)',100);
CodeBook=CodeBook';
toc
end

