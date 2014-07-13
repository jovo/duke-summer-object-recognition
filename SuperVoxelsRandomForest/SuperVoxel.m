classdef SuperVoxel<handle
    %SuperVoxel Class to be used for Mitochondria Deteted
    %Author: Joy Patel
    %
    % This is a class designed to easily make feature vectors for
    % supervoxels in mitochondria detection.
    
    properties (SetAccess = 'public', GetAccess = 'public')
        SVCoor; % n by  image coordinates of supervoxels
        SVInt; %Column of grayscale intensites in which the the ith column 
                       
        FVector;
        %R100Mat;
    end
    
    methods (Access=public)
        
        function this=SuperVoxel(coor,inten,I,CodeBook,Gmag)
            coor=double(coor);
            inten=double(inten);
            
            this.SVCoor=coor;
            this.SVInt=inten;
            
            M=mean(inten);
            V=var(inten);
            Med=median(inten);
            Pc25=prctile(inten,25);
            Pc75=prctile(inten,75);
             
            [MGm,...
            M3,V3,Md3,Pc253,Pc753,MGm3,...
            M6,V6,Md6,Pc256,Pc756,MGm6,...
            M9,V9,Md9,Pc259,Pc759,MGm9,...
            MMore,VMore,MdMore,Pc25More,Pc75More,MGmMore,...
            H]...
            =SVStats(coor,inten,Gmag);
            
            
            yM=max(coor(:,1)); xM=max(coor(:,2));
            ym=min(coor(:,1)); xm=min(coor(:,2));
            IC=double(I(ym:yM,xm:xM));
            
            R100Mat=MakeR100Vectors(IC);
            BOWH=zeros(1,100);
            IDX=knnsearch(CodeBook,R100Mat);
            for ind=1:1:size(IDX,1);
                BOWH(IDX(ind))=BOWH(IDX(ind))+1;
            end;
            BOWH=BOWH/sum(BOWH);
        
            this.FVector=[M,V,Med,Pc25,Pc75,MGm,...
                M3,V3,Md3,Pc253,Pc753,MGm3,...
                M6,V6,Md6,Pc256,Pc756,MGm6,...
                M9,V9,Md9,Pc259,Pc759,MGm9,...
                MMore,VMore,Pc25More,Pc75More,MGmMore,...
                H,...
                BOWH];
            %this.FVector=[M,V,Med,Pc25,Pc75,MGm,BOWH];
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

