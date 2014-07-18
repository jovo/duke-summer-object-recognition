function [ CodeBook ] = MakeCodeBook(imagestack,IndexVector)
% Makes R100 CodeBook to use with Bag-of-Words for SuperVoxel feature vector
%
% Input:
% imagestack: 3D image cube of images
%
% IndexVector: row vector of z indices correponding to the imagestack;
% these indices represent the images you want to use to make the CodeBook
% 
% Output:
% CodeBook: CodeBook for Bag-of-Words features for SuperVoxels
% 

%% Gather all 10-by-10 image crops (R100 Vectors) into a Cell
ImageR100Cell=cell(1,size(IndexVector,2)); % Cell of cells that have the R100 Vectors for the images
for i=IndexVector
    tic
    I=imagestack(:,:,i);
    % Supervoxels require preprocessing
    imSeg = zeros(size(I));

    [ysz,xsz]=size(I);
    BW=ones(ysz,xsz);

    imSlice = I;

    % Bilateral Filtering
    sigma1 = 20; sigma2 = 20; tol = 0.01;

    % make odd
    if (mod(sigma1,2) == 0)
        w  = sigma1 + 1;
    else
        w  = sigma1;
    end
    warning('off');
    [outImg, param] =  shiftableBF(double(imSlice), sigma1, sigma2, w, tol);
    warning('on');
    outImg = single(outImg)/255;
    outImg(:,:,2) = outImg(:,:,1);
    outImg(:,:,3) = outImg(:,:,1);

    %Ready for SLIC
    imSeg = vl_slic(outImg, 25, 1);

    [sx,sy]=vl_grad(double(imSeg), 'type', 'forward');
    s = find(sx | sy);
    imSlice(s) = 0;
    BW(s)=0;
    
    imSeg=imSeg+1; % make non-zero
    numCC=max(max(imSeg));
    R100Cell=cell(1,numCC); %cell fo SuperVoxels R100 vectors
    cur=1;
    while cur<=numCC
        SV=imSeg==cur;
        [y,x]=find(SV);
        SVCoor=[y,x];
        % Image crop to make R100 Vectors
        yM=max(SVCoor(:,1)); xM=max(SVCoor(:,2));
        ym=min(SVCoor(:,1)); xm=min(SVCoor(:,2));
        IC=double(I(ym:yM,xm:xM));

        % Matrix of R100 vectors to be used for Bag-of-Words
        R100Cell{1,cur}=MakeR100Vectors(IC);
        cur=cur+1;
    end;
    ImageR100Cell{1,i}=R100Cell;
    disp(strcat('Processed image:',num2str(i)));
    toc
end;

%% Count Rows to Pre-allocate data
tic
disp('Counting Rows');
CountRows=0;
for i=1:1:size(IndexVector,2)
    R100Cell=ImageR100Cell{1,i};
    for j=1:1:size(R100Cell,2)
        CountRows=CountRows+size(R100Cell{1,j},1);
    end;
end;
toc

%% Combine all R100 vectors from ImageR100Cell into one matrix
tic
disp('Combining R100 Vectors for SuperVoxels');
R100MatFull=zeros(CountRows,100);
ind=1;
for i=1:1:size(IndexVector,2)
    R100Cell=ImageR100Cell{1,i};
    for j=1:1:size(R100Cell,2)
        R100Mat=R100Cell{1,j};
        for k=1:1:size(R100Mat,1)
            R100MatFull(ind,:)=R100Mat(k,:);
            ind=ind+1;
        end;
    end;
end;
toc

%% K-means with k=100 to make CodeBook
disp('Making CodeBook');
tic
CodeBook=vl_kmeans(double(R100MatFull)',100);
CodeBook=CodeBook';
toc

end

