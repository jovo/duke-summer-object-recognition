function [ propMat ] = RegionPropVector( image )
%Makes a vector with needed region prop values for SVM

I=255-imread(image);
BW=im2bw(I);

area=regionprops(BW,'Area');
areaMat=cell2mat(struct2cell(area));
[r,c]=size(areaMat);
areaMax=max(areaMat);
ind=1;
while true;
    if areaMat(1,ind)==areaMax
        break;
    end;
    ind=ind+1;
end;

allProp=regionprops(BW,'Area','MajorAxisLength','MinorAxisLength','Eccentricity','ConvexArea','FilledArea','EulerNumber','EquivDiameter','Solidity','Extent','Perimeter','PerimeterOld');
desired=allProp(ind);
propMat=cell2mat(struct2cell(desired));
%result=max(propMat);


end

