function fnSetNewPanLevel(hAxes, afDelta)
global g_strctModule
if ~isempty(hAxes)
    switch hAxes
        case g_strctModule.m_strctPanel.m_strctXY.m_hAxes
            afDelatXY = [afDelta(1) afDelta(2)];
            afDelatXZ = [afDelta(1) 0];
            afDelatYZ = [-afDelta(2) 0];
        case g_strctModule.m_strctPanel.m_strctYZ.m_hAxes
            afDelatXY = [0 -afDelta(1)];
            afDelatXZ = [0 afDelta(2)];
            afDelatYZ = [afDelta(1) afDelta(2)];
        case g_strctModule.m_strctPanel.m_strctXZ.m_hAxes
            afDelatXY = [afDelta(1) 0];
            afDelatXZ = [afDelta(1) afDelta(2)];
            afDelatYZ = [0 afDelta(2)];
    end
    g_strctModule.m_strctCrossSectionXY.m_a2fM = ...
        fnPanSection(g_strctModule.m_strctCrossSectionXY.m_a2fM, ...
        afDelatXY);
    g_strctModule.m_strctCrossSectionXZ.m_a2fM = ...
        fnPanSection(g_strctModule.m_strctCrossSectionXZ.m_a2fM, ...
        afDelatXZ);
    g_strctModule.m_strctCrossSectionYZ.m_a2fM = ...
        fnPanSection(g_strctModule.m_strctCrossSectionYZ.m_a2fM, ...
        afDelatYZ);
    fnInvalidate();
end
return

end

function a2fM = fnPanSection(a2fM, afDelta)
a2fM(1:3, 4) = a2fM(1:3, 4)-afDelta(1)*a2fM(1:3, 1)-afDelta(2)*a2fM(1:3, 2);
end