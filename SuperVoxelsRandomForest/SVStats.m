function [MGm,...
    M3,V3,Md3,Pcr253,Pcr753,MGm3,...
    M6,V6,Md6,Pcr256,Pcr756,MGm6,...
    M9,V9,Md9,Pcr259,Pcr759,MGm9,...
    MMore,VMore,MdMore,Pcr25More,Pcr75More,MGmMore,...
    H]...
    =SVStats( SVCoor, SVInt ,Gmag)
%Outputs properties for SuperVoxel Class.
% M=mean, V=Variance, H=Histogram
%   Detailed explanation goes here


I3=[];
I6=[];
I9=[];
IMore=[];
G3=[];
G6=[];
G9=[];
GMore=[];
H=zeros(1,26);

Centroid=double(sum(SVCoor))/size(SVCoor,1);
yC=round(Centroid(1,1));
xC=round(Centroid(1,2));

GM=zeros(size(SVCoor,1),1);
for i=1:1:size(SVCoor,1)
    IV=SVInt(i,1);
    ind=floor(IV/10)+1;
    H(1,ind)=H(1,ind)+1;
    gm=Gmag(round(SVCoor(i,1)),round(SVCoor(i,2)));
    GM(i,1)=gm;
    y=SVCoor(i,1)-yC;
    x=SVCoor(i,2)-xC;
    if x*x+y*y>=0 && x*x+y*y<=9 
        I3=[I3,IV];
        G3=[G3,gm];
    elseif x*x+y*y>=9 && x*x+y*y<=36
        I6=[I6,IV];
        G6=[G6,gm];
    elseif x*x+y*y>=36 && x*x+y*y<=81
        I9=[I9,IV];
        G9=[G9,gm];
    elseif x*x+y*y>=81
        IMore=[IMore,IV];
        GMore=[GMore,gm];
    end;
end;

H=H/sum(H);
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

