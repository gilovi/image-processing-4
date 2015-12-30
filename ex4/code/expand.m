function [exp_im] = expand(orig_im, factor , filter)
%expands an image 'orig_im' by factor 'factor'
%i = 1:length(orig_im);
filter = filter.*2;
im_size =  size(orig_im);
filt_len = length(filter)-1;
%blur_mask = arrayfun(@(filt) conv2(filt,filt')*4, filter);

%i=1:length(factor);
exp_im(1 : factor : im_size(1)*factor , 1 : factor : im_size(2)*factor) = orig_im;
exp_im = padarray(exp_im, [1,1],0, 'post');
%%exp_im = im2double(exp_im);
%managing borders with mirroring
pad_im = padarray(exp_im ,[filt_len,filt_len],'symmetric');
exp_im = conv2(conv2(pad_im ,filter ,'same'), filter','same');
%cutting the image to original size
exp_im = exp_im(filt_len+1: end-filt_len , filt_len+1: end-filt_len);

end

