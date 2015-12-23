function displayMatches(im1,im2,pos1,pos2,inliers)
% DISPLAYMATCHES Display matched pt. pairs overlayed on given image pair.
% Arguments:
% im1,im2 ? two grayscale images
% pos1,pos2 ? Nx2 matrices containing n rows of [x,y] coordinates of matched
% points in im1 and im2 (i.e. the i’th match’s coordinate is
% pos1(i,:) in im1 and and pos2(i,:) in im2).
% inliers ? A kx1 vector of inlier matches (e.g. see output of
% ransacHomography.m)

    the_big_image = cat(2,im1,im2);
    shift = size(im1,2);
    figure;imshow(the_big_image);
    hold on 
    plot (pos1(:,1),pos1(:,2),'r.');
    plot (pos2(:,1)+shift,pos2(:,2),'r.');
    
    
end