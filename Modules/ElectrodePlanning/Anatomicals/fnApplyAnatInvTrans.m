function fnApplyAnatInvTrans(a, b, iAnatVolRef) %#ok
global g_strctModule
if g_strctModule.m_iCurrAnatVol == 0
    return;
end
[strFile, strPath] = uigetfile({'*.reg;*.tkreg'}, 'Select transformation file', ...
    g_strctModule.m_strDefaultFilesFolder);
if strFile(1) == 0
    return;
end
a2fTrans = fnReadRegisteration([strPath, strFile]);
if iAnatVolRef==0
    a2fMTkRef =  [...
       -1.0000         0         0    0.1250;
             0         0   -1.0000   13.6250;
             0    1.0000         0   16.8750;
             0         0         0    1.0000;
    ];
else
    a2fMTkRef = g_strctModule.m_acAnatVol{iAnatVolRef}.m_a2fReg * ...
    g_strctModule.m_acAnatVol{iAnatVolRef}.m_a2fM / ...
    g_strctModule.m_acAnatVol{iAnatVolRef}.m_a2fT;
end
g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fReg = ...
    a2fMTkRef * ...
    a2fTrans * ...
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fTk / ...
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fM * ...
    g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_a2fReg;

fnUpdateSurfacePatch();
fnSetCurrAnatVol();
fnSetDefaultCrossSections();

fnInvalidate(1);
