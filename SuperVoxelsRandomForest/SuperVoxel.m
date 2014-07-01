classdef SuperVoxel<handle
    %SuperVoxel Class
    %   Detailed explanation goes here
    
    properties (SetAccess = 'public', GetAccess = 'public')
        Median;
        Pcr25;
        Pcr75;
        SVCoor;
        SVInt;
        %AvgGradMag;
        Mean;
        Var;
        ShellMean3;
        ShellMean6;
        ShellMean9;
        ShellVar3;
        ShellVar6;
        ShellVar9;
        ShellMean12;
        ShellVar12;
        ShellMed3;
        ShellMed6;
        ShellMed9;
        ShellMed12;
        Pcr253;
        Pcr753;
        Pcr256;
        Pcr756;
        Pcr259;
        Pcr759;
        HSpace;
        FVector;
    end
    
    methods (Access=public)
        
        function this=SuperVoxel(coor,inten)
            coor=double(coor);
            inten=double(inten);
            this.SVCoor=coor;
            this.SVInt=inten;
            Med=median(inten);
            this.Median=Med;
            Pc25=prctile(inten,25);
            Pc75=prctile(inten,75);
            this.Pcr25=Pc25;
            this.Pcr75=Pc75;
            M=mean(inten);
            this.Mean=M;
            V=var(inten);
            this.Var=V;
            [M3,V3,M6,V6,M9,V9,M12,V12,H,Md3,Md6,Md9,Md12,Pc253,Pc753,...
                Pc256,Pc756,Pc259,Pc759]=SVStats(coor,inten);
            this.Pcr253=Pc253;
            this.Pcr753=Pc753;
            this.Pcr256=Pc256;
            this.Pcr756=Pc756;
            this.Pcr259=Pc259;
            this.Pcr759=Pc759;
            this.ShellMed3=Md3;
            this.ShellMed6=Md6;
            this.ShellMed9=Md9;
            this.ShellMed12=Md12;
            this.ShellMean3=M3;
            this.ShellVar3=V3;
            this.ShellMean6=M6;
            this.ShellVar6=V6;
            this.ShellMean9=M9;
            this.ShellVar9=V9;
            this.ShellMean12=M12;
            this.ShellVar12=V12;
            %this.AvgGradMag=mGm;
            this.HSpace=H;
            %M,V,M3,V3,Md3,M6,V6,Md6,M9,V9,Md9,
            this.FVector=[M,V,Med,Md3,Md6,Md9,Pc25,Pc75,Pc253,Pc753,...
                Pc256,Pc756,Pc259,Pc759,H];
        end;
        %Feature Vector: [Median, Gradient Mag, Mean, SD, Shell Statistics] 

        
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

