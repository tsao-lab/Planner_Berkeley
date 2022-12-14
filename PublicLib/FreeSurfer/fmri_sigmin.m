function [minsig, iminsig, indminsig] = fmri_minsig(sig)
% [minsig, iminsig, indminsig] = fmri_minsig(sig)
% 
% sig: - raw significance values (nrows X ncols X nplanes)

if(nargin ~= 1)
  msg = '[minsig, iminsig, indminsig] = fmri_minsig(sig)'
  qoe(msg); error(msg);
end

[minsig iminsig] = min(abs(sig),[],3);

%% Go through some gymnastics to get the signed pmin %%
[nrows ncols nplanes] = size(psig);
xx = [1:nrows]' * ones(1,ncols); %'
I1 = reshape1d(xx);
I2 = reshape1d(xx'); %'
indminsig = sub2ind(size(pSig),I1,I2,reshape1d(iminsig));
minsig    = reshape(sig(indminsig), [nrows ncols]);      

% Bonferoni Correction
minsig = minsig * size(sig,3);  

return;
