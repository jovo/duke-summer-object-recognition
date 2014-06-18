function [ V ] = MakeTrainingKMeans( dirName )
%PassFile and FailFile are the folder names for the passing and failing 
%mitochondria test cases
%output is PassV which are matrices of R25 row vectors to be used
%with kmeans

file=dir(dirName);
[sizeP,temp1]=size(file);

% fileF=dir(failDir);
% [sizeF,temp2]=size(fileF);

V=[];
for i=1:1:sizeP;
    data=file(i);
    if isequal(strfind(data.name,'train'),[])==0 %name contrains 'train'
        R25VMatrix=MakeR25Vectors(strcat(dirName,'/',data.name));
        V=[V;R25VMatrix];
    end;
end;

% FailV=[];
% for j=1:1:sizeF;
%     data=fileF(j);
%     if isequal(strfind(data.name,'train'),[])==0 %name contrains 'train'
%         R25VMatrix=MakeR25Vectors(strcat(failDir,'/',data.name));
%         FailV=[FailV;R25VMatrix];
%     end;
% end;


end

