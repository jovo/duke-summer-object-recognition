function [ svm ] = trainMitochondriaClassifier(info, classification)
%trains classifier
%info is NxM matrix where N is samples and M is features
%classification is matrix of logicals corresponding to true/false cases

%tic

%model = fitcsvm(info, classification, 'Standardize', true, 'ClassNames', logical([0,1]));
model=fitcsvm(info,classification,'Standardize',true);
svm = fitSVMPosterior(model);

%toc

end

