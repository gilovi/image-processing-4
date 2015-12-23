function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
%
[gauss,filter] = GaussianPyramid(im, maxLevels, filterSize);
pyr = cell(size(gauss));

for i=1:length(gauss)-1
    pyr{i} = gauss{i} - expand(gauss{i+1} , 2 , filter );
end
pyr{end} = gauss{end};

end

