function [ind1,ind2] = matchFeatures(desc1,desc2,minScore)
% MATCHFEATURES Match feature descriptors in desc1 and desc2.
% Arguments:
% desc1 - A kxkxn1 feature descriptor matrix.
% desc2 - A kxkxn2 feature descriptor matrix.
% minScore - Minimal match score between two descriptors required to be
% regarded as matching.
% Returns:
% ind1,ind2 - These are m?entry arrays of match indices in desc1 and desc2.
%
% Note:
% 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
% 2. The number of feature descriptors n1 generally differs from n2
% 3. ind1 and ind2 have the same length.

    desc1_len = size(desc1,3);
    desc2_len = size(desc2,3);
    
    desc1 = reshape(desc1 , numel(desc1)/desc1_len , desc1_len);
    desc2 = reshape(desc2 , numel(desc2)/desc2_len , desc2_len);
    
    corr = desc1' * desc2;
    
    %get 2 max vals of each
    [~,x] = sort(corr,1);
    [~,y] = sort(corr,2);
    x = x(1:end-2,:)';
    y = y(:,1:end-2)';
    [xr, xc] = size(x);
    [yr,yc] = size(y);
    [xl,~] = meshgrid(1:xr,1:xc);
    [~,yl] = meshgrid(1:yr,1:yc);
    
    corr(sub2ind(size(corr), x', xl) ) = nan;
    corr(sub2ind(size(corr), yl, y') ) = nan;
    
    % if 2 in the same row/col...
    m1 = max(corr,[],1);
    m2 = max(corr,[],2);
    corr (~(bsxfun(@eq,corr,m1) & bsxfun(@eq,corr,m2))) = 0;
%     [v,p] = max(corr);
%     p = p + [0:lenght(p)-1]*size(corr,1);
%     c =zeros(size(a));
%     c(p) = v;
%     corr = c;
    
    [ind1,ind2] = find(corr > minScore);  
end