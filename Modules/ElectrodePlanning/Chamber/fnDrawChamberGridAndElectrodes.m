function ahHandles = fnDrawChamberGridAndElectrodes(strctChamber, bSelected)
global g_strctModule
% Draw chamber, both in 2D and 3D
% if chamber has a grid, draw it as well. 
% if there are electrodes in the grid, draw them as well

a2fM = strctChamber.m_a2fM;

% start by drawing the actual chamber
% 1. Build chamber model
astrctMesh = fnChamber_BuildModel(strctChamber, bSelected);
% 2. Draw it in cross sections
% for k=1:length(astrctMesh)
%     astrctMesh(k).m_afColor = [1 1 1];
% end
ahHandles = fnDrawMesh(astrctMesh);

% 3. Draw it in 3D view
% astrctMeshTrans = fnApplyTransformOnMesh(astrctMesh, ...
%     inv(g_strctModule.m_acAnatVol{g_strctModule.m_iCurrAnatVol}.m_strctCrossSectionHoriz.m_a2fM));
% astrctMeshTrans = fnApplyTransformOnMesh(astrctMesh, ...
%     inv(g_strctModule.m_strctCrossSectionXY.m_a2fM));

ahHandles = [ahHandles,fnDrawMeshIn3D(astrctMesh,g_strctModule.m_strctPanel.m_strct3D.m_hAxes)];


% 4. Draw electrodes
if strctChamber.m_iGridSelected > 0
    strctGrid = strctChamber.m_astrctGrids(strctChamber.m_iGridSelected);
    if isfield(strctGrid.m_strctModel, 'm_astrctGridMesh')
        astrctGridMesh = strctGrid.m_strctModel.m_astrctGridMesh;
    else
%         disp('Draw new mesh')
        astrctGridMesh = feval(strctGrid.m_strctGeneral.m_strBuildMesh, ...
            strctGrid.m_strctModel, g_strctModule.m_strctGUIOptions.m_bLongGrid, bSelected);
    end
    
    if bSelected
        fOpacity = 0.6;
    else
        fOpacity = 0.2;
    end
    for k = 1:length(astrctGridMesh)
        astrctGridMesh(k).m_fOpacity = fOpacity;
    end

    a2fGridOffsetTransform = eye(4);
    a2fGridOffsetTransform(3,4) = -strctGrid.m_fChamberDepthOffset;
    a2fM_WithMeshOffset = a2fM*a2fGridOffsetTransform;
    astrctGridMesh = fnApplyTransformOnMesh(astrctGridMesh, a2fM_WithMeshOffset);
   
    ahHandles = [ahHandles,fnDrawMesh(astrctGridMesh)];
    ahHandles = [ahHandles,fnDrawMeshIn3D(astrctGridMesh, ...
        g_strctModule.m_strctPanel.m_strct3D.m_hAxes)];
end
