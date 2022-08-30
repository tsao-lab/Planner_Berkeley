
%%
% atlas = MRIread('D:\Jialiang\Data\MRI\Atlas\D99_v2.0_dist\D99_atlas_v2.0_ebz.nii');
info = niftiinfo('D:\Jialiang\Data\MRI\Atlas\D99_v2.0_dist\D99_atlas_v2.0_ebz.nii');
V = niftiread(info);
idc = unique(V);
% idc2 = reshape(idc, 1, 1, 1, []);
% v = abs(V-idc2)==0;
se = strel('sphere', 2);
v0 = V*0;

%%
fprintf('\n   ');
for k = 1:length(idc)
    fprintf('\b\b\b%3d', k);
%     v1 = v(:, :, :, k);
%     v2 = imerode(v1, se);
%     v(:, :, :, k) = v1-v2;
%     v0(bwperim(v(:, :, :, k), 26)) = idc(k);
    v0(bwperim(V==idc(k), 26)) = idc(k);
end
fprintf('\n');

%%
niftiwrite(v0, 'D:\Jialiang\Data\MRI\Atlas\D99_v2.0_dist\D99_atlas_v2.0_ebz_edge.nii', info);
