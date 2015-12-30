function [mask] = dynamic_seam(d)
% DYNAMIC_SEAM finds the lowest cost path in the input cost matrix in terms
% of dynamic programming (not the true minimum as in min-cut)
% Arguments:
% d - the cost matrix 
% Returns:
% mask - a binari mask with size = size(d) which represents the seam.
% all cells left to the seam (including) result to be 1, the cells right to the seam -0 
    [r, c] = size(d);

    mask = zeros(size(d));

    chart = padarray(d, [0, 1], Inf);    
    backtrack = zeros(r, c);

%chart_rows = size(chart, 1);
%establish a matrix of triple neighbouring linear indices in the first row
base_ind = bsxfun(@plus,(1:r:2*r+1)',(0:c-1)*r);
for i = 2 : r
    ind = base_ind + i-2; % linear indices for the row of this iteration
    [x, pos] = min(chart(ind),[],1); 
    chart(i,2:c+1) = chart(i,2:c+1) + x; 
    backtrack(i,1:c) = (1:c) + pos-2;
end

    [~, j] = min(chart(r, :));
    j = j - 1;

    for i = r : -1 : 1
        mask(i,1:j) = 1;
        j = min(max(1,j),c);
        j = backtrack(i, j);
    end
end