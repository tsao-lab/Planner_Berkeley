function fnLoadAnatVol(strFileName)
global g_strctModule

if ~exist('strFileName', 'var') || isempty(strFileName)
    [strFile, strPath] = uigetfile([g_strctModule.m_strDefaultFilesFolder,'*.mgz;*.img;*.nii'], ...
        'MultiSelect','off');
    if strFile(1) == 0
        return;
    end
    strFileName = fullfile(strPath, strFile);
end
strctVol=fnQuickAddVolume(strFileName);

% Add the new volume to planner
iNumVolumes = length(g_strctModule.m_acAnatVol);
g_strctModule.m_acAnatVol{iNumVolumes+1} = strctVol;
g_strctModule.m_iCurrAnatVol = length(g_strctModule.m_acAnatVol);
g_strctModule.m_bVolumeLoaded = true;
fnDeleteFreesurferSurface();
fnSetDefaultCrossSections();
fnUpdateAnatomicalsList();    
fnUpdateSurfacePatch();

fnUpdateChamberList();
fnUpdateGridList();
set(g_strctModule.m_strctPanel.m_hAnatList,'value',iNumVolumes+1);
fnSetCurrAnatVol();
fnInvalidate();
return;
