function [imSlice,BW,SVCell] = SuperVoxelize(I,CodeBook)
% Mainly outputs SuperVoxels which will undergo Random Forest machine learning
% detection.  
%
% Inputs:
% I: Image to undergo SuperVoxel transform
%
% CodeBook: codebook matrix for generating Bag-of-Words features for
% SuperVoxel class
%
% Output:
% imSlice: image I with SuperVoxel boundaries
%
% BW: Binary image of SuperVoxel boundaries
% 
% SVCell: Cell of SuperVoxel objects which will undergo machine learning
% predict

%% make image into SuperVoxels
% Supervoxels require preprocessing
imSeg = zeros(size(I));

[ysz,xsz]=size(I);
BW=ones(ysz,xsz);

imSlice = I;

% Bilateral Filtering
% filter parameters
sigma1 = 20;
sigma2 = 20;
tol    = 0.01;

% make odd
if (mod(sigma1,2) == 0)
    w  = sigma1 + 1;
else
    w  = sigma1;
end
warning('off');
[outImg, param] =  shiftableBF(double(imSlice), sigma1, sigma2, w, tol);
warning('on');
outImg = single(outImg)/255;
outImg(:,:,2) = outImg(:,:,1);
outImg(:,:,3) = outImg(:,:,1);

%Ready for SLIC
imSeg = vl_slic(outImg, 25, 1);
%imSeg = vl_slic(outImg, 15, 1);

[sx,sy]=vl_grad(double(imSeg), 'type', 'forward');
s = find(sx | sy);
imSlice(s) = 0;
BW(s)=0;

%% Make SuperVoxel objects
%[labelMat,numCC]=bwlabel(BW, 4);
imSeg=imSeg+1; % make non-zero
numCC=max(max(imSeg));
SVCell=cell(1,numCC); %cell fo SuperVoxels
cur=1;
[Gmag,Gdir]=imgradient(I);
while cur<=numCC;
    %SV=labelMat==cur;
    SV=imSeg==cur;
    [y,x]=find(SV);
    SVCoor=[y,x];
    SVInt=zeros(size(SVCoor,1),1);
    for j=1:1:size(SVCoor,1);
        yt=SVCoor(j,1);
        xt=SVCoor(j,2);
        SVInt(j,1)=I(yt,xt);
    end;
    MedI=median(SVInt);
    if MedI<=170 & MedI>=30 & size(SVCoor,1)>10 & size(SVCoor,2)==2
        SV=SuperVoxel(SVCoor,SVInt,I,CodeBook,Gmag);
        if isequal(find(isnan(SV.FVector)),zeros(1,0))
            SVCell{1,cur}=SV;
        end;
    end;
    cur=cur+1;
end;

SVCell=SVCell(~cellfun(@isempty, SVCell));

end