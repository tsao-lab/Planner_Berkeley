function fnAddSurface()
global g_strctModule
if g_strctModule.m_iCurrAnatVol == 0
    return;
end
X = SurfaceHelper(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol});
if ~isempty(X)
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol} = X;
    fnUpdateSurfacePatch();
    fnInvalidate();
end
return;
