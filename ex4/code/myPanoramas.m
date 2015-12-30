
warning('OFF','images:initSize:adjustingMag');
tic;
numFrames = 2;
inpPathFormat = ['..\' filesep 'data\' filesep 'inp\' filesep 'mine\' filesep 'omega%d.jpg'];
outPath = ['..\' filesep 'data\' filesep 'out\' filesep 'mine\' filesep 'omega.jpg'];
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;
tic;
numFrames = 2;
inpPathFormat = ['..\' filesep 'data\' filesep 'inp\' filesep 'mine\' filesep 'big_painting%d.jpg'];
outPath = ['..\' filesep 'data\' filesep 'out\' filesep 'mine\' filesep 'big_painting.jpg'];
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;


warning('ON','images:initSize:adjustingMag');
