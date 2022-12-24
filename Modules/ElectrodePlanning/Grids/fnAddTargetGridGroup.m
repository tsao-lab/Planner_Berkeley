function fnAddTargetGridGroup()
global g_strctModule 

if isempty(g_strctModule.m_astrctChambers) || ...
        isempty(g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids) || ...
        isempty(g_strctModule.m_astrctTargets) || ...
        isempty(g_strctModule.m_astrctCraniotomies)
    return
end
strctGrid = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids( ...
    g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_iGridSelected);
if ~strcmp(strctGrid.m_strType, 'Generic')
    return
end
strctTarget = g_strctModule.m_astrctTargets(g_strctModule.m_iCurrentTarget);
strctCraniotomy = g_strctModule.m_astrctCraniotomies(g_strctModule.m_iCurrentCraniotomy);
fnAddGridGroupUsingTwoPointsAux(strctCraniotomy.m_pt3fPosition, strctTarget.m_pt3fPosition);
