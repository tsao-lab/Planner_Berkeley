function fnFlipChamberAxis()
global g_strctModule
iSelectedChamber = get(g_strctModule.m_strctPanel.m_hChamberList,'value');
if isempty(g_strctModule.m_astrctChambers)
    return;
end
g_strctModule.m_astrctChambers(iSelectedChamber).m_a2fM(1:3,3)=-g_strctModule.m_astrctChambers(iSelectedChamber).m_a2fM(1:3,3);
fnInvalidate(1);
return;
