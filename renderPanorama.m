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
    Min = [0 , 0];
    Max = [0 , 0];
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
    
    extr_x = extr_x - (extr_x(1)) + 1;
    %finding centers
%     cents = zeros(1,length(im));
%     for i = 1:length(im)
%         c = fliplr(round(size(im{i})./2));
%         c = applyHomography(c,H{i});
%         cents(:,i) = c (1);
%     end
    
    
    panorama = zeros(Max-Min+1)';
    [X,Y] = meshgrid(Min(1):Max(1) , Min(2):Max(2) );
    
    %strip = floor(conv([1 1],cents)./2);
    %strip = cat(2,min(X(:))-1,strip(2:end-1), max(X(:)));
    %strip = strip - min(strip) + 1;
    
    
    coords = [X(:), Y(:)];
    pano_pos = false(size(panorama));
    for i = 1:length(im)
       I = inv(H{i});
       I = I./I(3,3);
       orig = applyHomography(coords, I);
       
       Xo = (reshape(orig(:,1),size(X)));
       Yo = (reshape(orig(:,2),size(Y)));
       
       c_im = interp2(im{i},Xo,Yo);
       curr_pos = ~isnan(c_im);
       c_im(isnan(c_im)) = 0;
       
       if i == 1
            panorama = c_im;
       else
            mask = zeros(size(panorama));
            
            roi = zeros(size(panorama));
            mutal = pano_pos + curr_pos;
            
            roi(mutal==1) = inf; %only 1 figure
            roi(mutal==2) = abs(panorama(mutal==2) - c_im(mutal==2)).^2; %intersection of images
            roi = roi(:,max(extr_x(1,i) - 1,1): min(extr_x(2,i-1) + 1,size(roi,2)) );%taking only the true roi
            
            mask(:,max(extr_x(1,i) - 1,1): min(extr_x(2,i-1) + 1,size(panorama,2))) = dynamic_seam(roi);
            mask(:,1:extr_x(1,i) - 1) = 1;
            mask(:,extr_x(2,i-1) + 1 : end) = 0;
            
            %mask(:,1:strip(i)) = 1;
            panorama = pyramidBlending(panorama, c_im, mask, 5,5,4);
       end
       pano_pos = pano_pos | curr_pos; 
    end
    

end