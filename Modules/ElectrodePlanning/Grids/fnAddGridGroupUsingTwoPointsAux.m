function fnAddGridGroupUsingTwoPointsAux(afStartPoint, afEndPoint)
global g_strctModule 

if isempty(g_strctModule.m_astrctChambers) || ...
        isempty(g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids)
    return
end
strctGrid = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids( ...
    g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_iGridSelected);
if ~strcmp(strctGrid.m_strType, 'Generic')
    return
end

pt4fStartPoint = [afStartPoint; 1];
pt4fEndPoint = [afEndPoint; 1];
a2fChamber = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_a2fM;

pt4fStart = a2fChamber\pt4fStartPoint;
pt4fEnd = a2fChamber\pt4fEndPoint;
afDesiredDirection = pt4fEnd(1:3)-pt4fStart(1:3);
afDesiredDirection = afDesiredDirection./norm(afDesiredDirection);
fK = -pt4fStart(3)/afDesiredDirection(3);
afDesiredPoint = pt4fStart(1:3)+fK*afDesiredDirection;

if afDesiredDirection(3)>0
    afDesiredDirection = -afDesiredDirection;
end
fDesiredRotationDeg = atan2(afDesiredDirection(1), afDesiredDirection(2))/pi*180;
fDesiredTiltDeg = acos(abs(afDesiredDirection(3)))/pi*180;

g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_astrctGrids( ...
    g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_iGridSelected).m_strctModel = ...
    fnAddGenericGridGroup(strctGrid.m_strctModel, afDesiredPoint(1), afDesiredPoint(2), ...
    fDesiredRotationDeg, fDesiredTiltDeg);
fnUpdateGridAxes(false);
fnInvalidate(1);
