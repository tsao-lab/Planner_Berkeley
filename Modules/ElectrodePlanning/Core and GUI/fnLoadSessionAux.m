function bSuccessful = fnLoadSessionAux(strFullFileName)
global g_strctModule
strctSavedSession= load(strFullFileName);
bSuccessful = true;

if ~isfield(strctSavedSession,'g_strctModule')
    bSuccessful = false;
    return
end


g_strctModule.m_acAnatVol = strctSavedSession.g_strctModule.m_acAnatVol;
g_strctModule.m_acFuncVol = strctSavedSession.g_strctModule.m_acFuncVol;
g_strctModule.m_bVolumeLoaded = strctSavedSession.g_strctModule.m_bVolumeLoaded;
g_strctModule.m_iCurrAnatVol = strctSavedSession.g_strctModule.m_iCurrAnatVol;
g_strctModule.m_iCurrFuncVol = strctSavedSession.g_strctModule.m_iCurrFuncVol;
g_strctModule.m_iCurrChamber = strctSavedSession.g_strctModule.m_iCurrChamber;
g_strctModule.m_bFuncVolLoaded = strctSavedSession.g_strctModule.m_bFuncVolLoaded;
g_strctModule.m_fCurrentDepth = strctSavedSession.g_strctModule.m_fCurrentDepth;
g_strctModule.m_astrctChambers = strctSavedSession.g_strctModule.m_astrctChambers;
g_strctModule.m_astrctTargets = strctSavedSession.g_strctModule.m_astrctTargets;
g_strctModule.m_astrctCraniotomies = strctSavedSession.g_strctModule.m_astrctCraniotomies;
g_strctModule.m_astrctMarkers = strctSavedSession.g_strctModule.m_astrctMarkers;
g_strctModule.m_astrctROIs = strctSavedSession.g_strctModule.m_astrctROIs;
g_strctModule.m_iCurrentTarget = strctSavedSession.g_strctModule.m_iCurrentTarget;
g_strctModule.m_iCurrentCraniotomy = strctSavedSession.g_strctModule.m_iCurrentCraniotomy;
g_strctModule.m_iCurrentMarker = strctSavedSession.g_strctModule.m_iCurrentMarker;
g_strctModule.m_iCurrentROI = strctSavedSession.g_strctModule.m_iCurrentROI;

acFieldNames = fieldnames(g_strctModule.m_strctGUIOptions);
for k=1:length(acFieldNames)
    if isfield(strctSavedSession.g_strctModule.m_strctGUIOptions,acFieldNames{k})
        setfield(g_strctModule.m_strctGUIOptions,acFieldNames{k},...
            getfield(g_strctModule.m_strctGUIOptions,acFieldNames{k})); %#ok
    end
end

g_strctModule.m_strctOverlay = strctSavedSession.g_strctModule.m_strctOverlay;
g_strctModule.m_strctCrossSectionXY = strctSavedSession.g_strctModule.m_strctCrossSectionXY;
g_strctModule.m_strctCrossSectionYZ = strctSavedSession.g_strctModule.m_strctCrossSectionYZ;
g_strctModule.m_strctCrossSectionXZ = strctSavedSession.g_strctModule.m_strctCrossSectionXZ;

if isfield(strctSavedSession.g_strctModule,'m_astrctImageSeries')
    g_strctModule.m_astrctImageSeries = strctSavedSession.g_strctModule.m_astrctImageSeries;
end

% Delete existing surfaces
fnDeleteFreesurferSurface()
fnGenerateFreesurferSurface();
% Delete existing chamber conoutrs

fnUpdateAnatomicalsList();
fnUpdateFunctionalsList();
fnUpdateChamberList();
fnUpdateGridList();
fnUpdateTargetList();
fnUpdateCraniotomyList();
%fnUpdateBloodVesselList();
fnUpdateROIList();
fnUpdateMarkerList();
fnUpdateGridAxes();
fnUpdateChamberMIP();
fnUpdateOverlayTransform();
fnInvalidateOverlayAxes();
fnUpdateSurfacePatch();
 fnInvalidateSurfaceList();
 if (g_strctModule.m_bInChamberMode)
     fnInvalidateStereotactic();
 end
fnInvalidateImageSeriesList();

fnInvalidate(true);

if ~g_strctModule.m_strctGUIOptions.m_bShow3DPlanes 
    set(g_strctModule.m_strctPanel.m_hPlaneXY,'visible','off');
    set(g_strctModule.m_strctPanel.m_hPlaneYZ,'visible','off');
    set(g_strctModule.m_strctPanel.m_hPlaneXZ,'visible','off');
end
