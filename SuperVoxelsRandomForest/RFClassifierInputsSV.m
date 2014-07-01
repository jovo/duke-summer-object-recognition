function [X,Y] = RFClassifierInputsSV(mito,notMito)
%Creates inputs for Random Forest Classifier
%   Detailed explanation goes here

X=[];
Y=[];

for i=1:1:size(mito,2)
    SV=mito{1,i};
    FV=SV.FVector;
    X=[X;FV];
    Y=[Y;[1]];
end;

for i=1:1:size(notMito,2)
    SV=notMito{1,i};
    FV=SV.FVector;
    X=[X;FV];
    Y=[Y;[0]];
end;

end

