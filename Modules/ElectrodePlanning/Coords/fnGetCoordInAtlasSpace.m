function pt3fPosInAtlasSpace = fnGetCoordInAtlasSpace(pt3fPosIn3DSpace)
global g_strctModule    
if isempty(g_strctModule.m_acAnatVol) ||  g_strctModule.m_iCurrAnatVol == 0 || ...
        ~isfield(g_strctModule, 'm_a2fAtlasReg')
    pt3fPosInAtlasSpace = [NaN,NaN,NaN];
    return;
end
Tmp = g_strctModule.m_a2fAtlasReg \ pt3fPosIn3DSpace;
pt3fPosInAtlasSpace = [Tmp(2), Tmp(1), Tmp(3)]; % AP, ML, DV