function desc = sampleDescriptor(im,pos,descRad)
% SAMPLEDESCRIPTOR Sample a MOPS - like descriptor at given positions in the image.
% Arguments:
% im ? nxm grayscale image to sample within.
% pos ? A Nx2 matrix of [x,y] descriptor positions in im.
% descRad ? ”Radius” of descriptors to compute (see below).
% Returns:
% desc ? A kxkxN 3?d matrix containing the ith descriptor
% at desc(:,:,i). The per?descriptor dimensions kxk are related to the
% descRad argument as follows k = 1+2*descRad.
    level = 3;

    % transforming the position to the correct level position
    pos = 2^(1-level) .* (pos-1) + 1;
    [X,Y] = meshgrid(1:size(im,2),1:size(im,1));
    desc = zeros(1+2*descRad,1+2*descRad,length(pos));
    for i = 1 : length(pos)
        [Xp,Yp] = meshgrid((pos(i,1) - descRad : 1 : pos(i,1) + descRad) ,...
        (pos(i,2) - descRad : 1 : pos(i,2) + descRad) );
        curr_desc = interp2(X,Y,im,Xp,Yp);
        mu = mean(curr_desc(:));
        desc(:,:,i) = (curr_desc - mu) / norm(curr_desc(:) - mu);
    end  

end