classdef SuperVoxel<handle
    %SuperVoxel Class to be used for Mitochondria Deteted
    %Author: Joy Patel
    %
    % This is a class designed to easily make feature vectors for
    % supervoxels in mitochondria detection.
    
    properties (SetAccess = 'public', GetAccess = 'public')
        SVCoor; % n by  image coordinates of supervoxels
        SVInt; %Column of grayscale intensites in which the the ith column 
               
        
%         Mean;
%         Var;
%         Median;
%         Pcr25;
%         Pcr75;
%         GM;
%         
%         ShellMean3;
%         ShellVar3;
%         ShellMed3;
%         Pcr253;
%         Pcr753;
%         GM3;
%         
%         ShellMean6;
%         ShellVar6;
%         ShellMed6;
%         Pcr256;
%         Pcr756;
%         GM6;
%         
%         ShellMean9;
%         ShellVar9;
%         ShellMed9;
%         Pcr259;
%         Pcr759;
%         GM9;
%         
%         ShellMeanMore;
%         ShellVarMore;
%         ShellMedMore;
%         Pcr25More;
%         Pcr75More;
%         GMMore;
%         
%         GaborSqEn;
%         GaborMAmp;
%         
%         HSpace;
        
        FVector;
    end
    
    methods (Access=public)
        
        function this=SuperVoxel(coor,inten,Gmag,I)
            coor=double(coor);
            inten=double(inten);
            
            this.SVCoor=coor;
            this.SVInt=inten;
            
            M=mean(inten);
            V=var(inten);
            Med=median(inten);
            Pc25=prctile(inten,25);
            Pc75=prctile(inten,75);
            
%             this.Mean=M;
%             this.Var=V;
%             this.Median=Med;
%             this.Pcr25=Pc25;
%             this.Pcr75=Pc75;

            [MGm,...
            M3,V3,Md3,Pc253,Pc753,MGm3,...
            M6,V6,Md6,Pc256,Pc756,MGm6,...
            M9,V9,Md9,Pc259,Pc759,MGm9,...
            MMore,VMore,MdMore,Pc25More,Pc75More,MGmMore,...
            H]...
            =SVStats(coor,inten,Gmag);
            
%             this.GM=MGm;
%         
%             this.ShellMean3=M3;
%             this.ShellVar3=V3;
%             this.ShellMed3=Md3;
%             this.Pcr253=Pc253;
%             this.Pcr753=Pc753;
%             this.GM3=MGm3;
% 
%             this.ShellMean6=M6;
%             this.ShellVar6=V6;
%             this.ShellMed6=Md6;
%             this.Pcr256=Pc256;
%             this.Pcr756=Pc756;
%             this.GM6=MGm6;
% 
%             this.ShellMean9=M9;
%             this.ShellVar9=V9;
%             this.ShellMed9=Md9;
%             this.Pcr259=Pc259;
%             this.Pcr759=Pc759;
%             this.GM9=MGm9;
% 
%             this.ShellMeanMore=MMore;
%             this.ShellVarMore=VMore;
%             this.ShellMedMore=MdMore;
%             this.Pcr25More=Pc25More;
%             this.Pcr75More=Pc75More;
%             this.GMMore=MGmMore;
%             
%             this.HSpace=H;
            
%             for i=1:1:size(coor,1)
%                 y=coor(i,1);
%                 x=coor(i,2);
%                 GI(y,x)=inten(i);
%             end;
%            [GSE, GMA ]= phasesym(GI,6,6);
            
%             this.GaborSqEn=GSE;
%             this.GaborMAmp=GMA;
            
            this.FVector=[M,V,Med,Pc25,Pc75,MGm,...
                M3,V3,Md3,Pc253,Pc753,MGm3,...
                M6,V6,Md6,Pc256,Pc756,MGm6,...
                M9,V9,Md9,Pc259,Pc759,MGm9,...
                MMore,VMore,Pc25More,Pc75More,MGmMore,...
                H];
%            this.FVector=[GSE,GMA];
        end; 

        
        function [I]=Visualize(this)
            coor=this.SVCoor;
            yM=max(coor(:,1));
            xM=max(coor(:,2));
            ym=min(coor(:,1));
            xm=min(coor(:,2));
            
            Inten=this.SVInt;
            
            I=zeros(yM,xM);
            for i=1:1:size(coor,1)
                y=coor(i,1);
                x=coor(i,2);
                I(y,x)=Inten(i);
            end;
            
            I=I(ym:yM,xm:xM);
        end;
        
        function TV=eq(SV1,SV2)
            TV=isequal(SV1.SVCoor,SV2.SVCoor) & isequal(SV1.SVInt,SV2.SVInt) & isequal(SV1.FVector,SV2.FVector);
        end;
        
        function TV=containsPt(this,pt)
            coor=this.SVCoor;
            TV=false;
            for i=1:1:size(coor,1)
                v=coor(i,:);
                if isequal(pt,v)
                    TV=true;
                    break;
                end;
            end;
        end;
        
    end
    
end

