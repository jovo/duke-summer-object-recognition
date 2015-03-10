classdef SuperVoxel<handle
    % SuperVoxel Class to be used for Mitochondria Deteted
    %
    % This is a class designed to easily make feature vectors for
    % supervoxels in mitochondria detection.

    %% Properties of Class
    properties (SetAccess = 'public', GetAccess = 'public')
        SVCoor; % [y,x] (or [row,column]) image coordinates of SuperVoxel
                % (an [n by 2] matrix)
                
        SVInt; % Column vector of grayscale intensites in which the the ith
               % row grayscale value corresponds to the ith row coordinate 
               % [y,x] in SVCoor (an [n by 1] matrix) 
                       
        FVector; %Feature Vector for Super Voxel
    end
    
    %% Methods of Class
    methods (Access=public)        

        %% Constructor Function
        function this=SuperVoxel(coor,inten,I,CodeBook,Gmag)
            
            % Constructor Function 
            %
            % Inputs:
            % coor: [y,x] (or [row,column]) image coordinates of SuperVoxel
            %
            % inten: Column vector of grayscale intensites in which the the ith
            % row grayscale value corresponds to the ith row coordinate 
            % [y,x] in coor
            %
            % I: image from which SuperVoxel was created from
            %
            % CodeBook: [100 by 100] codebook matrix to be used to create
            % the Bag-of-Words features
            %
            % Gmag: matrix of image gradient magnitudes for image in which Super Voxels
            % are being created
            
            coor=double(coor); % (row,column) coordinates for the image 
            inten=double(inten); % grayscale intensity values
            
            this.SVCoor=coor; % setting Super Voxel variables
            this.SVInt=inten;
            
            M=mean(inten); % Mean of grayscale values
            V=var(inten); % Variance of grayscale values
            Med=median(inten); % Median of grayscale values
            Pc25=prctile(inten,25); %25th percentile of grayscale values
            Pc75=prctile(inten,75); %75th percentile of grayscale vaues
             
            % Refer to function SVStats for info on variables
            [MGm,...
            M3,V3,Md3,Pc253,Pc753,MGm3,...
            M6,V6,Md6,Pc256,Pc756,MGm6,...
            M9,V9,Md9,Pc259,Pc759,MGm9,...
            MMore,VMore,MdMore,Pc25More,Pc75More,MGmMore,...
            H]...
            =SVStats(coor,inten,Gmag);
            
            % IC is image crop to be used for Bag-of-Words
            yM=max(coor(:,1)); xM=max(coor(:,2));
            ym=min(coor(:,1)); xm=min(coor(:,2));
            IC=double(I(ym:yM,xm:xM));
            
            % Matrix of R100 vectors to be used for Bag-of-Words
            R100Mat=MakeR100Vectors(IC);
            
            % Bag-of-Words Histogram Vector
            BOWH=zeros(1,100);
            
            % Update Bag-of-Words Histogram Vector
            IDX=knnsearch(CodeBook,R100Mat);
            for ind=1:1:size(IDX,1);
                BOWH(IDX(ind))=BOWH(IDX(ind))+1;
            end;
            BOWH=BOWH/sum(BOWH); % Normalize
            
            %Set Feature Vector
            this.FVector=[M,V,Med,Pc25,Pc75,MGm,...
                M3,V3,Md3,Pc253,Pc753,MGm3,...
                M6,V6,Md6,Pc256,Pc756,MGm6,...
                M9,V9,Md9,Pc259,Pc759,MGm9,...
                MMore,VMore,MdMore,Pc25More,Pc75More,MGmMore,...
                H,...
                BOWH];
        end; 

        %% Visualizing SuperVoxel
        function [I]=Visualize(this)
            % Way to visualize what the Super Voxel looks like
            % Output is image of SupeVoxel
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
            % Determines if two SuperVoxels are equal
            % Output is boolean
            TV=isequal(SV1.SVCoor,SV2.SVCoor) & isequal(SV1.SVInt,SV2.SVInt) & isequal(SV1.FVector,SV2.FVector);
        end;
        
        %% Checking if SVCoor contains a certain point
        function TV=containsPt(this,pt)
            % Determines if SVCoor contains a certain [y,x] point
            % Output is boolean
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

