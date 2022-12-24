function strctAnatVol = fnQuickAddVolume(strFileName)
aiImageRes = [256,256];
strctMRI = MRIread(strFileName);
if size(strctMRI.vol,4) > 1
    strctMRI.vol = strctMRI.vol(:,:,:,1);
end
% strctMRI.vol = single(strctMRI.vol);
[strctCrossSectionHoriz,strctCrossSectionSaggital,strctCrossSectionCoronal] =...
    fnSetDefaultCrossSectionsCorrect(strctMRI.volsize, strctMRI.tkrvox2ras,...
    strctMRI.vox2ras0, aiImageRes(1),aiImageRes(2));
strctLinearHistogramStretch = fnBuildDefaultContrastTransform(strctMRI.vol);
strctAnatVol.m_strFileName = strFileName;
[~, strFile]=fileparts(strctAnatVol.m_strFileName);
strctAnatVol.m_strName = strFile;
strctAnatVol.m_a2fEB0 = strctCrossSectionHoriz.m_a2fM;
strctAnatVol.m_a2fEB0(:,3) = -strctAnatVol.m_a2fEB0(:,3);
strctAnatVol.m_a3fVol = strctMRI.vol;
strctAnatVol.m_afVoxelSpacing = strctMRI.volres;
strctAnatVol.m_aiVolSize = size(strctMRI.vol);
strctAnatVol.m_a2fTk = strctMRI.tkrvox2ras;

% strctAnatVol.m_a2fAtlasReg  = eye(4);
% a2fTmp = inv(strctMRI.vox2ras0(1:3,1:3));
% strctAnatVol.m_a2fAtlasReg(1:3,1) = a2fTmp(1:3,1) ./ norm(a2fTmp(1:3,1));
% strctAnatVol.m_a2fAtlasReg(1:3,2) = a2fTmp(1:3,2) ./ norm(a2fTmp(1:3,2));
% strctAnatVol.m_a2fAtlasReg(1:3,3) = a2fTmp(1:3,3) ./ norm(a2fTmp(1:3,3));
% strctAnatVol.m_a2fAtlasReg(1:3,3) = -strctAnatVol.m_a2fAtlasReg(1:3,3);
% strctAnatVol.m_a2fAtlasReg = ...
%     [-1  0  0  0;...
%       0  0  1  0;...
%       0  1  0  0;...
%       0  0  0  1];
strctAnatVol.m_a2fAtlasReg = eye(4);
strctAnatVol.m_a2fM = strctMRI.vox2ras0;

strctAnatVol.m_a2fReg = eye(4);
strctAnatVol.m_strctCrossSectionHoriz = strctCrossSectionHoriz;
strctAnatVol.m_strctCrossSectionSaggital = strctCrossSectionSaggital;
strctAnatVol.m_strctCrossSectionCoronal = strctCrossSectionCoronal;
strctAnatVol.m_strctContrastTransform = strctLinearHistogramStretch;


bFlipped = acos(dot(strctAnatVol.m_strctCrossSectionHoriz.m_a2fM(1:3,3),strctAnatVol.m_strctCrossSectionSaggital.m_a2fM(1:3,2)))/pi*180 > 90;
if (bFlipped) % Horizontal normal vector is incorrect!
    strctAnatVol.m_strctCrossSectionHoriz.m_a2fM(1:3,3) = -strctAnatVol.m_strctCrossSectionHoriz.m_a2fM(1:3,3);
end

% FIXED,6/17/2014
strctAnatVol.m_a2fRegToStereoTactic = 1/10*fnRotateVectorAboutAxis4D([1 0 0],pi)* inv(strctAnatVol.m_strctCrossSectionHoriz.m_a2fM);

% strctAnatVol.m_a2fRegToStereoTactic = fnRotateVectorAboutAxis4D([1 0 0],pi)* inv(strctAnatVol.m_strctCrossSectionHoriz.m_a2fM);

% strctAnatVol.m_astrctChambers = [];
% strctAnatVol.m_astrctTargets = [];
% strctAnatVol.m_astrctROIs= [];
strctAnatVol.m_acSavedVirtualArms = {};
strctMRI = rmfield(strctMRI,'vol');
strctAnatVol.m_strctFreeSurfer = strctMRI;
strctAnatVol.m_strctSurface  = [];
strctAnatVol.m_strctBloodSurface  = [];
strctAnatVol.m_acFreeSurferSurfaces = [];

return;

function [strctCrossSectionHoriz,strctCrossSectionSaggital,strctCrossSectionCoronal] =...
    fnSetDefaultCrossSectionsCorrect(aiVolSize, a2fM, a2fM_RAS,iResWidth,iResHeight)
% To be compatible with registration issues, planner also uses the
% tkregister convension of a2fM_TK for placing the volume in mm space
% However, this leads to the problem that the directions
% (anterios,right,superior) are not correct anymore.
% to aleviate this, we use the cross section trick, which takes this
% information from vox2raw0
%
% According to NIFTI's convension:
% +x = Right  +y = Anterior  +z = Superior.
%
%
% We need to define three default cross sections.
% Those are easy to define in the mm space according to the above
% definition.
%
%
% Determine the span of the volume in mm space first.

