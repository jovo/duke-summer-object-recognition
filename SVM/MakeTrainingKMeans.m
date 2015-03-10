function [ V ] = MakeTrainingKMeans( cellM )
%cellM for mitochondria training cases
%output is V which are matrices of R100 row vectors to be used
%with kmeans
tic
V=[];
sz=size(cellM,2);
for i=1:1:sz;
    R100VMatrix=MakeR100Vectors(cellM{1,i});
    V=[V;R100VMatrix];
end;
toc
% file=dir(dirName);
% [sizeP,temp1]=size(file);

% fileF=dir(failDir);
% [sizeF,temp2]=size(fileF);

% V=[];
% for i=1:1:sizeP;
%     data=file(i);
%     if isequal(strfind(data.name,'train'),[])==0 %name contrains 'train'
%         R25VMatrix=MakeR25Vectors(strcat(dirName,'/',data.name));
%         V=[V;R25VMatrix];
%     end;
% end;



end

