% Mitochondria Detection
% - Downloads data from OCP API
% - Detects Mitochondria
% - Uploads data back

disp('Creating OCP object:');
%%
% Create OCP Object
oo=OCP();

%%
%Set Server Location
while true
    ServerLocationStr='http://braingraph1dev.cs.jhu.edu/'; %Default Server Location
    Input=input(strcat('\nServer Location:\n',...
         'Default is http://braingraph1dev.cs.jhu.edu\n',...
         'To use default, just press enter.\n',...
         'Otherwise, enter the name of desired Server Location:'),'s');
     
    if ~strcmp(Input,'')==1
        ServerLocationStr=Input;
    end;
    try
        oo.setServerLocation(ServerLocationStr);
        break;
    catch
        disp('Server Location problems! Try Again');
    end;
end;

%% Set Image Token
while true
    ImageTokenStr='kasthuri11cc'; %Default Image Token
    Input=input(strcat('\nImage Token:\n',...
         'Default is kasthuri11cc\n',...
         'To use default, just press enter.\n',...
         'Otherwise, enter the name of desired Image Token:'),'s');

    if ~strcmp(Input,'')==1
        ImageTokenStr=Input;
    end;    
    try
        oo.setImageToken(ImageTokenStr);
        break;
    catch
        disp('Image Token problems! Try again.');
    end;
end;

%% Set Annotation Token
AnnoTokenStr='';
while true 
    AnnoTokenStr=input(strcat('\nAnnotation Token:\n',...
            '(Note: There is no default)\n',...
            'Enter the name of Annotation Token to be used:'),'s');
    try
        oo.setAnnoToken(AnnoTokenStr);
        break;
    catch
        disp('Annotation Token problems!');
        while true
            Input=input(strcat('\nWould you like try another ',...
                'Annotation Token? [Y/N]:'),'s');
            if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1 | ...
                strcmp(Input,'N')==1 | strcmp(Input,'n')==1)
            break;
            end;
            disp(sprintf('\nInvalid input! Type Y or N.\n'));
        end;
        if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1)
            continue;
        end;
        break;
    end;
end;
%% Set Resolution
while true
    Reso=1;
    Input=input(strcat('\nResolution OCP Object:\n',...
             'Default is 1\n',...
             'To use default, just press enter.\n',...
             'Otherwise, enter the desired Resolution:'),'s');
    if ~(strcmp(Input,'')==1)
        Reso=str2num(Input);
    end;
    try
        oo.setDefaultResolution(Reso);
        break;
    catch
        disp('Default Resolution problems! Try again.');
    end;
end;

%% Query for image data
disp(sprintf('\nSetting Image Dense Query'));
q=OCPQuery(eOCPQueryType.imageDense);

%% xyz Range
while true
    xRange=[4400, 5424];
    yRange=[5440, 6464];
    zRange=[1100, 1200];

    fprintf(sprintf(strcat('\nSet the xRange, yRange, and zRange\n',...
                'Default ranges are those for AC4 images\n',...
                'Default xRange: [4400, 5424]\n',...
                'Default yRange: [5440, 6464]\n',...
                'Default zRange: [1100, 1200]\n',...
                'To use default, just press enter.\n',...
                'Otherwise, enter range in [min, max] format.')));
    try
        Input=input('\nxRange:');  
        if ~(isequal(Input,[])==1)
            xRange=Input;
        end;
        Input=input('yRange:');
        if ~(isequal(Input,[])==1)
            yRange=Input;
        end;
        Input=input('zRange:');
        if ~(isequal(Input,[]))==1
            zRange=Input;
        end;
        q.setCutoutArgs(xRange, yRange, zRange);
        break;
    catch
        disp('xyz Range problems! Wrong input format or out-of-bounds error.');
        disp('Try again.');
    end;
end;

%% Set resolution for query
while true
    Reso=1;

    Input=input(strcat('\nResolution for Image Dense Query:\n',...
             'Default is 1\n',...
             'To use default, just press enter.\n',...
             'Otherwise, enter the desired Resolution:'),'s');

    if ~(strcmp(Input,'')==1)
        Reso=str2num(Input);
    end;
    try 
        q.setResolution(Reso);
        break;
    catch
        disp('Resolution problems! Try again.');
    end;        
end;

[pf, msg] = q.validate()

%% Set Cutout
cutout=oo.query(q);

while true
    Input=input(sprintf('\nWould you like to view the cutout in the API GUI? [Y/N]:'),'s');
    if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1 | ...
            strcmp(Input,'N')==1 | strcmp(Input,'n')==1)
        break;
    end;
    disp(sprintf('\nInvalid input! Type Y or N.\n'));
