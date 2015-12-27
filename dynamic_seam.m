function [seam] = dynamic_seam(energy)
    [r, c] = size(energy);

    seam = zeros(r);

    chart = padarray(energy, [0, 1], Inf);    
    backtrack = zeros(r, c);


base_ind = bsxfun(@plus,(1:rows_DP:2*rows_DP+1)',(0:c-1)*rows_DP);
for i = 2 : r
    ind = base_ind + i-2; %// setup linear indices for the row of this iteration
    [x, pos] = min(chart(ind),[],1); 
    chart(i,2:c+1) = chart(i,2:c+1) + x; 
    backtrack(i,1:c) = 1:c + pos-2;
end

    [~, j] = min(chart(r, :));
    j = j - 1;

    for i = r : -1 : 1
        seam(i) = j;
        j = backtrack(i, j);
    end
end