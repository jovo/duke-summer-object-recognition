tic
L=load('AC4_matrices.mat');
imagestack=getfield(L,'imageAC4');
TruthData=getfield(load('TruthData.mat'),'TruthData');

T={};
F={};
% t=[1:1:40];
% t=[t,45];
% t=[t,50];
for i=1:1:40
    %tic
    I=imagestack(:,:,i);
    %BW=1-im2bw(rgb2gray(imread(strcat('slide',num2str(i),'m.png'))));
    BW=TruthData(:,:,i);
    [y,x]=find(BW);
    coor=[y,x];
    [SPI,bw,SVCell]=SuperVoxelize(I);
%     for k=1:1:size(SVCell,2)
%         sv=SVCell{1,k};
%         if sv.Median>160 | sv.Median<50
%             F{end+1}=sv;
%             SVCell{1,k}=[];
%         end;
%     end;
%     SVCell=SVCell(~cellfun(@isempty, SVCell));
    SVCount=zeros(size(SVCell,2),1);
    for j=1:1:size(SVCell,2)
        sv=SVCell{1,j};
        coor=sv.SVCoor;
        for k=1:1:size(coor,1)
            y=coor(k,1);
            x=coor(k,2);
            if BW(y,x)>0
                SVCount(j,1)=SVCount(j,1)+1;
            end;
        end;
    end;
    for k=1:1:size(SVCell,2)
        sv=SVCell{1,k};
        if SVCount(k,1)/size(sv.SVCoor,1)>.15
            T{end+1}=sv;
            SVCell{1,k}=[];
        end;
    end;
    SVCell=SVCell(~cellfun(@isempty, SVCell));
    for j=1:1:size(SVCell,2)
        F{end+1}=SVCell{1,j};
    end;
    disp(i);
    %toc
end;
toc