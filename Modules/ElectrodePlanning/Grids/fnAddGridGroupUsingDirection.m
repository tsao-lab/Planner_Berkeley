function fnAddGridGroupUsingDirection()
global g_strctModule
fnChangeMouseMode('AddTwoClickObject', 'Add Grid Group Using Direction');
g_strctModule.m_hClickCallback = @fnAddGridGroupUsingTwoPoints;
return;