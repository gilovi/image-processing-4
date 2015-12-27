function [pos,desc] = findFeatures(pyr)
% FINDFEATURES Detect feature points in pyramid and sample their descriptors.
% This function should call the functions spreadOutCorners for getting the keypoints, and
% sampleDescriptor for sampling a descriptor for each keypoint
% Arguments:
% pyr ? Gaussian pyramid of a grayscale image having 3 levels.
% Returns:
% pos ? An Nx2 matrix of [x,y] feature positions per row found in pyr. These
% coordinates are provided at the pyramid level pyr{1}.
% desc ? A kxkxN feature descriptor matrix.
    orig_im = pyr{1};
    [r,c] = size(orig_im);
    pos = spreadOutCorners(orig_im,round(r*.01),round(c*.01), 5);
    desc = sampleDescriptor(pyr{3}, pos, 3);

end