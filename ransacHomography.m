function [H12,inliers] = ransacHomography(pos1,pos2,numIters,inlierTol)
% RANSACHOMOGRAPHY Fit homography to maximal inliers given point matches
% using the RANSAC algorithm.
% Arguments:
% pos1,pos2 ? Two Nx2 matrices containing n rows of [x,y] coordinates of
% matched points.
% numIters ? Number of RANSAC iterations to perform.
% inlierTol ? inlier tolerance threshold.
% Returns:
% H12 ? A 3x3 normalized homography matrix.
% inliers ? A kx1 vector where k is the number of inliers, containing the indices in pos1/pos2 of the maximal set of
% inlier matches found.
    
    match = 0;
    for i = 1:numIters
        perm = randperm(length(pos1),4);
        samp1 = pos1(perm,:);
        samp2 = pos2(perm,:);

        h12 = leastSquaresHomography(samp1,samp2);
        try
        pos1_t = applyHomography(pos1,h12);
        catch
            pos1_t = inf(size(pos2));
        end
        norm = sum((pos1_t - pos2).^2, 2);
        
        ind = norm < inlierTol;
        if sum(ind) > match
            inliers = find(ind);
            match = sum(ind);
            H12 = h12;
            j=i
        end
        
    end 

end