end;

if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1)
    image(cutout);
end;

%% Detection
Input=input('Press enter to start Mitochondria Detection','s');

disp(sprintf('\nStarting Mitochondria Detection:\n'));
% You can change model and CodeBook if you did your own training
Model=getfield(load('RFModel500_5.mat'),'RFModel'); %Random Forest Model Used
CodeBook=getfield(load('CodeBook.mat'),'CodeBook'); %CodeBook for Bag-of-Words used

imagestack=cutout.data;

[BinaryResult,MitochondriaSV]=DetectionAPI(imagestack,Model,CodeBook);

%% Viewing results.
while true
    Input=input(sprintf('\nWould you like to view the results in a GUI? [Y/N]:'),'s');
    if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1 | ...
            strcmp(Input,'N')==1 | strcmp(Input,'n')==1)
        break;
    end;
    disp(sprintf('\nInvalid input! Type Y or N.\n'));
end;

if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1)
    GUIResults(imagestack,BinaryResult);
    disp(sprintf(strcat('\nNote: The color of the mitochondria detected shown in GUI',...
        '\nmay not be the same as those of the mitochondria uploaded',...
        '\nto the OCP API (should you later choose to upload the results).',...
        '\nHowever, the detected mitochondria pixel positions will be the same.',...
        '\nThe GUI is here just to visually show the results.')));
end;

%% Saving Results

disp(fprintf(strcat('\nSaving Results Option:\n',...
                    'You can save your results.\n',...
                    'For memory purposes, only the Binary Result\n',...
                    'and the Mitochondria SuperVoxels are saved.\n',...
                    'To view the colored results in a GUI, use the\n',...
                    'GUIResult function.')));
while true
    Input=input(sprintf('\nWould you like to save your results:'),'s');
    if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1 | ...
            strcmp(Input,'N')==1 | strcmp(Input,'n')==1)
        break;
    end;
    disp(sprintf('\nInvalid input! Type Y or N.\n'));
end;

if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1)
    Input=input(sprintf('\nWhat would you like to name the saved file?:'),'s');
    save(Input,'BinaryResult','MitochondriaSV');
end;

%% Upload back to API (based on annotation token)
% Note: The colors of the mitochondria uploaded back may not be the same as
% those in RGBResult.
while true
    Input=input(sprintf('\nWould you like to upload results to API? [Y/N]:'),'s');
    if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1 | ...
            strcmp(Input,'N')==1 | strcmp(Input,'n')==1)
        break;
    end;
    disp(sprintf('\nInvalid input! Type Y or N.\n'));
end;

if (strcmp(Input,'Y')==1 | strcmp(Input,'y')==1)
    
    fprintf(sprintf('\nStarting Upload.\n'));
    
    author=input('Name of Author of Results:','s');
    
    labels=bwconncomp(BinaryResult,26);
    mitoObj=cell(labels.NumObjects,1);
    for i=1:1:labels.NumObjects
        fprintf('Now processing mitochondria: %d of %d\n', i, labels.NumObjects);
        pixelIdx = labels.PixelIdxList{i};
        [idxY,idxX,idxZ]=ind2sub(size(BinaryResult),pixelIdx);

        m=RAMONOrganelle();
        m.setClass(eRAMONOrganelleClass.mitochondria);
        pixGlobal=cutout.local2Global([idxX,idxY,idxZ]);
        m.setVoxelList(uint32(pixGlobal));
        m.setResolution(cutout.resolution);
        m.setAuthor(author);
        mitoObj{i,1}=m;
    end;
    
    IDs=zeros(1,size(mitoObj,1));
    tic
    for i=1:1:size(mitoObj,1)
        try
            ID=oo.createAnnotation(mitoObj{i,1},eOCPConflictOption.overwrite);
            IDs(1,i)=ID;
            fprintf('Uploaded mitochondria annotation: %d of %d\n', i, size(mitoObj,1));
        catch
            fprintf('Unable to upload annotation: %d of %d\n',i,size(mitoObj,1));
            continue
        end;
    end;
    toc
    C=clock;
    DateTime=strcat(AnnoTokenStr,'IDs',num2str(C(2)),'_',num2str(C(3)),...
        '_',num2str(C(1)),'_',num2str(C(4)),'_',num2str(C(5)));
    fprintf(strcat('\nSaving IDs for Annotation Token as ',DateTime,'\n'));
    save(DateTime,'IDs');
end;

%% Thank you Open Connectome Project

