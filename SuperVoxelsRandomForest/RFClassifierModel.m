function [ model ] = RFClassifierModel(X,Y)
% Make Random Forest model with default settings
% Inputs:
% X: matrix with rows as observations and columns as features
%
% Y: column matrix of category (1 for mitochondria, 0 for not-mitochondria)
%
% Output:
% model: Random Forest model
%
%%
tic

model=classRF_train(X,Y);

toc
end

