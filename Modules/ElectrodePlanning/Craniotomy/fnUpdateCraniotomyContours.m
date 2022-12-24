function fnUpdateCraniotomyContours()
global g_strctModule
if g_strctModule.m_iCurrAnatVol == 0 || ~isfield(g_strctModule, 'm_astrctCraniotomies')
    return;
end
if isfield(g_strctModule.m_strctPanel,'m_ahCraniotomies')
    delete(g_strctModule.m_strctPanel.m_ahCraniotomies);
    g_strctModule.m_strctPanel.m_ahCraniotomies = [];
end
iNumCraniotomies = length(g_strctModule.m_astrctCraniotomies);
ahHandles = [];
ahAxes = [g_strctModule.m_strctPanel.m_strctXY.m_hAxes,...
    g_strctModule.m_strctPanel.m_strctYZ.m_hAxes,...
    g_strctModule.m_strctPanel.m_strctXZ.m_hAxes];
astrctCrossSection = [g_strctModule.m_strctCrossSectionXY,...
    g_strctModule.m_strctCrossSectionYZ,...
    g_strctModule.m_strctCrossSectionXZ];

iSelectedCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
aiCurrCraniotomy = get(g_strctModule.m_strctPanel.m_hCraniotomyList,'value');
    
for iCraniotomyIter=1:iNumCraniotomies
    strctCraniotomy = g_strctModule.m_astrctCraniotomies(iCraniotomyIter);
    if iSelectedCraniotomy == iCraniotomyIter
        astrctMesh = fnBuildTargetMesh(strctCraniotomy, 1);
    else
        astrctMesh = fnBuildTargetMesh(strctCraniotomy, 0);
    end
    
    for iAxesIter=1:3
        for iMeshIter=1:length(astrctMesh)
            a2fLinesPix = fnMeshCrossSectionIntersection(astrctMesh(iMeshIter), ...
                astrctCrossSection(iAxesIter) );
            if ~isempty(a2fLinesPix)
                ahHandles(end+1) = fnPlotLinesAsSinglePatch(ahAxes(iAxesIter), ...
                    a2fLinesPix, astrctMesh(iMeshIter).m_afColor); %#ok
            end
        end
        
    end
    pt3fCraniotomy3D = [strctCraniotomy.m_pt3fPosition;1];
    
    % Draw Craniotomy in 3D
    if sum(iCraniotomyIter == aiCurrCraniotomy) > 0
        iSize = 41;
    else
        iSize = 31;
    end
    
    hCraniotomyin3D = plot3(pt3fCraniotomy3D(1), pt3fCraniotomy3D(2), pt3fCraniotomy3D(3), ...
        'm.', 'MarkerSize', iSize, 'parent', g_strctModule.m_strctPanel.m_strct3D.m_hAxes);
    ahHandles = [ahHandles,hCraniotomyin3D]; %#ok
end

g_strctModule.m_strctPanel.m_ahCraniotomies = ahHandles;
return;