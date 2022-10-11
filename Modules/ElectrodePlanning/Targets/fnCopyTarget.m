function fnCopyTarget(a,b,iAnatVolTo) %#ok
global g_strctModule
aiCurrTarget = get(g_strctModule.m_strctPanel.m_hTargetList,'value');
astrctTarget = g_strctModule.m_astrctTargets(aiCurrTarget);
for k=1:length(aiCurrTarget)
    
    
    a2fM = astrctTarget(k).m_pt3fPosition;
    astrctTarget(k).m_pt3fPosition = a2fM;
    if ~isfield(g_strctModule.m_acAnatVol{iAnatVolTo},'m_astrctTargets') || isempty(g_strctModule.m_astrctTargets)
        g_strctModule.m_astrctTargets = astrctTarget(1);
    else
        g_strctModule.m_astrctTargets(end+1) = astrctTarget(k);
    end
end
fnUpdateTargetList();
return;

