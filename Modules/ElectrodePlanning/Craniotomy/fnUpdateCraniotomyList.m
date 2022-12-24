function fnUpdateCraniotomyList()
global g_strctModule
if ~isfield(g_strctModule,'m_astrctCraniotomies')
    set(g_strctModule.m_strctPanel.m_hCraniotomyList,'String','');
else
    strName = '';
    iNumCraniotomies = length(g_strctModule.m_astrctCraniotomies);
    for k=1:iNumCraniotomies
        strName = [strName,'|',g_strctModule.m_astrctCraniotomies(k).m_strName]; %#ok
    end
    iValue = min(iNumCraniotomies,get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value'));
    if isempty(iValue)
        iValue = iNumCraniotomies;
    end
    if iNumCraniotomies == 0
        iValue = 1;
    end
    set(g_strctModule.m_strctPanel.m_hCraniotomyList,'String',strName(2:end), ...
        'value',iValue,'min',1,'max',max(1,iNumCraniotomies));
    g_strctModule.m_iCurrentCraniotomy = iValue;
end
