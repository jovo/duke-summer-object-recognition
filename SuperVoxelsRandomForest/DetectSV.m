function [ Imarked,RGBI,M,BW,mito] = DetectSV(SVCell,model,I)
%Detection of Mitochondria using Random Forest with Super Voxels
%Author: Joy Patel
%
%Input:
%
%SVCell: Cell of SuperVoxels (SuperVoxel class objects) which are to be classified
%model: Random Forest model used for mitochondria classification
%I: Image which the supervoxels are from
% 
% Output:
% Imasked: Image I marked with white contours at locations where
% mitochondria occur
% RGBI: Image I marked with different colored contours at locatoins where
% mitochondria are detected
% M: Black image of size I marked with the supervoxels where mitochondria
% are detected
% BW: Binary image of size I where mitochondria are detected
% mito: Cell of detected SuperVoxels where mitochondria occur
%

%ProjSV=getfield(load('ProjSV'),'ProjSV');

X=zeros(size(SVCell,2),size(SVCell{1,1}.FVector,2));
indX=1;
for i=1:1:size(SVCell,2)
    sv=SVCell{1,i};
    X(indX,:)=sv.FVector;
    indX=indX+1;
end;

%X=X*ProjSV;

[L,P]=classRF_predict(X,model);
mito={};
for i=1:1:size(L,1)
    %if P(i,2)/500>.45
    if L(i,1)==1
        mito{end+1}=SVCell{1,i};
    end;
end;
%disp(size(mito));

M=zeros(size(I));
BW=zeros(size(I));
for k=1:1:size(mito,2)
    coor=mito{1,k}.SVCoor;
    Inten=mito{1,k}.SVInt;
    for j=1:1:size(coor,1)
        y=coor(j,1);
        x=coor(j,2);
        M(y,x)=Inten(j);
        BW(y,x)=255;
%         if y+1<=size(I,1)
%             BW(y+1,x)=255;
%         end;
%         if y-1>=1
%             BW(y-1,x)=255;
%         end;
%         if x+1<=size(I,2)
%             BW(y,x+1)=255;
%         end;
%         if x-1>=1
%             BW(y,x-1)=255;
%         end;
    end;
end;

[ysz,xsz]=size(I);
temp=zeros(ysz,xsz,3);
temp(:,:,1)=I;
temp(:,:,2)=I;
temp(:,:,3)=I;
RGBI=double(temp/255);
labels=bwconncomp(BW,8);
output=labelmatrix(labels);
LColor=label2rgb(output);

for j=1:1:3
    for y=1:1:ysz
        for x=1:1:xsz
            if LColor(y,x,j)~=255
                RGBI(y,x,j)=LColor(y,x,j)/255;
            end;
        end;
    end;
end;

Imarked=uint8(BW+double(I));
BW=BW>0;
%C=I;
% CM=[];
% for i=1:1:size(mito,2)
%     sv=mito{1,i};
%     coor=sv.SVCoor;
%     Centroid=double(sum(coor))/size(coor,1);
%     yC=round(Centroid(1,1));
%     xC=round(Centroid(1,2));
%     CM=[CM;[yC,xC]];
%    maxD=0;
%     for j=1:1:size(coor,1)
%         y=coor(j,1);
%         x=coor(j,2);
%         D=(y-yC)*(y-yC)+(x-xC)*(x-xC);
%         if D>maxD
%             maxD=D;
%         end;
%     end;
%    disp(maxD);
%    disp([yC,xC]);
%    bwcont=255*activecontour_2(I,round(sqrt(maxD))+1,25,xC,yC);
%     bwcont=255*activecontour_2(I,20,20,xC,yC);
%     C=uint8(bwcont+double(C));
%end;

% y=CM(:,2);
% x=CM(:,1);
% C=activecontour_2(I,20,20,y,x);

%figure, imshow(C);

end

