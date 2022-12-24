function fnMoveCraniotomy(hAxes, afDelta)
global g_strctModule
if isempty(g_strctModule.m_astrctCraniotomies) || isempty(hAxes)
    return;
end
iCurrCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionXY = ...
    g_strctModule.m_strctCrossSectionXY;

g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionYZ = ...
    g_strctModule.m_strctCrossSectionYZ;

g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionXZ = ...
    g_strctModule.m_strctCrossSectionXZ;

fScale = 2*fnGetAxesScaleFactor(g_strctModule.m_strctLastMouseDown.m_hAxes);
switch hAxes
    case g_strctModule.m_strctPanel.m_strctXY.m_hAxes
        afDirX = g_strctModule.m_strctCrossSectionXY.m_a2fM(1:3,1);
        afDirY = g_strctModule.m_strctCrossSectionXY.m_a2fM(1:3,2);
    case g_strctModule.m_strctPanel.m_strctYZ.m_hAxes
        afDirX = g_strctModule.m_strctCrossSectionYZ.m_a2fM(1:3,1);
        afDirY = g_strctModule.m_strctCrossSectionYZ.m_a2fM(1:3,2);
    case g_strctModule.m_strctPanel.m_strctXZ.m_hAxes    
        afDirX = g_strctModule.m_strctCrossSectionXZ.m_a2fM(1:3,1);
        afDirY = g_strctModule.m_strctCrossSectionXZ.m_a2fM(1:3,2);
end
pt3fOldPositionMM = g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_pt3fPosition;
pt3fNewPositionMM = pt3fOldPositionMM(1:3) +(1/fScale)*afDelta(1) * afDirX + (1/fScale)*afDelta(2) * afDirY;
g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_pt3fPosition = pt3fNewPositionMM;
fnInvalidate();
