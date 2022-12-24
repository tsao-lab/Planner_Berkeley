function  fnSelectGrid()
global g_strctModule
persistent iLastSelectedGrid
if isempty(iLastSelectedGrid)
    iLastSelectedGrid = 0;
end
iSelectedGrid = get(g_strctModule.m_strctPanel.m_hGridList,'value');
% if isempty(g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids) || ...
%         iSelectedGrid~=iLastSelectedGrid
%     iLastSelectedGrid = iSelectedGrid;
%     return
% end
% if ~isempty(iSelectedGrid) && iSelectedGrid>0
g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_iGridSelected = iSelectedGrid;
fnUpdateGridAxes(false);
fnUpdateChamberMIP();

fnInvalidate();
% end



