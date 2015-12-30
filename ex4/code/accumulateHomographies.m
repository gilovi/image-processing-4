function Htot = accumulateHomographies(Hpair,m)
% ACCUMULATEHOMOGRAPHY Accumulate homography matrix sequence.
% Arguments:
% Hpair - Cell array of M-1 3x3 homography matrices where Hpairfig is a
% homography that transforms between coordinate systems i and i+1.
% m - Index of coordinate system we would like to accumulate the
% given homographies towards (see details below).
% Returns:
% Htot - Cell array of M 3x3 homography matrices where Htotfig transforms
% coordinate system i to the coordinate system having the index m.
% Note:
% In this exercise homography matrices should always maintain
% the property that H(3,3)==1. This should be done by normalizing them as
% follows before using them to perform transformations H = H/H(3,3).
    Htot = cell(1,length(Hpair) + 1);
    Htot{m} = eye(3);
    for i = m-1:-1:1
        H_i = Htot{i+1} * Hpair{i};
        %renormalize
        H_i = H_i./H_i(3,3);
        Htot{i} = H_i;
    end
    
    for i = m:length(Hpair)
        H_i = Htot{i} / (Hpair{i});
        %renormalize
        H_i = H_i./H_i(3,3);
        Htot{i+1} = H_i;
    end


end