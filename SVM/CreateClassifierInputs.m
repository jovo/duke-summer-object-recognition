function [ X,Y ] = CreateClassifierInputs( pass, passNum, fail, failNum )
%creates input for SVM classifier
%pass and fail are the filenames for the passing and failing cases
%all the files in pass and fail must be names train#.png

X=zeros(passNum+failNum,12);
Y=zeros(passNum+failNum,1);

%making X
for i=1:1:passNum+failNum;
    if i<=passNum
        prop=RegionPropVector(strcat(pass,'/train',int2str(i),'.png'));
    else
        prop=RegionPropVector(strcat(fail,'/train',int2str(i-passNum),'.png'));
    end;
    for j=1:1:12;
        X(i,j)=prop(j,1);
    end;
end;

%making Y
for k=1:1:passNum;
    Y(k,1)=1;
end;

end

