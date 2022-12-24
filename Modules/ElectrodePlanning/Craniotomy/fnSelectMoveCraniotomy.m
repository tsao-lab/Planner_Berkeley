function fnSelectMoveCraniotomy()
global g_strctModule
aiCurrTarget = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
if length(aiCurrTarget) > 1
    msgbox('This option is available only for one craniotomy');
    return;
end
            
fnChangeMouseMode('MoveCraniotomy');