% Project [0,0,0] and aiVolSize and find min and max
% P0 = a2fM * [0;0;0;1];
% 
% Pc = a2fM * [aiVolSize(1);0;0;1];
% Pr = a2fM * [0;aiVolSize(2);0;1];
% Ps = a2fM * [0;0;aiVolSize(3);1];
% 
% POrigin = a2fM * [aiVolSize(1)/2;aiVolSize(2)/2;aiVolSize(3)/2;1];
% 
% fSpanRightMM = norm(Pc-P0);
% fSpanAnteriorMM = norm(Pr-P0);
% fSpanSuperiorMM = norm(Ps-P0);


P0 = a2fM_RAS*[0 0 0 1]'; % LPI corner in mm
PM = a2fM_RAS*[aiVolSize([2 1 3])-1 1]'; %% RAS corner in mm
PC = a2fM_RAS*[(aiVolSize([2 1 3])-1)/2 1]'; %% center in mm
afSpan = abs(PM-P0);
fSpanRightMM = afSpan(1);
fSpanAnteriorMM = afSpan(2);
fSpanSuperiorMM = afSpan(3);
POrigin = [0 0 0 1];
XYMask = [1 1 0];
XZMask = [1 0 1];
YZMask = [0 1 1];

fScaleMM = max([fSpanRightMM fSpanAnteriorMM fSpanSuperiorMM]./2);

a2fInvRAS = inv(a2fM_RAS); % orig pix=>mm, inv mm=>pix
afDirection_Right = a2fInvRAS(1:3,1) ./ norm(a2fInvRAS(1:3,1));
afDirection_Anterior = a2fInvRAS(1:3,2) ./ norm(a2fInvRAS(1:3,2));
afDirection_Superior = a2fInvRAS(1:3,3) ./ norm(a2fInvRAS(1:3,3));

strctCrossSectionHoriz.m_a2fM = eye(4);
strctCrossSectionHoriz.m_a2fM(1:3,4) = PC(1:3).*XYMask';
strctCrossSectionHoriz.m_a2fM(1:3,1:3) = [afDirection_Right,-afDirection_Anterior,afDirection_Superior];

strctCrossSectionHoriz.m_fHalfWidthMM = fScaleMM;%max(fSpanRightMM/2,fSpanAnteriorMM/2);
strctCrossSectionHoriz.m_fHalfHeightMM = fScaleMM;%max(fSpanRightMM/2,fSpanAnteriorMM/2);
strctCrossSectionHoriz.m_iResWidth = iResWidth;
strctCrossSectionHoriz.m_iResHeight = iResHeight;
strctCrossSectionHoriz.m_fViewOffsetMM = 0;
strctCrossSectionHoriz.m_bZFlip = false;
strctCrossSectionHoriz.m_bLRFlip = false;
strctCrossSectionHoriz.m_bUDFlip = false;


strctCrossSectionSaggital.m_a2fM = eye(4);
strctCrossSectionSaggital.m_a2fM(1:3,4) = PC(1:3).*YZMask';
strctCrossSectionSaggital.m_a2fM(1:3,1:3) = [afDirection_Anterior,-afDirection_Superior,-afDirection_Right];

strctCrossSectionSaggital.m_fHalfWidthMM =  fScaleMM;%max(fSpanAnteriorMM/2,fSpanSuperiorMM/2);
strctCrossSectionSaggital.m_fHalfHeightMM = fScaleMM;%max(fSpanAnteriorMM/2,fSpanSuperiorMM/2);
strctCrossSectionSaggital.m_iResWidth = iResWidth;
strctCrossSectionSaggital.m_iResHeight = iResHeight;
strctCrossSectionSaggital.m_fViewOffsetMM = 0;
strctCrossSectionSaggital.m_bZFlip = false;
strctCrossSectionSaggital.m_bLRFlip = false;
strctCrossSectionSaggital.m_bUDFlip = false;

strctCrossSectionCoronal.m_a2fM = eye(4);
strctCrossSectionCoronal.m_a2fM(1:3,4) = PC(1:3).*XZMask';
strctCrossSectionCoronal.m_a2fM(1:3,1:3) = [afDirection_Right,-afDirection_Superior,-afDirection_Anterior];

strctCrossSectionCoronal.m_fHalfWidthMM = fScaleMM;%max(fSpanRightMM/2,fSpanSuperiorMM/2);
strctCrossSectionCoronal.m_fHalfHeightMM = fScaleMM;%max(fSpanRightMM/2,fSpanSuperiorMM/2);
strctCrossSectionCoronal.m_iResWidth = iResWidth;
strctCrossSectionCoronal.m_iResHeight = iResHeight;
strctCrossSectionCoronal.m_fViewOffsetMM = 0;
strctCrossSectionCoronal.m_bZFlip = false;
strctCrossSectionCoronal.m_bLRFlip = false;
strctCrossSectionCoronal.m_bUDFlip = false;


return;