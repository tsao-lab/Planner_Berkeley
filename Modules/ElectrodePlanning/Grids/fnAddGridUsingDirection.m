function fnAddGridUsingDirection()
global g_strctModule
fnChangeMouseMode('AddTwoClickObject', 'Add Grid Using Direction');
g_strctModule.m_hClickCallback = @fnAddGridUsingTwoPoints;
return;