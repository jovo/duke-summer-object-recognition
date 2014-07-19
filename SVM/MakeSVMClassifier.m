function [ svm ] = MakeSVMClassifier(centroids,passCell, failCell)
%trains classifier
%X info is NxM matrix where N is samples and M is features
%Y classification is matrix of logicals corresponding to true/false cases
tic
[X,Y]=BOWClassifierInputs(centroids,passCell,failCell);
toc

%model = fitcsvm(info, classification, 'Standardize', true, 'ClassNames', logical([0,1]));
tic
model=fitcsvm(X,Y,'Standardize',true);
svm = fitSVMPosterior(model);
toc

end

