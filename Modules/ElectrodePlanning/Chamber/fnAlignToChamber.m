function fnAlignToChamber()
global g_strctModule
if g_strctModule.m_iCurrChamber == 0
    return;
end
a2fChamberT = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM;
afChamberX = a2fChamberT(1:3, 1);
afChamberY = a2fChamberT(1:3, 2);
afChamberZ = a2fChamberT(1:3, 3);
afChamberC = a2fChamberT(1:3, 4);
afChamberC2 = afChamberC-afChamberZ*30;

%%
g_strctModule.m_strctCrossSectionXY.m_a2fM(1:3, :) = [afChamberX -afChamberY -afChamberZ afChamberC];
g_strctModule.m_strctCrossSectionYZ.m_a2fM(1:3, :) = [afChamberY -afChamberZ -afChamberX afChamberC2];
g_strctModule.m_strctCrossSectionXZ.m_a2fM(1:3, :) = [afChamberX -afChamberZ afChamberY afChamberC2];
fnInvalidate(1);


