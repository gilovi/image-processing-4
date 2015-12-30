function [pyr, filter] = LaplacianPyramid(im, maxLevels, filterSize)
%
[gauss,filter] = GaussianPyramid(im, maxLevels, filterSize);
pyr = cell(size(gauss));

for i=1:length(gauss)-1
    try
    pyr{i} = gauss{i} - expand(gauss{i+1} , 2 , filter );
    catch
        ex = expand(gauss{i+1} , 2 , filter );
        s = size(gauss{i});
        ex = ex(1:s(1),1:s(2));
        pyr{i} = gauss{i} - ex;
    end
end
pyr{end} = gauss{end};

end

