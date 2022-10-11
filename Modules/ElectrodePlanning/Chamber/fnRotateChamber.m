function fnRotateChamber(hAxes, afDelta)
global g_strctModule
if isempty(g_strctModule.m_astrctChambers) || g_strctModule.m_iCurrChamber == 0 || ...
        isempty(hAxes)
    return;
end
a2fM = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM;
strctCrossSection=fnAxesHandleToStrctCrossSection(hAxes);
if ~isempty(strctCrossSection)
        pt3fCurrPos = a2fM(1:3,4);
        a2fT = [1 0 0 -pt3fCurrPos(1); 
                0 1 0 -pt3fCurrPos(2);
                0 0 1 -pt3fCurrPos(3);
                0 0 0 1];
        a2fR = fnRotateVectorAboutAxis(strctCrossSection.m_a2fM(1:3,3),afDelta(1)/500*pi);
        a2fRot = zeros(4,4);
        a2fRot(1:3,1:3) = a2fR;
        a2fRot(4,4) = 1;
        
        g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM = ...
        a2fT \ a2fRot * a2fT * a2fM;
end
fnUpdateChamberMIP();
fnInvalidate();

return;

  

