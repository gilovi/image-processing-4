function [pyr, filter] = GaussianPyramid(im, maxLevels, filterSize)
%
%sub_samp = filterSize-1;
%% prepare blur mask
    k = [1 1];
    % using the convolution theorm to iteratively convulute the kernel:
    filter = ifft((fft(k,filterSize)).^ (filterSize-1));
    %normalizing
    filter = filter/sum(filter(:));
    
%% filling pyr

    pyr{1} = im;
    for i = 2:maxLevels
        if any(size(pyr{i-1})/2<16)
            break
        end
         pyr{i} = reduce(pyr{i-1} , 2 , filter);
    end
    pyr = pyr';
end

