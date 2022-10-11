
function fnCopyChamber(a,b,iAnatVolTo) %#ok
global g_strctModule
if g_strctModule.m_iCurrChamber == 0
    return;
end
strctChamber = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber);
% we can't just copy the chamber because it is represented in voxel
% coordinates relative to the first volume.
a2fCRS_To_XYZ = g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fReg*g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fM;
a2fM = strctChamber.m_a2fM;
strctChamber.m_a2fM = a2fM;
if isempty(g_strctModule.m_astrctChambers)
    g_strctModule.m_astrctChambers = strctChamber;
else
    g_strctModule.m_astrctChambers(end+1) = strctChamber;
end
if iAnatVolTo == g_strctModule.m_iCurrAnatVol
    fnUpdateChamberList();
end
return;

