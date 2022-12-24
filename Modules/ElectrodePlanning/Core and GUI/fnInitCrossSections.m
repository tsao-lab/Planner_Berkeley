function fnInitCrossSections()
fnInitCrossSection('m_strctCrossSectionXY');
fnInitCrossSection('m_strctCrossSectionXZ');
fnInitCrossSection('m_strctCrossSectionYZ');
end

function fnInitCrossSection(strCrossSection)
global g_strctModule
switch strCrossSection
    case 'm_strctCrossSectionXY'
        a2fM = ...
            [ 1.000  0.000  0.000  0.000;
              0.000 -1.000  0.000 11.125;
              0.000  0.000 -1.000  0.000;
              0.000  0.000  0.000  1.000];
    case 'm_strctCrossSectionXZ'
        a2fM = ...
            [ 1.000  0.000  0.000  0.000;
              0.000  0.000  1.000  0.000;
              0.000 -1.000  0.000 16.875;
              0.000  0.000  0.000  1.000];
    case 'm_strctCrossSectionYZ'
        a2fM = ...
            [ 0.000  0.000 -1.000  0.000;
              1.000  0.000  0.000 11.125;
              0.000 -1.000  0.000 16.875;
              0.000  0.000  0.000  1.000];
end
g_strctModule.(strCrossSection).m_a2fM = a2fM;
g_strctModule.(strCrossSection).m_fHalfWidthMM = 42;
g_strctModule.(strCrossSection).m_fHalfHeightMM = 42;
g_strctModule.(strCrossSection).m_iResWidth = 256;
g_strctModule.(strCrossSection).m_iResHeight = 256;
g_strctModule.(strCrossSection).m_fViewOffsetMM = 0;
g_strctModule.(strCrossSection).m_bZFlip = false;
g_strctModule.(strCrossSection).m_bLRFlip = false;
g_strctModule.(strCrossSection).m_bUDFlip = false;
g_strctModule.m_strctDefaultCrossSections.(strCrossSection) = ...
    g_strctModule.(strCrossSection);
end
