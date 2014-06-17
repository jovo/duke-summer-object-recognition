function [ X,Y ] = CreateClassifierInputs( passDir, failDir)
%creates input for SVM classifier
%pass and fail are the filenames for the passing and failing cases
%all the files in pass and fail must be named train#.png
%make sure both folders are added to path
%make sure you are not in the directories for your current folder

fileP=dir(passDir);
[sizeP,temp1]=size(fileP);

fileF=dir(failDir);
[sizeF,temp2]=size(fileF);

X=[];
Y=[];

%making X
for i=1:1:sizeP;
    data=fileP(i);
    if isequal(strfind(data.name,'train'),[])==0 %name contains 'train'
        prop=RegionPropVector(strcat(passDir,'/',data.name));
        X=[X;prop];
        Y=[Y;[1]];
    end;
end;

for j=1:1:sizeF;
    data=fileF(j);
    if isequal(strfind(data.name,'train'),[])==0 %name contains 'train'
        prop=RegionPropVector(strcat(failDir,'/',data.name));
        X=[X;prop];
        Y=[Y;[0]];
    end;
end;

end

