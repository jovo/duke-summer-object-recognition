function [M3,V3,M6,V6,M9,V9,M12,V12,H,Md3,Md6,Md9,Md12,Pcr253,Pcr753,...
                Pcr256,Pcr756,Pcr259,Pcr759] = SVStats( SVCoor, SVInt )
%Outputs properties for SuperVoxel Class.
% M=mean, V=Variance, H=Histogram
%   Detailed explanation goes here


I3=[];
I6=[];
I9=[];
I12=[];
H=zeros(1,26);

Centroid=double(sum(SVCoor))/size(SVCoor,1);
yC=round(Centroid(1,1));
xC=round(Centroid(1,2));

%gm=[];
for i=1:1:size(SVCoor,1)
    IV=SVInt(i,1);
    ind=floor(IV/10)+1;
    H(1,ind)=H(1,ind)+1;
    %gm=[gm;Gmag(round(SVCoor(i,1)),round(SVCoor(i,2)))];
    y=SVCoor(i,1)-yC;
    x=SVCoor(i,2)-xC;
    if x*x+y*y>=0 && x*x+y*y<=9 
        I3=[I3,IV];
    elseif x*x+y*y>=9 && x*x+y*y<=36
        I6=[I6,IV];
    elseif x*x+y*y>=36 && x*x+y*y<=81
        I9=[I9,IV];
    elseif x*x+y*y>=81 && x*x+y*y<=144
        I12=[I12,IV];
    end;
end;

H=H/sum(H);
M3=mean(I3);
V3=var(I3);
Md3=median(I3);
M6=mean(I6);
V6=var(I6);
Md6=median(I6);
M9=mean(I9);
V9=var(I9);
Md9=median(I9);
M12=mean(I12);
V12=var(I12);
Md12=median(I12);
%mGm=mean(gm);
Pcr253=prctile(I3,25);
Pcr753=prctile(I3,75);
Pcr256=prctile(I6,25);
Pcr756=prctile(I6,75);
Pcr259=prctile(I9,25);
Pcr759=prctile(I9,75);
end

