function fnUpdateAtlasContoursNew(a2fXYZ_To_CRS)
global g_strctModule g_strctApp
if g_strctModule.m_iCurrAnatVol == 0 || isempty(g_strctModule.m_acAnatVol)
    return;
end

a2fCrossSectionXY = fnResampleCrossSection(g_strctApp.m_strctAtlasNewContour.m_strctMRI.vol, ...
    a2fXYZ_To_CRS, g_strctModule.m_strctCrossSectionXY, 1);
a2fCrossSectionYZ = fnResampleCrossSection(g_strctApp.m_strctAtlasNewContour.m_strctMRI.vol, ...
    a2fXYZ_To_CRS, g_strctModule.m_strctCrossSectionYZ, 1);
a2fCrossSectionXZ = fnResampleCrossSection(g_strctApp.m_strctAtlasNewContour.m_strctMRI.vol, ...
    a2fXYZ_To_CRS, g_strctModule.m_strctCrossSectionXZ, 1);
g_strctModule.m_strctPanel.m_strctXY.m_hAtlas.CData = a2fCrossSectionXY;
g_strctModule.m_strctPanel.m_strctXY.m_hAtlas.AlphaData = ...
    a2fCrossSectionXY>0;
g_strctModule.m_strctPanel.m_strctYZ.m_hAtlas.CData = a2fCrossSectionYZ;
g_strctModule.m_strctPanel.m_strctYZ.m_hAtlas.AlphaData = ...
    a2fCrossSectionYZ>0;
g_strctModule.m_strctPanel.m_strctXZ.m_hAtlas.CData = a2fCrossSectionXZ;
g_strctModule.m_strctPanel.m_strctXZ.m_hAtlas.AlphaData = ...
    a2fCrossSectionXZ>0;



