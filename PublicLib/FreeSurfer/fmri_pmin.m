function [pSigMin, vpSigMin] = fmri_pmin(pSig,vSig)
% [pSigMin vpSigMin] = fmri_pmin(pSig)
% [pSigMin vpSigMin] = fmri_pmin(pSig, vSig)
%
% Returns the minimum significance from a vector of significance
% values.  pSig may be a 3d matrix in which case the minimum is
% searched for over the third dimension.  pSigMin would then be
% a 2d matrix of minimum significances at each point, corrected
% for the number of unplanned comparisons (Bonferoni correction).
%
% If vSig is included, it must be of the same dimension as pSig.
% vpSigMin is a 2d matrix with values from vSig that correspond
% to the same locations in pSig from which the values in pSigMin 
% came.
%
% $Id: fmri_pmin.m,v 1.1 2003/03/04 20:47:40 greve Exp $

if(nargin ~= 1 & nargin ~= 2)
  msg = 'USAGE: [pSigMin <vpSigMin>] = fmri_pmin(pSig, <vSig>)';
  qoe(msg);error(msg);
end

if(nargout == 2 & nargin == 1)
  msg = 'Must specify vSig to get vpSigMin';
  qoe(msg);error(msg);
end

%% Get dimensions %%
[r c nt] = size(pSig);
nv = r*c; % number of voxels %

%% reshape into time-points by voxels %%
pSig = reshape(pSig, [nv nt])'; %'

%% Get the minimum p values for each voxel %%
if(nt ~= 1)
  [pSigMin nt_pmin] = min(pSig);
else
  pSigMin = pSig;
  nt_pmin = ones(1,nv);
end

% Bonferoni Correction %
pSigMin = pSigMin*nt;

% Put back into rows and colums %
pSigMin = reshape(pSigMin,[r c]);

% Return if vpSigMin is not needed %
if(nargout == 1) return; end

% Get vSig values corresponding to pSigMin %
vSig = reshape(vSig, [nv nt])'; %'

%% Compute indicies of pSigMin voxel-timepoints %%
i_pmin = [0:nv-1]*nt + nt_pmin;

%% Extract vSig values %%
vpSigMin = vSig(i_pmin);

% Put them back into rows and colums %
vpSigMin = reshape(vpSigMin,[r c]);


return;
