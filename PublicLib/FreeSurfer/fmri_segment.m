function [ibrain, iair, thresh] = fmri_segment(img)
%
% [ibrain iair thresh] = fmri_segment(img)
%
% Segments the brain from the air using a single image.
% The algorithm simply measures the mean of the image
% and assigns everything over the mean to be brain
% and everything below to be air.
%
% $Id: fmri_segment.m,v 1.1 2003/03/04 20:47:40 greve Exp $

if(nargin ~= 1)
  msg = 'Usage: [ibrain iair thresh] = fmri_segment(img)';
  qoe(msg);error(msg);
end

[nRows nCols nRuns] = size(img);
nVoxels = nRows*nCols;
if(nRuns > 1) img = mean(img,3); end

thresh = mean(reshape(img,[nVoxels 1]));

ibrain = find(img >  thresh);
iair   = find(img <= thresh);

thresh = repmat(thresh, [1 nRuns]);
ibrain = repmat(ibrain, [1 nRuns]);
iair   = repmat(iair,   [1 nRuns]);

return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute histogram of the image
[h v] = hist(img, nVoxels/50);

% Find the indicies where the derivative of
% the histogram is positive
iPos_dH = find(sign(diff(h))==1);

%% Compute the segmentation threshold as the first point where the
%% derivative of the histogram is positive 
if isempty(iPos_dH) thresh = max(Img1d);
else                thresh = v(iPos_dH(1));
end

% Binarize so that subthreshold voxels are 0 and suprathreshold
% voxels are 1.
ibrain = find(img >  thresh);
iair   = find(img <= thresh);


return;
