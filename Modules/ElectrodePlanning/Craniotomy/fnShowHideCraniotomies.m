function fnShowHideCraniotomies()
global g_strctModule
g_strctModule.m_strctGUIOptions.m_bShowCraniotomies = ~g_strctModule.m_strctGUIOptions.m_bShowCraniotomies;
fnInvalidate();