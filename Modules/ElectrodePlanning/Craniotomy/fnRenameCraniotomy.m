function fnRenameCraniotomy()
global g_strctModule
if isempty(g_strctModule.m_iCurrAnatVol)
    return;
end
iSelectedCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
if length(iSelectedCraniotomy) > 1
    msgbox('This option is available for only one Craniotomy');
    return;
end

if iSelectedCraniotomy > 0
    
    answer=inputdlg({'New Craniotomy Name'},'Change Craniotomy Name',1, ...
        {g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_strName});
    
    if isempty(answer)
        return;
    end
    g_strctModule.m_astrctCraniotomies(iSelectedCraniotomy).m_strName = answer{1};
    fnUpdateCraniotomyList()
end




