function fnLocalizeRegion()
% Which region is selected?
global g_strctModule g_strctApp

% jUIScrollPane = findjobj(g_strctModule.m_strctPanel.m_hAtlasTable);
% jUITable = jUIScrollPane(2).getViewport.getView;
% iRegion = jUITable.getSelectedRow + 1; % Java indexes start at 0
% if iRegion == 0
%     return;
% end
% 
% idc = find(g_strctApp.m_strctAtlasNew.m_strctMRI.vol==g_strctApp.m_tableRegions.label(iRegion));
% pt3fCenterAtlasCoord = mean(g_strctModule.m_strctAtlas.m_astrctMesh(iRegion).vertices,1);
% if isempty(g_strctModule.m_acAnatVol)
%     return;
% end
% fnAlignViewWithAtlas(pt3fCenterAtlasCoord);
% fnInvalidate(1);
return;
