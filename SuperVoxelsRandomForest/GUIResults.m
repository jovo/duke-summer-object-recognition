function [] = GUIResults( imagestack, BinaryResult )
% GUI to view results for Mitochondria Detection via connencted components.
%
% Inputs:
% imagestack: m by n by k 3D image cube of cutout from OCP API 
%
% BinaryResult: m by n by k 3D logical matrix which is a binary represent of
% where mitochondria were detected in imagestack; BinaryResult is a result
% from DetectSV
%
%
% Outputs:
% RGBResult: cell of RGB images where the ith image correspondes to the kth
% image from the imagestack; the RGB images are annotated with locations
% where mitochondria are detected via bw-connected-components.
%

%% Connected Components
CC=bwconncomp(BinaryResult,26);
label=labelmatrix(CC);
num=CC.NumObjects;

%% Deriving colormap
cmap=feval('jet',num);
stream=RandStream('swb2712','seed',0);
index=randperm(stream,num);
cmap=cmap(index,:,:);
cmap=[[0,0,0];cmap]; % setting the zero-color

%% Annotating Data with colormap
RGBResult=cell(1,size(BinaryResult,3));
for i=1:1:size(label,3)
    
    % Annotations
    RGBL=ind2rgb8(label(:,:,i), cmap); 
    
    % Adding Annotations to images
    I=imagestack(:,:,i);
    [ysz,xsz]=size(I);
    temp=zeros(ysz,xsz,3);
    temp(:,:,1)=I;
    temp(:,:,2)=I;
    temp(:,:,3)=I;
    RGBI=double(temp/255);
    RGBI(:,:,1)=RGBI(:,:,1)+double(RGBL(:,:,1)/255);
    RGBI(:,:,2)=RGBI(:,:,2)+double(RGBL(:,:,2)/255);
    RGBI(:,:,3)=RGBI(:,:,3)+double(RGBL(:,:,3)/255);
    RGBResult{i}=RGBI;
end;

%% Viewing results in a GUI
% Handles
H.f = figure('Visible', 'off',    ...
            'MenuBar', 'none',   ...
            'Toolbar', 'figure', ...
            'Position', [0, 0, 900, 1000]);

H.zslider = uicontrol('Style', 'slider', 'Min', 0,'Max', 1, ...
        'Value', 1, 'SliderStep', [1, 10], ...
        'Position', [90, 15, 700, 20]);

H.imgindex = uicontrol('Style', 'text', 'String', 1, ...
        'Position', [50, 15, 30, 30]);

H.a = axes('Units', 'Pixels', 'Position', [10, 50, 900, 1000]);

% Set callbacks and GUI
set(H.zslider, 'Callback', {@slider_Callback, H});
set([H.f, H.a, H.imgindex, H.zslider], 'Units', 'normalized');
set(H.f, 'Name', 'Image Stack viewer')
movegui(H.f, 'center')
set(H.f, 'Visible', 'on');

% Initialize first image
depth=size(imagestack,3);
set(H.imgindex, 'String', '1');
set(H.zslider, 'Max', depth);
set(H.zslider, 'SliderStep', [1, 10]./depth);
imshow(RGBResult{1});

% Slider callback
function slider_Callback(varargin)
    hObj=varargin{1};
    handles=varargin{3};

    imgindex=floor(get(hObj, 'Value'));
    if ~imgindex
        imgindex=1;
    end
    set(handles.imgindex, 'String', int2str(imgindex));
    imshow(RGBResult{imgindex});
end
 
end

