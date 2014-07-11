function [ model ] = RFClassifierModel(X,Y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic

model=classRF_train(X,Y);

toc
end

