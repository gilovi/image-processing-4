function pos = HarrisCornerDetector( im )
% HARRISCORNERDETECTOR Extract key points from the image.
% Arguments:
% im ? nxm grayscale image to find key points inside.
% pos ? A Nx2 matrix of [x,y] key points positions in im.
x_ker = [1 0 -1];
y_ker = [1 ; 0 ; -1];

Ix = conv2(im , x_ker,'same');
Iy = conv2(im , y_ker,'same');

IxIy = blurInImageSpace(Ix .* Iy, 3);
I2x = blurInImageSpace(Ix.^2, 3);
I2y = blurInImageSpace(Iy.^2, 3);

det_M = I2x .* I2y - IxIy.^2 ;
trace_M = I2x + I2y;
R = det_M - 0.04 * (trace_M).^2;

[r,c] = find(nonMaximumSuppression(R));
pos = cat(2,c,r);

end