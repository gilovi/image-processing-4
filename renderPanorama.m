function panorama = renderPanorama(im,H)
% RENDERPANORAMA Renders a set of images into a combined panorama image.
% Arguments:
% im - Cell array of n grayscale images.
% H - Cell array of n 3x3 homography matrices transforming the ith image
% coordinates to the panorama image coordinates.
% Returns:
% panorama - A grayscale panorama image composed of n vertical strips that
% were backwarped each from the relevant frame imfig using homography Hfig.
    
    %find min & max homography positions
    Min = [0, 0];
    Max = [0 ,0];
    extr_x = zeros(2,length(im));
    for i = 1:length(im)
       t = applyHomography([0, 0 ; 0, size(im{i},1) ; size(im{i},2), 0 ; size(im{i},2),  size(im{i},1) ], H{i});
       mn = round(min(t));
       Min(mn < Min) = mn(mn < Min);
       mx = round(max(t));
       Max(mx > Max) = mx(mx > Max);
       
       %update list of endpoints (for stiching)
       extr_x(:,i) = [mn(1),mx(1)]';
    end
    
    %finding centers
    cents = zeros(1,length(im));
    for i = 1:length(im)
        c = fliplr(round(size(im{i})./2));
        c = applyHomography(c,H{i});
        cents(:,i) = c (1);
    end
    
    
    pano = zeros(Max-Min+1)';
    [X,Y] = meshgrid(Min(1):Max(1) , Min(2):Max(2) );
    
    %centers = round((extr_x(1,:) + extr_x(2,:))./2);
    %s_centers = cat(2,centers(2:end),0);
    strip = round(conv([1 1],cents)./2);
    strip = cat(2,0,strip(2:end-1),size(pano,2))+1;
    d = diff(strip);
    X_slices = mat2cell(X,size(X,1),d);
    Y_slices = mat2cell(Y,size(Y,1),d);
    %mask = zeros(size(pano));
    for i = 1:length(im)
       %mask(:,1:strips(i)) = 1;
       coords = [X_slices{i}(:), Y_slices{i}(:)];
       
       orig = applyHomography(coords, inv(H{i}));
       Xo = round(reshape(orig(:,1),size(X_slices{i})));
       Yo = round(reshape(orig(:,2),size(Y_slices{i})));
       c_im = interp2(Xo,Yo, im{i}, X_slices{i},Y_slices{i});
       pano(:,strip(i):strip(i+1)-1) = c_im;
       %pyramidBlending()
       figure;imshow(pano)
    end
    
    panorama = pano;

end