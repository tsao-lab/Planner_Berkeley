function fnUpdateAtlasTable()
global g_strctModule g_strctApp

a2cColor = round(255*g_strctApp.m_tableRegions.color);
a2cData = table(g_strctApp.m_tableRegions.name, g_strctApp.m_tableRegions.visible, ...
    cellfun(@(c) sprintf('<html><span style="background-color: #%02X%02X%02X;"> ______  </span></html>', ...
    c(1), c(2), c(3)), num2cell(a2cColor, 2), 'UniformOutput', false), ...
    'VariableNames', {'Region', 'Visible', 'Color'});
set(g_strctModule.m_strctPanel.m_hAtlasTable,'Data',table2cell(a2cData));

return;
