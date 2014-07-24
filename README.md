object-recognition
==================

repo for duke summer program on electron microscopy computer vision

README for Mitochondria Detection Project via Open Connectome Project API Matlab
Github Repository: https://github.com/openconnectome/object-recognition.git
Slideshare: http://www.slideshare.net/coco1290/mitochondria-detection

To get the code for this project, download the directory:
SuperVoxelsRandomForest
(the other directories are irrelevant)

Main Authors:
Joy Patel
Courtney Smith

Other Contributors:
Joshua Vogelstein
Will Gray
Chris Tralie
Guillermo Sapiro
Paul Bendich
Rann Bar-On
John Harer
Roger Zou
Julia Ni
Dean Kleissas
Duke University Math RTG

Code and Files with this project:
activecontour_2.m
CodeBook.mat
DetectionAPI.m
DetectSV.m
ErrorMetrics3D.m
GUIResults.m
MakeCodeBook.m
MakeR100Vectors.m
MitochondriaDetection.m
README.txt
RFClassifierInputsSV.m
RFClassifierModel.m
RFModel500_5.mat
SuperVoxel.m
SuperVoxelize.m
SVStats.m
TrainingData.m


BEFORE YOU RUN THE SCRIPTS!!!:
1) Make sure you have the Open Connectome Project API Version 1.2 downloaded and installed from: http://www.openconnectomeproject.org/#!services/chru. There is a README with the API code which has instructions for installation. Add the code for this API in your Matlab path via cajal3d script.

2) Make sure you have the VL Feat toolbox Version 0.9.18 installed.  This can be downloaded from: http://www.vlfeat.org/.  There is a README with this toolbox for installation purposes.  Add the code for this toolbox in your Matlab path via the vl_setup script (make sure to use this script when adding to path).

3) Download the fast bilateral filter code from: http://www.mathworks.com/matlabcentral/fileexchange/36657-fast-bilateral-filter. Make sure the entire code for this is in your Matlab path.

4) Download the Matlab Random Forest Version 0.02 code from Google via: https://code.google.com/p/randomforest-matlab/downloads/list; download the RF_MexStandalone-v.0.02.zip for the actual Random Forest Code; then, based on your operating system, compile or download the pre-compiled mex files. Add RF_Class_C directory code to your Matlab path. Reminder: The Random Forest code is written in C. Hence, you will need to get mex files to use Random Forest for Matlab. Instructions for compiling the mex files or using precompiled mex files are found on the site and README for the code.
- For Linux and Windows, run the compile_linux.m or compile_windows.m script, respectively, in the RF_Class_C directory; the mex files should compile in the src directory.
- For Mac, follow the procedures on the website.  
- Note: During the process of using Random Forest, issues occurred with compiling mex files on Mac computers for later versions of Matlab.  Hence, pre-compiled mex files (tested for Matlab 2014) for Mac 64-bit users can be found at: https://code.google.com/p/randomforest-matlab/issues/detail?id=54.  Put the pre-compiled mex files in RF_Class_C/src/.
Add RF_Class_C directory code to your Matlab path (for all users).     
 


Mitochondria Detection:
The MitochondriaDetection.m script is the main script to use for detection.  This script, downloads data from the Open Connectome Project, detects mitochondria, and re-uploads annotations back to API. An example of the inputs is shown further below.

Example Demo using default properties: Run MitochondriaDetection (the program will ask for inputs in the command window; follow along with this demo)
	>> MitochondriaDetection
	Creating OCP object:
	
	Server Location:
	Default is http://braingraph1dev.cs.jhu.edu
	To use default, just press enter.
	Otherwise, enter the name of desired Server Location:(press enter)
	
	Image Token:
	Default is kasthuri11cc
	To use default, just press enter.
	Otherwise, enter the name of desired Image Token:(press enter)
	
	Annotation Token:
	(Note: There is no default)
	Enter the name of Annotation Token to be used:duke_test1
