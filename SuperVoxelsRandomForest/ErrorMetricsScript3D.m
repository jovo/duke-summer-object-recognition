% Error Metrics 3D

L=load('TruthData.mat');
TruthData=getfield(L,'TruthData');

L=load('RFResult_7.mat');
MitoSV=getfield(L,'MitoSV');
BinaryResult=getfield(L,'BinaryResult');
DesiredBR=BinaryResult(:,:,60:100); % CHANGE THIS
%DesiredBR=BinaryResult;

HalfFullPosiMito=0;
PartPosiMito=0;
FalseNegaMito=0; 

DesiredTruth=TruthData(:,:,60:100); % CHANGE THIS
%DesiredTruth=TruthData;
CC=bwconncomp(DesiredTruth,26);
TotalMito=CC.NumObjects;

%CutInd=sub2ind(size(TruthData), size(TruthData,1), size(TruthData,2),40);

for i=1:1:CC.NumObjects %i has to start from 1 here
    TruthPixels=CC.PixelIdxList{1,i};
%     Check=TruthPixels<=CutInd;
%     if sum(Check)>0
%         continue;
%     end;
%    TotalMito=TotalMito+1;
    TrueVol=size(TruthPixels,1);
    CountResVol=0;
    for k=1:1:TrueVol
        pixel=TruthPixels(k,1);
        if DesiredBR(pixel)==1
            CountResVol=CountResVol+1;
        end;
    end;
    OverlapVol=CountResVol/TrueVol;
    if OverlapVol>=.5
        HalfFullPosiMito=HalfFullPosiMito+1;
    elseif OverlapVol>=.2 & OverlapVol<.5
        PartPosiMito=PartPosiMito+1;
    elseif OverlapVol>=0 & OverlapVol<.2
        FalseNegaMito=FalseNegaMito+1;
    end;
end;

HFPosiMitoPercent=HalfFullPosiMito/TotalMito
PPosiMitoPercent=PartPosiMito/TotalMito
FNegaMitoPercent=FalseNegaMito/TotalMito


TruePosiSV=0;
FalsePosiSV=0;
TotalSVDetected=0;
for i=60:1:size(TruthData,3) % CHANGE THIS
    SVCell=MitoSV{1,i};
    TotalSV=size(SVCell,2);
    TotalSVDetected=TotalSVDetected+TotalSV;
    for k=1:1:TotalSV
        sv=SVCell{1,k};
        coor=sv.SVCoor;
        for l=1:1:size(coor,1)
            y=coor(l,1);
            x=coor(l,2);
            if TruthData(y,x,i)==1
                TruePosiSV=TruePosiSV+1;
                break;
            end;
            if l==size(coor,1)
                FalsePosiSV=FalsePosiSV+1;
            end;
        end;
    end;
end;

TPosiSVPercent=TruePosiSV/TotalSVDetected
FPosiSVPercent=FalsePosiSV/TotalSVDetected

