function [MGm,...
    M3,V3,Md3,Pcr253,Pcr753,MGm3,...
    M6,V6,Md6,Pcr256,Pcr756,MGm6,...
    M9,V9,Md9,Pcr259,Pcr759,MGm9,...
    MMore,VMore,MdMore,Pcr25More,Pcr75More,MGmMore,...
    H]...
    =SVStats( SVCoor, SVInt ,Gmag)

% Outputs feature vector features for SuperVoxel class.
% Author: Joy Patel (Summer 2014)
% 
% Inputs:
% SVCoor: SVCoor from SuperVoxel class 
%
% SVInt: SVInt from SuperVoxel class
%
% Gmag: matrix of image gradient magnitudes for image in which Super Voxels
% are being created
%
% Outputs:
% MGm: mean image gradient magnitude of SuperVoxel
%
% Mn: Mean grayscale value taken from a annulus of radius (n-3)-to-n pixels 
% from center of SuperVoxel; "More" implies annulus is of radius 9+ pixels
% 
% Vm: Variance grayscale value taken from a annulus of radius (n-3)-to-n 
% pixels from center of SuperVoxel; "More" implies annulus is of radius 9+ 
% pixels
% 
% Mdn: Median grayscale value taken from a annulus of radius (n-3)-to-n 
% pixels from center of SuperVoxel; "More" implies annulus is of radius 9+ 
% pixels
%
% Pcr25n: 25th percentile grayscale value taken from a annulus of radius 
% (n-3)-to-n pixels from center of SuperVoxel; "More" implies annulus is of
% radius 9+ pixels
%
% Pcr75n: 75th percentile grayscale value taken from a annulus of radius 
% (n-3)-to-n pixels from center of SuperVoxel; "More" implies annulus is of
% radius 9+ pixels
%
% MGmn: Mean gradient magnitude grayscale value taken from a annulus of radius 
% (n-3)-to-n pixels from center of SuperVoxel; "More" implies annulus is of
% radius 9+ pixels
%

% In: grayscale values taken from an annulus of radius (n-3)-to-n pixels 
% from center of SuperVoxel; "More" implies annulus is of
% radius 9+ pixels 
I3=zeros(1,size(SVCoor,1)); I6=zeros(1,size(SVCoor,1)); 
I9=zeros(1,size(SVCoor,1)); IMore=zeros(1,size(SVCoor,1));
% First zero index
I3i=1; I6i=1; I9i=1; IMi=1;

% GM: image gradient values of SuperVoxel
GM=zeros(size(SVCoor,1),1);
% Gn: In: image gradient magnitude values taken from an annulus of radius 
% (n-3)-to-n pixels from center of SuperVoxel; "More" implies annulus is of
% radius 9+ pixels
G3=zeros(1,size(SVCoor,1)); G6=zeros(1,size(SVCoor,1)); 
G9=zeros(1,size(SVCoor,1)); GMore=zeros(1,size(SVCoor,1));
% First zero index
G3i=1; G6i=1;G9i=1; GMi=1; 

% Histogram vector
H=zeros(1,26);

% Center of SuperVoxel
Centroid=double(sum(SVCoor))/size(SVCoor,1);
yC=round(Centroid(1,1)); xC=round(Centroid(1,2));

for i=1:1:size(SVCoor,1)
    IV=SVInt(i,1); % Grayscale value
    ind=floor(IV/10)+1;
    H(1,ind)=H(1,ind)+1; % Update Histogram Vector
    
    yi=round(SVCoor(i,1)); xi=round(SVCoor(i,2));
    
    gm=Gmag(yi,xi); 
    GM(i,1)=gm; % Update gradient magnitude
            
    % Center of SuperVoxel
    y=yi-yC; x=xi-xC;
    
    % Update In and Gn
    if x*x+y*y>=0 && x*x+y*y<=9 
        I3(I3i)=IV;
        G3(G3i)=gm;
        I3i=I3i+1;
        G3i=G3i+1;
    elseif x*x+y*y>=9 && x*x+y*y<=36
        I6(I6i)=IV;
        G6(G6i)=gm;
        I6i=I6i+1;
        G6i=G6i+1;
    elseif x*x+y*y>=36 && x*x+y*y<=81
        I9(I9i)=IV;
        G9(G9i)=gm;
        I9i=I9i+1;
        G9i=G9i+1;
    elseif x*x+y*y>=81
        IMore(IMi)=IV;
        GMore(GMi)=gm;
        IMi=IMi+1;
        GMi=GMi+1;
    end;
end;

% Remove zeros
I3(:,all(~I3,1))=[];
I6(:,all(~I6,1))=[];
I9(:,all(~I9,1))=[];
IMore(:,all(~IMore,1))=[];

G3(:,all(~G3,1))=[];
G6(:,all(~G6,1))=[];
G9(:,all(~G9,1))=[];
GMore(:,all(~GMore,1))=[];

H=H/sum(H); % Normalize Histogram Vector

% Compute features
MGm=mean(GM);

M3=mean(I3);
V3=var(I3);
Md3=median(I3);
Pcr253=prctile(I3,25);
Pcr753=prctile(I3,75);
MGm3=mean(G3);

M6=mean(I6);
V6=var(I6);
Md6=median(I6);
Pcr256=prctile(I6,25);
Pcr756=prctile(I6,75);
MGm6=mean(G6);

M9=mean(I9);
V9=var(I9);
Md9=median(I9);
Pcr259=prctile(I9,25);
Pcr759=prctile(I9,75);
MGm9=mean(G9);

MMore=mean(IMore);
VMore=var(IMore);
MdMore=median(IMore);
Pcr25More=prctile(IMore,25);
Pcr75More=prctile(IMore,75);
MGmMore=mean(GMore);

end

