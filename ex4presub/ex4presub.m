display(' ');
display('Started ex4 pre-submission script.');
display(' ');
display('Disclaimer');
display('----------');
display('The purpose of this script is to make sure that your code is compliant');
display('with the exercise API and some of the requirements');
display('The script does not test the quality of your results.');
display('Don''t assume that passing this script will guarantee that you will get');
display('a high grade in the exercise');
display(' ');
display('- Closing all open figures (hope you don''t mind)...');
close all;

display('Files check');
display('-----------');
ex4_dir = 'ex4_dir';
unzip('ex4.zip',ex4_dir);
list=dir(ex4_dir);
dirs={list.name};
school_dirs= {'.',    '..',    'code',    'data'};
if ~ismember(dirs,school_dirs)
    display('- Failed ');
    return;
end
code_list=dir([ex4_dir '/code']);
code_dirs={code_list.name};
school_code_dirs={'GaussianPyramid.m','HarrisCornerDetector','LaplacianPyramid.m','LaplacianToImage.m'...
    ,'accumulateHomogr...' ,   'applyHomography.m',    'blurInImageSpace.m',    'displayMatches.m' ,   'examplePanoramas.m'...
    'findFeatures.m'  ,  'generatePanorama.m'  ,  'imReadAndConvert.m' ,   'leastSquaresHomography.m'  ,  'matchFeatures.m'...
    'myPanorama.m'  ,  'nonMaximumSuppression.m'   , 'pyramidBlending.m' ,   'ransacHomography.m'   , 'renderPanorama.m'...
    'sampleDescriptor.m'  ,  'spreadOutCorners.m'};
if ~ismember(school_code_dirs,code_dirs)
    display('- Failed ');
    return;
end

data_list=dir([ex4_dir '/data']);
data_dirs={data_list.name};
school_data_dirs={'.'    '..'    'inp'    'out'};
if ~ismember(data_dirs,school_data_dirs)
    display('- Failed ');
    return;
end

out_examples = dir([ex4_dir '/data/out/examples']);
out_examples = {out_examples.name};
school_out_examples={'.'    '..'    'backyard.jpg'    'office.jpg'    'oxford.jpg'    'paralax.jpg'    'parallax.jpg'};
if ~ismember(out_examples,school_out_examples)
    display('- Failed ');
    return;
end
in_examples = dir([ex4_dir '/data/inp/examples']);
in_examples = {in_examples.name};
school_in_examples={    '.'    '..'    'backyard1.jpg'    'backyard2.jpg'    'backyard3.jpg'    'office1.jpg'...
    'office2.jpg'    'office3.jpg'     'office4.jpg'    'oxford1.jpg'    'oxford2.jpg'    'parallax1.jpg'    'parallax2.jpg'};
if ~ismember(in_examples,school_in_examples)
    display('- Failed ');
    return;
end
display('- Passed.');
close all;

addpath([ex4_dir '/code']);


display(' ');
filename='gorila.jpg';
imshow(filename);
grayIm=rgb2gray(im2double(imread(filename)));

display('Section 3.1');
display('-----------');
try
    display('- Harris Corner Detector...');
    pos = spreadOutCorners(grayIm,7,7,3);
    pyr=GaussianPyramid(grayIm,3,3);
    [pos,desc] = findFeatures(pyr);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    return;
end
display('- Passed.');
close all;

display('Section 3.2');
display('-----------');
try
    display('- Matching descriptors...');
    grayOffice1=rgb2gray(im2double(imread('office1.jpg')));
    grayOffice2=rgb2gray(im2double(imread('office2.jpg')));
    pyr1=GaussianPyramid(grayOffice1,3,3);
    pyr2=GaussianPyramid(grayOffice2,3,3);
    [pos1,desc1] = findFeatures(pyr1);
    [pos2,desc2] = findFeatures(pyr2);
    [ind1,ind2] = matchFeatures(desc1,desc2,0.33);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    return;
end
display('- Passed.');

close all;

display('Section 3.3');
display('-----------');
try
    display('- Transformation registering...');
    [H12,inliers] = ransacHomography(pos1(ind1,:),pos2(ind2,:),1500,9);
    displayMatches(grayOffice1,grayOffice2,pos1(ind1,:),pos2(ind2,:),inliers);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    return;
end
display('- Passed.');
close all;

display('Section 4');
display('-----------');
try
    display('- Panorama stiching...');
    m=cell(2,1);
    m{1}=grayOffice1;
    m{2}=grayOffice2;
    Htot = accumulateHomographies({H12},1);
    panorama = renderPanorama(m,Htot);
    imshow(panorama);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    return;
end
display('- Passed.');

display(' ');
display('- Pre-submission script done.');
display(' ');

display('Please go over the output and verify that there are no failures/warnings.');
display('Remember that this script tested only some basic technical aspects of your implementation');
display('It is your responsibility to make sure your results are actually correct and not only')
display('technically valid.');
