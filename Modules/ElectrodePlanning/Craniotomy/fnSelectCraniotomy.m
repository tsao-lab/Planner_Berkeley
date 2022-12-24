function fnSelectCraniotomy()
global g_strctModule
if isempty(g_strctModule.m_iCurrentCraniotomy)
    g_strctModule.m_iCurrentCraniotomy = 0;
end
iSelectedCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
if length(iSelectedCraniotomy)>1 || isempty(g_strctModule.m_astrctCraniotomies) || ...
        iSelectedCraniotomy~=g_strctModule.m_iCurrentCraniotomy
    g_strctModule.m_iCurrentCraniotomy = iSelectedCraniotomy;
    return
end
if ~isempty(iSelectedCraniotomy) && iSelectedCraniotomy > 0 && ...
        isfield(g_strctModule,'m_astrctCraniotomies')
    g_strctModule.m_strctCrossSectionXY = ...
        g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_strctCrossSectionXY;
    g_strctModule.m_strctCrossSectionYZ = ...
        g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_strctCrossSectionYZ;
    g_strctModule.m_strctCrossSectionXZ = ...
        g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_strctCrossSectionXZ;
    pt3fPosMM = g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_pt3fPosition;
    g_strctModule.m_strctCrossSectionXY.m_a2fM(1:3,4) = pt3fPosMM;
    g_strctModule.m_strctCrossSectionYZ.m_a2fM(1:3,4) = pt3fPosMM;
    g_strctModule.m_strctCrossSectionXZ.m_a2fM(1:3,4) = pt3fPosMM;
    fnUpdateCraniotomyContours();
    fnInvalidate();
end

end

    
