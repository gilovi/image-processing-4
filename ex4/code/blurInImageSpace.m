function blurImage = blurInImageSpace(inImage,kernelSize)
% UNTITLED6 a function that performs image 
% blurring using convolution between the image f and a gaussian kernel g
 
k = conv2([1 1], [ 1 1 ]');
% using the convolution theorm to iteratively convulute the kernel:
kernel = ifft2((fft2(k,kernelSize,kernelSize)).^ (kernelSize-1));
kernel = kernel/sum(sum(kernel)); %normalize the kernel

blurImage = conv2(inImage,kernel,'same');

end

