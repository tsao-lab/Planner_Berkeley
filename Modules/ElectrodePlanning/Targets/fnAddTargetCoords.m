function fnAddTargetCoords()
global g_strctModule

acCoord = inputdlg({'AP:', 'ML:', 'DV:'}, 'Add Target');
afCoord = cellfun(@str2double, acCoord);

fnAddTargetAux2(afCoord([2 1 3]), afCoord);
set(g_strctModule.m_strctPanel.m_hTargetList, 'value', length(g_strctModule.m_astrctTargets));
fnUpdateTargetList();
fnInvalidate(true);


