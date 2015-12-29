function img = LaplacianToImage(lpyr, filter, coeffMultVec)
%LaplacianToImage reconstructs an image from a laplacian pyramid

 img = lpyr{end}.*coeffMultVec(end);
 for i = length(lpyr)-1:-1:1;
 try
    img = (expand(img,2,filter) + (lpyr{i}.*coeffMultVec(i)));
    catch
        ex = expand(img,2,filter);
        s = size(lpyr{i});
        ex = ex(1:s(1),1:s(2));
        img = (ex + (lpyr{i}.*coeffMultVec(i)));
    end
 end

end