(NOTE: THIS IS NOT A DEFAULT; duke_test1 IS A SPECIFIC ANNOTATION TOKEN THAT I USE! MAKE SURE TO CHANGE THIS TO YOUR ANNOTATION TOKEN!)

	Resolution OCP Object:
	Default is 1
	To use default, just press enter.
	Otherwise, enter the desired Resolution:(press enter)
	
	Setting Image Dense Query
	
	Set the xRange, yRange, and zRange
	Default ranges are those for AC4 images
	Default xRange: [4400, 5424]
	Default yRange: [5440, 6464]
	Default zRange: [1100, 1200]
	To use default, just press enter.
	Otherwise, enter range in [min, max] format.
	xRange:(press enter)
	yRange:(press enter)
	zRange:(press enter)
		
	Resolution for Image Dense Query:
	Default is 1
	To use default, just press enter.
	Otherwise, enter the desired Resolution:(press enter)
	
	pf =

     		1


	msg =

     		''

	Would you like to view the cutout in the API GUI? [Y/N]:Y
	Press enter to start Mitochondria Detection:(press enter)
	
	Starting Mitochondria Detection:
	(Processed image: 1->100)
	
	Would you like to view the results in a GUI? [Y/N]:Y
	
	Note: The color of the mitochondria detected shown in GUI
	may not be the same as those of the mitochondria uploaded
	to the OCP API (should you later choose to upload the results).
	However, the detected mitochondria pixel positions will be the same.
	The GUI is here just to visually show the results.
	
	Saving Results Option:
	You can save your results.
	For memory purposes, only the Binary Result
	and the Mitochondria SuperVoxels are saved.
	To view the colored results in a GUI, use the
	GUIResult function.
	
	Would you like to save your results:Y
	
	What would you like to name the saved file?Results
	
	Would you like to upload results to API? [Y/N]:Y
	
	Starting Upload.
	Name of Author of Results:Joy
(NOTE: THIS IS NOT A DEFAULT! JOY IS MY NAME! CHANGE THIS TO YOUR DESIRED AUTHOR NAME!)
	
	Now processing mitochondria: (k of n)…
	
	Now uploading…

	>>




Making Model with your own Training Data:

You can also make your own training data. The inputs which you will need are imagestack 
(which is a downloaded image cube from the OCP API) and TruthData (which is a logical cube the same size as imagestack, but represents the manual binary annotations of mitochondria). 

Let imagestack be the 100 AC4 images from the API (i.e., the cutout from the default inputs) and TruthData be the mitochondria annotations.

First you need to make an CodeBook:
>> CodeBook=MakeCodeBook(imagestack,[1:2:40]); (i.e., making the code book from every other image from the first 40 images; usually, the CodeBook process is computationally expensive so best to make a CodeBook from subset of training data).

Next, you will need to get the True and False SuperVoxels:
>>[mito,notMito]=TrainingData(imagestack,TruthData,CodeBook,1,40); (i.e., get true and false mitochondria SuperVoxels from the first 40 images) 

Now, make the classifier:
[X,Y]=RFClassifierInputs(mito,notMito);
RFModel=RFClassifierModel(X,Y);
Note: You can go into the function, RFClassifierModel, to change the Random Forest settings.

To use self-generated models, change the “Detection” portion of the MitochondriaDetection script.



ErrorMetrics:
To use the ErrorMetrics script, you will need to save the results from the MitochondriaDetection and TruthData; the results you saved will be BinaryResult and MitochondriaSV.
To get ErrorMetrics:
>> ErrorMetrics3D(TruthData,BinaryResult,MitochondriaSV,60,100)
% of 3D Connected Components Truth Mitochondria 50-to-100percentOverlap Detected by Supervoxels:76.4045
% of 3D Connected Components Truth Mitochondria 20-to-50percentOverlap Detected by Supervoxels:12.3596
% of 3D Connected Components Truth Mitochondria 0-to-20percentOverlap Detected by Supervoxels:2.2472
% of 3D Connected Components Truth Mitochondria 0percentOverlap Detected by Supervoxels:8.9888
% of 2D Supervoxels Detected which were True Positives:86.2796
% of 2D Supervoxels Detected which were False Positives:13.7204
>>
These error metrics are printed out based on the last 40 images.


	
