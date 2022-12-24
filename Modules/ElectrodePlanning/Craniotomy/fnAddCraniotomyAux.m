function fnAddCraniotomyAux(strctMouseOp)
global g_strctModule

strctCrossSection = fnAxesHandleToStrctCrossSection(strctMouseOp.m_hAxes);
if isempty(strctCrossSection)
    return;
end

% Transform the clicked point to 3D coordinates
pt2fPosMM = fnCrossSection_Image_To_MM(strctCrossSection, strctMouseOp.m_pt2fPos);
pt3fPosMMOnPlane = [pt2fPosMM,0,1]';
pt3fPosInVol = strctCrossSection.m_a2fM*pt3fPosMMOnPlane;
pt3fPosInStereoSpace = fnGetCoordInStereotacticSpace(pt3fPosInVol(1:3));

strctCraniotomy.m_pt3fPosition = pt3fPosInVol(1:3);
strctCraniotomy.m_strName = sprintf('Unknown (AP %.2f ML %.2f DV %.2f)', ...
    pt3fPosInStereoSpace(1),pt3fPosInStereoSpace(2),pt3fPosInStereoSpace(3));
strctCraniotomy.m_strctCrossSectionXY = g_strctModule.m_strctCrossSectionXY;
strctCraniotomy.m_strctCrossSectionYZ = g_strctModule.m_strctCrossSectionYZ;
strctCraniotomy.m_strctCrossSectionXZ = g_strctModule.m_strctCrossSectionXZ;

if ~isfield(g_strctModule, 'm_astrctCraniotomies') || ...
        isempty(g_strctModule.m_astrctCraniotomies)
    g_strctModule.m_astrctCraniotomies = strctCraniotomy;
else
    iNumCraniotomies = length(g_strctModule.m_astrctCraniotomies);    
    g_strctModule.m_astrctCraniotomies(iNumCraniotomies+1) = strctCraniotomy;
end

set(g_strctModule.m_strctPanel.m_hCraniotomyList, 'value', length(g_strctModule.m_astrctCraniotomies));
fnUpdateCraniotomyList();
fnInvalidate(true);


