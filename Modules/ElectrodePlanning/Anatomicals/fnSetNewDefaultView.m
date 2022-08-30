function fnSetNewDefaultView()
global g_strctModule    
% g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz = g_strctModule.m_strctCrossSectionXY;
% g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionCoronal = g_strctModule.m_strctCrossSectionXZ;
% g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionSaggital = g_strctModule.m_strctCrossSectionYZ;

acCrossSections = {'m_strctCrossSectionXY', 'm_strctCrossSectionXZ', 'm_strctCrossSectionYZ'};
for k = 1:3
    g_strctModule.m_strctDefaultCrossSections.(acCrossSections{k}) = ...
        g_strctModule.(acCrossSections{k});
end

    


