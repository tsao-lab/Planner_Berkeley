function fnSelectTarget()
global g_strctModule
if isempty(g_strctModule.m_iCurrentTarget)
    g_strctModule.m_iCurrentTarget = 0;
end
iSelectedTarget = get(g_strctModule.m_strctPanel.m_hTargetList,'value');
if length(iSelectedTarget)>1 || isempty(g_strctModule.m_astrctTargets) || ...
        iSelectedTarget~=g_strctModule.m_iCurrentTarget
    g_strctModule.m_iCurrentTarget = iSelectedTarget;
    return
end
if ~isempty(iSelectedTarget) && iSelectedTarget>0
    g_strctModule.m_strctCrossSectionXY = ...
        g_strctModule.m_astrctTargets(iSelectedTarget).m_strctCrossSectionXY;
    g_strctModule.m_strctCrossSectionYZ = ...
        g_strctModule.m_astrctTargets(iSelectedTarget).m_strctCrossSectionYZ;
    g_strctModule.m_strctCrossSectionXZ = ...
        g_strctModule.m_astrctTargets(iSelectedTarget).m_strctCrossSectionXZ;
    pt3fPosMM = g_strctModule.m_astrctTargets(iSelectedTarget).m_pt3fPosition;
    g_strctModule.m_strctCrossSectionXY.m_a2fM(1:3,4) = pt3fPosMM;
    g_strctModule.m_strctCrossSectionYZ.m_a2fM(1:3,4) = pt3fPosMM;
    g_strctModule.m_strctCrossSectionXZ.m_a2fM(1:3,4) = pt3fPosMM;
    fnUpdateTargetContours();
    fnInvalidate();
end


    
