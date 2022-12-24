function fnRemoveCraniotomy()
global g_strctModule
if g_strctModule.m_iCurrAnatVol == 0 || isempty(g_strctModule.m_astrctCraniotomies) 
    return;
end
strAnswer = questdlg({'Are you sure you want to remove Craniotomy(s)?'},'Warning','Yes','No','No');
if strcmpi(strAnswer,'yes')
    aiCurrCraniotomies = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
    g_strctModule.m_astrctCraniotomies(aiCurrCraniotomies) = [];
    iNumRemainingCraniotomies = length(g_strctModule.m_astrctCraniotomies);
    set(g_strctModule.m_strctPanel.m_hCraniotomyList,'value',iNumRemainingCraniotomies);
    fnUpdateCraniotomyList();
    fnInvalidate(true);
end

