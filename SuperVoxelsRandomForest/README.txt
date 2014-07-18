README for Mitochondria Detection Project via Open Connectome Project API Matlab

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

Files with this project:
activecontour_2.m
CodeBook.mat
DetectionAPI.m
DetectSV.m
ErrorMetricsScript3D.m
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
TrainingDataScript.m


BEFORE YOU RUN THE SCRIPTS!!!:
1) Make sure you have the Open Connectome Project downloaded and installed from: http://www.openconnectomeproject.org/#!services/chru. The code for this API must be in your Matlab path via cajal3d script.

2) Make sure you have the VL Feat toolbox installed and in your Matlab path via vl_setup.  This can be downloaded from: http://www.vlfeat.org/.

3) Download the fast bilateral filter code from: http://www.mathworks.com/matlabcentral/fileexchange/36657-fast-bilateral-filter. Make sure this code is in your Matlab path.

4) Download the Matlab Random Forest code from Google via: https://code.google.com/p/randomforest-matlab/. Make sure you have RF_Class_C code in your Matlab path. Note: The Random Forest code is written in C. Hence, you will need to compile mex files to use Random Forest for Matlab. Instructions for compiling the mex files or using precompiled mex files are found on the site and README for the code. 
- Note: During the process of using Random Forest, issues occurred with compiling mex files on Mac computers for later versions of Matlab.  Hence, pre-compiled mex files (tested for Matlab 2014) for Mac 64-bit users can be found at: https://code.google.com/p/randomforest-matlab/issues/detail?id=54.     
 





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

	