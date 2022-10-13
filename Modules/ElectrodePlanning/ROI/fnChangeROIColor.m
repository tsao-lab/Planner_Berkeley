function fnChangeROIColor()
global g_strctModule

if isempty(g_strctModule.m_iCurrAnatVol)
    return
end

iSelectedROI = get(g_strctModule.m_strctPanel.m_hROIList,'value');
if length(iSelectedROI) > 1
    msgbox('This option is available for only one ROI');
    return;
end

if iSelectedROI > 0
    RGB = uisetcolor();
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_astrctROIs(iSelectedROI).m_strColor = RGB;
    fnUpdateROIList();
    fnInvalidate(1);
end




