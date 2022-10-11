function fnMoveChamberAxis(hAxes,afDelta)
global g_strctModule
if isempty(g_strctModule.m_astrctChambers) || g_strctModule.m_iCurrChamber == 0 || isempty(hAxes)
    return;
end
fScale = fnGetAxesScaleFactor(g_strctModule.m_strctLastMouseDown.m_hAxes);
a2fM = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM;
[fMax,iDummy] = max(abs(afDelta)); %#ok
a2fM(1:3,4) = a2fM(1:3,4) + (1/fScale)* -afDelta(iDummy) * a2fM(1:3,3);
g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM = a2fM;
fnInvalidate();


return;