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
    in1 = pos1(inliers,:);
    in2 = pos2(inliers,:);
    out = true(1,length(pos1));
    out(inliers) = false;
    out1 = pos1(out,:);
    out2 = pos2(out,:);
 
    
    figure;imshow(the_big_image);
    hold on 
    plot (pos1(:,1),pos1(:,2),'r.');
    plot (pos2(:,1)+shift,pos2(:,2),'r.');
    
    out_X = cat(2,out1(:,1),out2(:,1)+shift);
    out_Y = cat(2,out1(:,2),out2(:,2));
    in_X = cat(2,in1(:,1),in2(:,1)+shift);
    in_Y = cat(2,in1(:,2),in2(:,2));
    plot(out_X',out_Y','b-');
    plot(in_X',in_Y','y-');
    
    
end