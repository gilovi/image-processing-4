%
% This script generates all of the provided example panoramas (once your 
% generatePanorama.m is ready and functional). Input images are read from 
% ../data/inp/examples and resulting panorams are then saved to 
% ../data/out/examples
%

warning('OFF','images:initSize:adjustingMag');
tic;
numFrames = 2;
inpPathFormat = (['..\' filesep 'data\' filesep 'inp\' filesep 'examples\' filesep 'oxford%d.jpg']);
outPath = (['..\' filesep 'data\' filesep 'out\' filesep 'examples\' filesep 'oxford.jpg']);
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;
tic;
numFrames = 3;
inpPathFormat = (['..\' filesep 'data\' filesep 'inp\' filesep 'examples\' filesep 'backyard%d.jpg']);
outPath = (['..\' filesep 'data\' filesep 'out\' filesep 'examples\' filesep 'backyard.jpg']);
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;

tic;
numFrames = 4;
inpPathFormat = (['..\' filesep 'data\' filesep 'inp\' filesep 'examples\' filesep 'office%d.jpg']);
outPath = (['..\' filesep 'data\' filesep 'out\' filesep 'examples\' filesep 'office.jpg']);
renderAtFrame = ceil(numFrames/2);
generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
toc;
pause(2);
close all;


bonus=true;

if bonus
	numFrames = 2;
    inpPathFormat = (['..\' filesep 'data\' filesep 'inp\' filesep 'examples\' filesep 'parallax%d.jpg']);
    outPath = (['..\' filesep 'data\' filesep 'out\' filesep 'examples\' filesep 'parallax.jpg']);
	renderAtFrame = ceil(numFrames/2);
	generatePanorama(inpPathFormat,outPath,numFrames,renderAtFrame,true);
	pause(2);
	close all;
end

warning('ON','images:initSize:adjustingMag');
