function [red_im] = reduce( orig_im , factor , filter )
%
%blur_mask = conv2(filter,filter');
filt_len = length(filter)-1;
pad_im = padarray(orig_im ,[filt_len,filt_len],'symmetric');
blur_im = conv2(conv2(pad_im , filter ,'same'), filter' , 'same' );
blur_im = blur_im(filt_len+1: end-filt_len , filt_len+1: end-filt_len);
%subsample
red_im = blur_im(1:factor:end , 1:factor:end);



end

