function pt3fPosInStereoSpace=fnGetCoordInStereotacticSpace(pt3fPosIn3DSpace)
global g_strctModule


% 
% fSignDV = -2*double(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_bZFlip)+1;
% fSignAP = -2*double(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionCoronal.m_bZFlip)+1;
% fSignML = -2*double(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionSaggital.m_bZFlip)+1;

% fDV = fnPointCrossSectionDist(pt3fPosIn3DSpace, ...
%     g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM);
% fAP = fnPointCrossSectionDist(pt3fPosIn3DSpace, ...
%     g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionCoronal.m_a2fM);
% fML = fnPointCrossSectionDist(pt3fPosIn3DSpace, ...
%     g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionSaggital.m_a2fM);
% 
% pt3fPosInStereoSpace =[fAP fML fDV];

pt3fPosInStereoSpace = pt3fPosIn3DSpace([2 1 3]);
