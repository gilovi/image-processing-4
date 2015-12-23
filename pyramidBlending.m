function imBlend = pyramidBlending(im1, im2, mask, maxLevels, filterSizeIm, filterSizeMask)
%
maxLevels = floor(min(maxLevels, log2(min(size(im1))) - 3));
mask = im2double(mask);

[L1,filt] = LaplacianPyramid(im1,maxLevels, filterSizeIm);
[L2,~] = LaplacianPyramid(im2,maxLevels, filterSizeIm);

[G,~] = GaussianPyramid(mask, maxLevels, filterSizeMask);

Lo = cell(1, maxLevels);
for i = 1 : maxLevels
    Lo{i} = G{i}.*L1{i} + (1-G{i}).*L2{i};
end

imBlend =  LaplacianToImage(Lo, filt, ones(1, maxLevels));

end

