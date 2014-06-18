function [ svm ] = TrainMitochondriaClassifier(info, classification)
%trains classifier
%X info is NxM matrix where N is samples and M is features
%Y classification is matrix of logicals corresponding to true/false cases

%tic

%model = fitcsvm(info, classification, 'Standardize', true, 'ClassNames', logical([0,1]));
model=fitcsvm(info,classification,'Standardize',true);
svm = fitSVMPosterior(model);

%toc

end

