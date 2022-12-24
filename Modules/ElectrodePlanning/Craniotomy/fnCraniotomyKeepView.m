function fnCraniotomyKeepView()
global g_strctModule
if isempty(g_strctModule.m_acAnatVol) || isempty(g_strctModule.m_astrctCraniotomies)
    return;
end

aiCurrCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
if length(aiCurrCraniotomy) > 1
    msgbox('This option is available only for one Craniotomy');
    return;
end
iCurrCraniotomy = aiCurrCraniotomy(1);

g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionXY = ...
    g_strctModule.m_strctCrossSectionXY;

g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionXZ = ...
    g_strctModule.m_strctCrossSectionXZ;

g_strctModule.m_astrctCraniotomies(iCurrCraniotomy).m_strctCrossSectionYZ = ...
    g_strctModule.m_strctCrossSectionYZ;
