
im1 = imReadAndConvert('ex4\data\inp\examples\oxford1.jpg',1);
im2 = imReadAndConvert('ex4\data\inp\examples\oxford2.jpg',1);
pyr1 = GaussianPyramid(im1,3,5);
pyr2 = GaussianPyramid(im2,3,5);
[pos1, desc1] = findFeatures(pyr1);
[pos2, desc2] = findFeatures(pyr2);

[ind1,ind2] = matchFeatures(desc1, desc2, 1);

pos1 = pos1(ind1,:);
pos2 = pos2(ind2,:);

%inlind = ransacHomography(pos1, pos2, 100, 0.1);

displayMatches(im1,im2,pos1,pos2,5);
