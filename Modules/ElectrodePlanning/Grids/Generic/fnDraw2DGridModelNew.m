function ahHolesHandles = fnDraw2DGridModelNew(strctGridModel, hAxes, strctDisplayParam)
global g_strctModule

cla(hAxes);
hold(hAxes,'on');

afAngle = linspace(0,2*pi,20);
afCos = cos(afAngle);
afSin= sin(afAngle);

iNumHoles = length(strctGridModel.m_afGridHolesX);

fHoleDiameterMM = strctGridModel.m_strctGridParams.m_fGridHoleDiameterMM;

if ~isfield(strctDisplayParam,'m_bDisplayHoleDirection')
    strctDisplayParam.m_bDisplayHoleDirection = false;
end

bShowBottomHoles = false;
bShowTopHoles = true;
bShowInvalid = true;
bShowNumber = false;
ahHolesHandles = zeros(1,iNumHoles);
ahSelectedHoleHandles = zeros(1,iNumHoles);
if ~isfield(strctDisplayParam,'m_aiHighlightedGroups')
    strctDisplayParam.m_aiHighlightedGroups  = [];
end

for iHoleIter=1:iNumHoles
    afGroupColor = strctGridModel.m_strctGridParams.m_a2fGroupColor(:, strctGridModel.m_strctGridParams.m_aiGroupAssignment(iHoleIter));
    
    if bShowNumber
        text(strctGridModel.m_afGridHolesX(iHoleIter),strctGridModel.m_afGridHolesY(iHoleIter),num2str(iHoleIter),'parent',hAxes,'horizontalalignment','center');
    end
    
    if bShowBottomHoles
    ahHolesHandles(iHoleIter) = plot(hAxes, ...
        (strctGridModel.m_afGridHolesX(iHoleIter)+strctGridModel.m_strctGridParams.m_fGridHeightMM*strctGridModel.m_apt3fGridHolesNormals(1,iHoleIter)+afCos*fHoleDiameterMM/2),...
        strctGridModel.m_afGridHolesY(iHoleIter)+strctGridModel.m_strctGridParams.m_fGridHeightMM*strctGridModel.m_apt3fGridHolesNormals(2,iHoleIter)+afSin*fHoleDiameterMM/2,...
        'color',afGroupColor*0.5,'linestyle','--');
    end
    
    if bShowTopHoles
        
        if  sum(strctDisplayParam.m_aiHighlightedGroups ==  strctGridModel.m_strctGridParams.m_aiGroupAssignment(iHoleIter)) > 0
            iLineWidth = 2;
        else
            iLineWidth = 1;
        end
        
    ahHolesHandles(iHoleIter) = plot(hAxes, ...
        (strctGridModel.m_afGridHolesX(iHoleIter)+ + afCos*fHoleDiameterMM/2),...
        strctGridModel.m_afGridHolesY(iHoleIter) + afSin*fHoleDiameterMM/2,...
        'color',afGroupColor,'LineWidth',iLineWidth);
            
    end
    
    if  bShowInvalid && strctGridModel.m_abIntersect(iHoleIter)
        
        plot([strctGridModel.m_afGridHolesX(iHoleIter)-fHoleDiameterMM/2  strctGridModel.m_afGridHolesX(iHoleIter)+fHoleDiameterMM/2],...
            [strctGridModel.m_afGridHolesY(iHoleIter)+fHoleDiameterMM/2  strctGridModel.m_afGridHolesY(iHoleIter)-fHoleDiameterMM/2],'r','LineWidth',2);
        plot([strctGridModel.m_afGridHolesX(iHoleIter)-fHoleDiameterMM/2  strctGridModel.m_afGridHolesX(iHoleIter)+fHoleDiameterMM/2],...
            [strctGridModel.m_afGridHolesY(iHoleIter)-fHoleDiameterMM/2  strctGridModel.m_afGridHolesY(iHoleIter)+fHoleDiameterMM/2],'r','LineWidth',2);
        
    end
    
    if strctGridModel.m_strctGridParams.m_abSelectedHoles(iHoleIter) % holes with electrodes....
        
        ahHolesHandles(iHoleIter) =  fill( (strctGridModel.m_afGridHolesX(iHoleIter) + afCos*fHoleDiameterMM/2),...
            strctGridModel.m_afGridHolesY(iHoleIter) + afSin*fHoleDiameterMM/2,...
            'm','parent',hAxes);
    end
    
    if ~isempty(strctDisplayParam.m_aiSelectedHoles) && sum(strctDisplayParam.m_aiSelectedHoles == iHoleIter)>0
         fill( (strctGridModel.m_afGridHolesX(iHoleIter) + afCos*fHoleDiameterMM/4),...
            strctGridModel.m_afGridHolesY(iHoleIter) + afSin*fHoleDiameterMM/4,...
            'r','parent',hAxes);
    end
    
    
    if strctDisplayParam.m_bDisplayHoleDirection
        plot([strctGridModel.m_afGridHolesX(iHoleIter),strctGridModel.m_afGridHolesX(iHoleIter)+strctGridModel.m_strctGridParams.m_fGridHeightMM*strctGridModel.m_apt3fGridHolesNormals(1,iHoleIter)],...
                [strctGridModel.m_afGridHolesY(iHoleIter),strctGridModel.m_afGridHolesY(iHoleIter)+strctGridModel.m_strctGridParams.m_fGridHeightMM*strctGridModel.m_apt3fGridHolesNormals(2,iHoleIter)],'color',afGroupColor,'LineWidth',2);
    end
end

fLengthMM = g_strctModule.m_astrctChambers.m_strctModel.m_strctModel.strctParams.m_fLengthMM;
fWidthMM = g_strctModule.m_astrctChambers.m_strctModel.m_strctModel.strctParams.m_fWidthMM;
a2fVertices = g_strctModule.m_astrctChambers.m_strctModel.m_strctModel.m_astrctMeshLong(2).m_a2fVertices;
a2fVertices = a2fVertices(1:2, a2fVertices(3, :)==0);
a2fVertices = [a2fVertices a2fVertices(:, 1)];
plot(hAxes, a2fVertices(1, :), a2fVertices(2, :), 'm', 'LineWidth', 2);
plot(hAxes, [0 0], [0 fLengthMM/2], 'y', 'LineWidth', 2);

set(hAxes, 'xlim', [-fWidthMM/2 fWidthMM/2], 'ylim', [-fLengthMM/2 fLengthMM/2]);
box on

