function ErrorMetrics3D(TruthData,BinaryResult,MitoSV,Start,End)
% Author: Joy Patel (2014)
% ErrorMetrics for Mitochondria Detection
%
% Input:
% TruthData: logical binary truth data image cube for mitochondria
%
% BinaryResult: logical binary image cube representing detected
% mitochondria
%
% MitoSV: 1-by-100 cell of cells of Supervoxels of detected mitochondria
% where the ith cell represents the SuperVoxels detected in the ith (z-coordinate)
% image
%
% start: starting z-coordinate of images from where you want
% the error metrics to begin
%
% end: ending z-coordinate of image form where you want the
% error metrics to stop

%% Error Metrics regarding percent of Mitochondria detected

DesiredBR=BinaryResult(:,:,Start:End); % CHANGE THIS
%DesiredBR=BinaryResult;

Detect50_100=0; % count for mitochondria [50,100] percent detected
Detect20_50=0; % count for mitochondria [20,50] percent detected
Detect0_20=0; % count for mitochondria (0,20] percent detected
Detect0=0; % count for mitochondria 0 percent detected

DesiredTruth=TruthData(:,:,Start:End); % CHANGE THIS
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
        Detect50_100=Detect50_100+1;
    elseif OverlapVol>=.2 & OverlapVol<.5
        Detect20_50=Detect20_50+1;
    elseif OverlapVol>0 & OverlapVol<.2
        Detect0_20=Detect0_20+1;
    elseif OverlapVol==0
        Detect0=Detect0+1;
    end;
end;

Detect50_100Pct=Detect50_100/TotalMito; % percent for mitochondria [50,100] percent detected
Detect20_50Pct=Detect20_50/TotalMito; % percent for mitochondria [20,50] percent detected
Detect0_20Pct=Detect0_20/TotalMito; % percemt for mitochondria (0,20] percent detected
Detect0Pct=Detect0/TotalMito; % percent for mitochondria 0 percent detected

disp(strcat('% of 3D Connected Components Truth Mitochondria 50-to-100percent ',...
                    'Overlap Detected by Supervoxels:', num2str(100*Detect50_100Pct)));
disp(strcat('% of 3D Connected Components Truth Mitochondria 20-to-50percent ',...
                    'Overlap Detected by Supervoxels:', num2str(100*Detect20_50Pct)));
disp(strcat('% of 3D Connected Components Truth Mitochondria 0-to-20percent ',...
                    'Overlap Detected by Supervoxels:', num2str(100*Detect0_20Pct)));
disp(strcat('% of 3D Connected Components Truth Mitochondria 0percent ',...
                    'Overlap Detected by Supervoxels:', num2str(100*Detect0Pct)));

%% Error Metrics for True and False Positives for SuperVoxels detected as mitochondria
                                                                
TruePosiSV=0; % count for SuperVoxels detected as true positives
              % (i.e., overlap with mitochondria)
FalsePosiSV=0; % count for SuperVoxels detected as false positives
               % (i.e., don't overlap with mitochondria)
TotalSVDetected=0; % total SuperVoxels
                                                                
for i=Start:1:End % CHANGE THIS
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

TPosiSVPct=TruePosiSV/TotalSVDetected; % percent for SuperVoxels detected as true positives
FPosiSVPct=FalsePosiSV/TotalSVDetected; % percent for SuperVoxels detected as false positives

disp(strcat('% of 2D Supervoxels Detected which were True Positives:',num2str(100*TPosiSVPct)));
disp(strcat('% of 2D Supervoxels Detected which were False Positives:',num2str(100*FPosiSVPct)));

end