

%
% read_freq_patch.m
%
% Original Author: Bruce Fischl
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2007/01/10 22:55:09 $
%    $Revision: 1.2 $
%
% Copyright (C) 2002-2007,
% The General Hospital Corporation (Boston, MA). 
% All rights reserved.
%
% Distribution, usage and copying of this software is covered under the
% terms found in the License Agreement file named 'COPYING' found in the
% FreeSurfer source code root directory, and duplicated here:
% https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferOpenSourceLicense
%
% General inquiries: freesurfer@nmr.mgh.harvard.edu
% Bug reports: analysis-bugs@nmr.mgh.harvard.edu
%



% Should run 'left or right' scripts to set up fname_* variable,s
% and set nfig so that plotting starts in the right location.
fclose('all');
fid=fopen(fname_patch,'rt');
s = fgetl(fid);
s = fgetl(fid);
[poly,count] = sscanf(s,'%d');
numvert = poly(1);
numquad = poly(2);
vertex_coordinates = zeros(3,1);
face_index = zeros(4,1);
vertx_list = zeros(numvert,3);
face_list = zeros(numquad,5);
tic;
for vert = 1:1:(numvert),
    s = fgetl(fid);
    vertx = sscanf(s,'%d');
    s = fgetl(fid);
    vertx_coordinates = sscanf(s,'%f');
    vertx_list(vert,:) = [vertx_coordinates(1:2)' vertx];
end
toc
tic;
for face = 1:1:(numquad),
    s = fgetl(fid);
    facenum = sscanf(s,'%d');
    s = fgetl(fid);
    face_vertx = sscanf(s,'%d');
    face_list(face,:) = [face_vertx' facenum];
end
toc
fclose(fid);
full_vertx=zeros(max(max(vertx_list))+1,3);
full_vertx(vertx_list(:,3)+1,1)=vertx_list(:,1);
full_vertx(vertx_list(:,3)+1,2)=vertx_list(:,2);
mesh_real=File2Var(fname_real);
vertx_values=zeros(max(max(vertx_list))+1,1);
vertx_values(vertx_list(:,3)+1)=mesh_real(:,5);
mesh_imag=File2Var(fname_imag);
vertx_complex=zeros(max(max(vertx_list))+1,1);
vertx_complex(vertx_list(:,3)+1)=mesh_imag(:,5);
v_complex = vertx_values(:,1) + i*vertx_complex;
v_phase=angle(v_complex');

strpwd=pwd;
subplot(4,3,nfig+1);
title([strpwd((length(strpwd)-25):length(strpwd)) ' ' fname_real]);
p_freq_handle=patch('Vertices',full_vertx,'Faces',face_list(:,1:4)+1,'FaceVertexCData',v_phase','FaceColor','interp','EdgeColor','none');
%colormap(rgb(256));
colorbar;
%tic; t_unwrap=unwrap(angle(v_complex)); toc

short_complex = mesh_real(:,5) + (i*mesh_imag(:,5));
short_unwrap=angle(short_complex);
[zmat_freq,xvec,yvec]=ffgrid(vertx_list(:,1),vertx_list(:,2),short_unwrap,1.0,1.0);
subplot(4,3,nfig+2);
imagesc(xvec,yvec,zmat_freq);
axis xy;
%colormap(rgb(64));
colorbar;
subplot(4,3,nfig+3);
contour(xvec,yvec,zmat_freq,20);
%figure;

%ffgrid(vertx_list(:,1),vertx_list(:,2),short_unwrap,0.75,0.75); 
[zmat_imag_freq,xvec,yvec]=ffgrid(vertx_list(:,1),vertx_list(:,2),mesh_imag(:,5),1.0,1.0);
[zmat_real_freq,xvec,yvec]=ffgrid(vertx_list(:,1),vertx_list(:,2),mesh_real(:,5),1.0,1.0);
smooth_filt = fspecial('average',3);
zmat_freq_cplx = zmat_real_freq + (i*zmat_imag_freq);
zmat_imag_smooth = zmat_imag_freq;
zmat_real_smooth = zmat_real_freq;
maxiter=2;
for niter=1:maxiter,
  zmat_imag_smooth = filter2(smooth_filt,zmat_imag_smooth);
  zmat_real_smooth = filter2(smooth_filt,zmat_real_smooth);
end
zmat_smooth_freq = angle(zmat_real_smooth + (i*zmat_imag_smooth));
zmat_smooth_freq_cplx = zmat_real_smooth + (i*zmat_imag_smooth);
subplot(4,3,nfig+5);
imagesc(xvec,yvec,zmat_smooth_freq); axis xy;
subplot(4,3,nfig+6);
imcontour(xvec,yvec,zmat_smooth_freq,20);
