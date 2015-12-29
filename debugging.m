
%im1 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'oxford1.jpg'],1);
%im2 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'oxford2.jpg'],1);
im1 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'office1.jpg'],1);
im2 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'office2.jpg'],1);
im3 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'office3.jpg'],1);
im4 = imReadAndConvert(['ex4' filesep 'data' filesep 'inp' filesep  'examples' filesep 'office4.jpg'],1);
im = {im1,im2,im3,im4};
pyr1 = GaussianPyramid(im1,3,5);
pyr2 = GaussianPyramid(im2,3,5);
pyr3 = GaussianPyramid(im2,3,5);
pyr4 = GaussianPyramid(im2,3,5);

[pos1, desc1] = findFeatures(pyr1);
[pos2, desc2] = findFeatures(pyr2);
[pos3, desc3] = findFeatures(pyr3);
[pos4, desc4] = findFeatures(pyr4);


[ind1,ind2] = matchFeatures(desc1, desc2, 0.85);

pos1 = pos1(ind1,:);
pos2 = pos2(ind2,:);

[H12,inlind] = ransacHomography(pos1, pos2, 10000, 0.15);

%displayMatches(im1,im2,pos1,pos2,inlind);
acb = accumulateHomographies ({H12},2);
acH = accumulateHomographies ({H12},1);
figure;
imshow(renderPanorama1({im1,im2},acb));