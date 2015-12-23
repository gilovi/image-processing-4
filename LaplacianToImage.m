function img = LaplacianToImage(lpyr, filter, coeffMultVec)
%LaplacianToImage reconstructs an image from a laplacian pyramid

 img = lpyr{end}.*coeffMultVec(end);
 for i = length(lpyr)-1:-1:1;
 img = (expand(img,2,filter) + (lpyr{i}.*coeffMultVec(i)));
 end

end
