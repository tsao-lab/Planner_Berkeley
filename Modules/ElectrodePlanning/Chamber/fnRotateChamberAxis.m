function fnRotateChamberAxis(hAxes,afDelta)
global g_strctModule
if isempty(g_strctModule.m_astrctChambers) || g_strctModule.m_iCurrChamber == 0 || isempty(hAxes)
    return;
end
fScale = fnGetAxesScaleFactor(g_strctModule.m_strctLastMouseDown.m_hAxes); %#ok
a2fM = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM;
[fMax,iDummy] = max(abs(afDelta)); %#ok


a2fT = eye(4);
a2fT(1:3,4) = -a2fM(1:3,4);



a2fR = fnRotateVectorAboutAxis(a2fM(1:3,3),afDelta(iDummy)/300*pi);
a2fRot = zeros(4,4);
a2fRot(1:3,1:3) = a2fR;
a2fRot(4,4) = 1;

a2fM = inv(a2fT) * a2fRot * a2fT * a2fM; %#ok

g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM = a2fM;%#ok
fnUpdateChamberMIP();
fnInvalidate();

return;