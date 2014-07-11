function [MGm,...
    M3,V3,Md3,Pcr253,Pcr753,MGm3,...
    M6,V6,Md6,Pcr256,Pcr756,MGm6,...
    M9,V9,Md9,Pcr259,Pcr759,MGm9,...
    MMore,VMore,MdMore,Pcr25More,Pcr75More,MGmMore,...
    H,...
    GVec]...
    =SVStats( SVCoor, SVInt ,Gmag)
%Outputs properties for SuperVoxel Class.
% M=mean, V=Variance, H=Histogram
%   Detailed explanation goes here


I3=zeros(1,size(SVCoor,1)); I6=zeros(1,size(SVCoor,1)); 
I9=zeros(1,size(SVCoor,1)); IMore=zeros(1,size(SVCoor,1));
I3i=1; I6i=1; I9i=1; IMi=1;

GM=zeros(size(SVCoor,1),1);
G3=zeros(1,size(SVCoor,1)); G6=zeros(1,size(SVCoor,1)); 
G9=zeros(1,size(SVCoor,1)); GMore=zeros(1,size(SVCoor,1));
G3i=1; G6i=1;G9i=1; GMi=1;
H=zeros(1,26);

% yM=max(SVCoor(:,1)); xM=max(SVCoor(:,2));
% ym=min(SVCoor(:,1)); xm=min(SVCoor(:,2));
% GI=double(I(ym:yM,xm:xM));
% [E,O]=gabor_filt(GI,8,0,30,.12,.12);
% E=E.^2;
% O=O.^2;
% ME=zeros(1,6); %mean even
% MO=zeros(1,6); %mean odd
% for i=1:1:6
%     ME(1,i)=mean(mean(E(:,:,i)));
%     MO(1,i)=mean(mean(O(:,:,i)));
% end;
% E3=0; E6=0; E9=0; EMore=0;
% E3C=0; E6C=0; E9C=0; EMC=0;
% O3=0; O6=0; O9=0; OMore=0;
% O3C=0; O6C=0; O9C=0; OMC=0;

Centroid=double(sum(SVCoor))/size(SVCoor,1);
yC=round(Centroid(1,1)); xC=round(Centroid(1,2));

for i=1:1:size(SVCoor,1)
    IV=SVInt(i,1); %Intensity Value (Grayscale)
    ind=floor(IV/10)+1;
    H(1,ind)=H(1,ind)+1;
    
    yi=round(SVCoor(i,1)); xi=round(SVCoor(i,2));
    
    gm=Gmag(yi,xi);
    GM(i,1)=gm;
        
%     EI=zeros(1,6);
%     OI=zeros(1,6);
%     for j=1:1:6
%         EI(1,j)=E(yi-ym+1,xi-xm+1,j);
%         OI(1,j)=O(yi-ym+1,xi-xm+1,j);
%     end;
    
    y=yi-yC; x=xi-xC;
    if x*x+y*y>=0 && x*x+y*y<=9 
        I3(I3i)=IV;
        G3(G3i)=gm;
        I3i=I3i+1;
        G3i=G3i+1;
%         E3=[E3;EI];
%         O3=[O3;OI];
%         E3=E3+EI;
%         E3C=E3C+1;
%         O3=O3+EI;
%         O3C=O3C+1;
    elseif x*x+y*y>=9 && x*x+y*y<=36
        I6(I6i)=IV;
        G6(G6i)=gm;
        I6i=I6i+1;
        G6i=G6i+1;
%         E6=[E6;EI];
%         O6=[O6;OI];
%         E6=E6+EI;
%         E6C=E6C+1;
%         O6=O6+EI;
%         O6C=O6C+1;
    elseif x*x+y*y>=36 && x*x+y*y<=81
        I9(I9i)=IV;
        G9(G9i)=gm;
        I9i=I9i+1;
        G9i=G9i+1;
%         E9=[E9;EI];
%         O9=[O9;OI];
%         E9=E9+EI;
%         E9C=E9C+1;
%         O9=O9+EI;
%         O9C=O9C+1;
    elseif x*x+y*y>=81
        IMore(IMi)=IV;
        GMore(GMi)=gm;
        IMi=IMi+1;
        GMi=GMi+1;
%         EMore=[EMore;EI];
%         OMore=[OMore;OI];
%         EMore=EMore+EI;
%         EMC=EMC+1;
%         OMore=OMore+EI;
%         OMC=OMC+1;
    end;
end;

I3(:,all(~I3,1))=[];
I6(:,all(~I6,1))=[];
I9(:,all(~I9,1))=[];
IMore(:,all(~IMore,1))=[];

G3(:,all(~G3,1))=[];
G6(:,all(~G6,1))=[];
G9(:,all(~G9,1))=[];
GMore(:,all(~GMore,1))=[];

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

% ME3=mean(E3);
% ME6=mean(E6);
% ME9=mean(E9);
% MEMore=mean(EMore);
%ME3=E3/E3C;
%ME6=E6/E6C;
%ME9=E9/E9C;
%MEMore=EMore/EMC;

% MO3=mean(O3);
% MO6=mean(O6);
% MO9=mean(O9);
% MOMore=mean(OMore);
%MO3=O3/O3C;
%MO6=O6/O6C;
%MO9=O9/O9C;
%MOMore=OMore/OMC;


%GVec=[ME,ME3,ME6,ME9,MEMore,MO,MO3,MO6,MO9,MOMore]; 
end

