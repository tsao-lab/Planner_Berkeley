% Simple script to recode paradigm files

oldparname = 'main3.par';
newparname = 'main3.new.par';

% Fill the condmap with the mapping between the
% old and new conditions. The first number is the
% old condition number, the second number is the
% condition number it maps to. Do not use an index
% of zero (ie, condmap(0,:)). Make sure all the 
% indices are contiguous.
clear condmap;
condmap(1,:) = [1 2];
condmap(2,:) = [2 1];
condmap(3,:) = [3 0];
condmap(4,:) = [0 3];

oldpar = fmri_ldpar(oldparname);

newpar = oldpar;

for c = 1:size(condmap,1)
  ind = find(oldpar(:,2) == condmap(c,1));
  newpar(ind,2) = condmap(c,2);
end

fmri_svpar(newpar,newparname);
