function fnStereotaxHelper()    
global g_strctModule
Tmp = EarBarZeroRegGUI(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol});
if ~isempty(Tmp)
    
    
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol} = Tmp{1};
    
    bFlipped = acos(dot(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM(1:3,3),g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionSaggital.m_a2fM(1:3,2)))/pi*180 > 90;
    if (bFlipped) % Horizontal normal vector is incorrect!
        g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM(1:3,3) = -g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM(1:3,3);
    end
    
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fRegToStereoTactic = ...
    fnRotateVectorAboutAxis4D([1 0 0],pi)* inv(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM);
g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fRegToStereoTactic(1:3,1:3)=0.1 * g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fRegToStereoTactic(1:3,1:3);
    delete(Tmp{2});
end
fnInvalidate(1);
return;