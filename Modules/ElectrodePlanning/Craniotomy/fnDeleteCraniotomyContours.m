function fnDeleteCraniotomyContours()
global g_strctModule
if isfield(g_strctModule.m_strctPanel,'m_ahCraniotomies')
    delete(g_strctModule.m_strctPanel.m_ahCraniotomies);
end
g_strctModule.m_strctPanel.m_ahCraniotomies = [];
