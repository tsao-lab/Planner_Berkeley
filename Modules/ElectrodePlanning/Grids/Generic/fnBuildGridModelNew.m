function strctGridModel = fnBuildGridModelNew(strctGridParams)
% This function generates a structure that contains the grid model
% It uses various information in strctGridParams to construct the grid
% The output is a structure that must contain
%
%
% strctGridModel.m_strctGridParams  - Parameters used to construct this model
% strctGridModel.m_afGridHolesX    - Holes X Position
% strctGridModel.m_afGridHolesY    - Holes Y Position
% strctGridModel.m_apt3fGridHolesNormals - Holes Normal Direction
%
%

%%
iNumHoles = length(strctGridParams.m_afGridHoleXMM);
afGridHoleXMM = strctGridParams.m_afGridHoleXMM+...
    strctGridParams.m_afGroupXMM(strctGridParams.m_aiGroupAssignment);
afGridHoleYMM = strctGridParams.m_afGridHoleYMM+...
    strctGridParams.m_afGroupYMM(strctGridParams.m_aiGroupAssignment);
afGridHoleTiltDeg = strctGridParams.m_afGroupTiltDeg(strctGridParams.m_aiGroupAssignment);
afGridHoleRotationDeg = strctGridParams.m_afGroupRotationDeg(strctGridParams.m_aiGroupAssignment);

afZ=-cos(afGridHoleTiltDeg/180*pi);
afX=sin(afGridHoleRotationDeg/180*pi).*...
    sin(afGridHoleTiltDeg/180*pi);
afY=cos(afGridHoleRotationDeg/180*pi).*...
    sin(afGridHoleTiltDeg/180*pi);

strctGridModel.m_strctGridParams = strctGridParams;
strctGridModel.m_afGridHolesX = afGridHoleXMM;
strctGridModel.m_afGridHolesY = afGridHoleYMM;
strctGridModel.m_afGridHoleTiltDeg = afGridHoleTiltDeg;
strctGridModel.m_afGridHoleRotationDeg = afGridHoleRotationDeg;
strctGridModel.m_apt3fGridHolesNormals = [afX;afY;afZ];
if ~isfield(strctGridModel.m_strctGridParams,'m_abSelectedHoles')
    strctGridModel.m_strctGridParams.m_abSelectedHoles = zeros(1, iNumHoles)>0;
else
    if length(strctGridModel.m_strctGridParams.m_abSelectedHoles) ~= iNumHoles
        strctGridModel.m_strctGridParams.m_abSelectedHoles = zeros(1, iNumHoles)>0;
    end
end

%%
strctGridModel.m_abIntersect = fnTestHoleIntersection(strctGridModel);
strctGridModel.m_acGroupBoundaries = fnFindGroupBoundaries(strctGridModel);
strctGridModel.m_astrctGridMesh = fnBuildGridMeshNew(strctGridModel, false, true);

end

function acGroupBoundaries = fnFindGroupBoundaries(strctGridModel)
% Found group boundaries....
iNumGroups = length(strctGridModel.m_strctGridParams.m_acGroupNames);
acGroupBoundaries = cell(1, iNumGroups);
for iGroupIter = 1:iNumGroups
    aiRelevantHoles = find(strctGridModel.m_strctGridParams.m_aiGroupAssignment == iGroupIter);
    if isempty(aiRelevantHoles)
        continue
    end
    fCurrentDistanceMM = 1/cos(strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iGroupIter)/180*pi);
    Xc = strctGridModel.m_strctGridParams.m_afGroupXMM(iGroupIter);
    Yc = strctGridModel.m_strctGridParams.m_afGroupYMM(iGroupIter);
    afXDist = round(strctGridModel.m_strctGridParams.m_afGridHoleXMM(aiRelevantHoles)/...
        fCurrentDistanceMM);
    afYDist = round(strctGridModel.m_strctGridParams.m_afGridHoleYMM(aiRelevantHoles)/...
        fCurrentDistanceMM);
    fMinX = min(afXDist);
    fMaxX = max(afXDist);
    fMinY = min(afYDist);
    fMaxY = max(afYDist);
    iXRange = fMaxX-fMinX+2;
    iYRange = fMaxY-fMinY+2;
    a2bI = false(iYRange, iXRange);
    aiX = [afXDist afXDist afXDist+1 afXDist+1]-fMinX+1;
    aiY = [afYDist afYDist+1 afYDist afYDist+1]-fMinY+1;
    aiInd = sub2ind([iYRange, iXRange], aiY, aiX);
    a2bI(aiInd) = true;
    acBoundaries = bwboundaries(a2bI, 4);
    iNumSubRegions = length(acBoundaries);
    for iSubRegionIter = 1:iNumSubRegions
        acGroupBoundaries{iGroupIter}{iSubRegionIter} = ...
            [((acBoundaries{iSubRegionIter}(:,2)+fMinX-1.5)*fCurrentDistanceMM + Xc), ...
            (acBoundaries{iSubRegionIter}(:,1)+fMinY-1.5)*fCurrentDistanceMM + Yc]';
    end
end
end


function abIntersect = fnTestHoleIntersection(strctGridModel)
% Hole intersection?
% given, [x1,x2], [x3,x4], the distance between the lines is given by:
% D = | dot(c, A x B) |  / |A x B|
% where:
% A = x2-x1
% B = x4-x3
% C = x3-x1

% Use the fast dll implementation...
iNumHoles = length(strctGridModel.m_afGridHolesX);

P1 = [strctGridModel.m_afGridHolesX;strctGridModel.m_afGridHolesY;zeros(1,iNumHoles)];
afNrm = strctGridModel.m_apt3fGridHolesNormals;
afNrm(1,:)=-afNrm(1,:);
P2 = P1+10*afNrm;
[afDist,~] = fndllLineLineDist(P1,P2);
%afDist = fndllLineLineDist(P1,P2);

fTolerance = 0.001;
abIntersectEachOther = sqrt(afDist(:)') < ...
    strctGridModel.m_strctGridParams.m_fMinimumDistanceBetweenHolesMM-fTolerance;

% Check intersection with outer wall...
% Top ?
% abIntersectTop = ~strctGridModel.m_strctGridParams.m_hValid(...
%     strctGridModel.m_afGridHolesX, strctGridModel.m_afGridHolesY);
afHolesLength = strctGridModel.m_strctGridParams.m_fGridHeightMM./...
    cos(strctGridModel.m_afGridHoleTiltDeg/180*pi);
apt3fBottom= P1+afNrm.*[afHolesLength;afHolesLength;afHolesLength];

afHolesLengthAbove = strctGridModel.m_strctGridParams.m_fGridHeightAboveMM./...
    cos(strctGridModel.m_afGridHoleTiltDeg/180*pi);
apt3fAbove= P1-afNrm.*[afHolesLengthAbove;afHolesLengthAbove;afHolesLengthAbove];

abIntersectBottom = ~strctGridModel.m_strctGridParams.m_hValid(...
    apt3fBottom(1,:), apt3fBottom(2,:));
abIntersectAbove = ~strctGridModel.m_strctGridParams.m_hValid(...
    apt3fAbove(1,:), apt3fAbove(2,:));

abIntersect = abIntersectEachOther | abIntersectBottom | abIntersectAbove;

end


% 
% if 0
% iNumHoles = length(strctGridModel.m_afGridHolesX);
% 
% abIntersect = zeros(1,iNumHoles) > 0;
% for iHoleIter1=1:iNumHoles
%     bIntersect = false;
%     for iHoleIter2=iHoleIter1+1:iNumHoles
%         
%         A = strctGridModel.m_apt3fGridHolesNormals(:,iHoleIter1);
%         B = strctGridModel.m_apt3fGridHolesNormals(:,iHoleIter2);
%         C = [strctGridModel.m_afGridHolesX(iHoleIter1)-strctGridModel.m_afGridHolesX(iHoleIter2),strctGridModel.m_afGridHolesY(iHoleIter1)-strctGridModel.m_afGridHolesY(iHoleIter2),0];
%         Cn = sqrt(sum(C.^2));
%         
%         AxB = [A(2)*B(3)-A(3)*B(2), A(3)*B(1)-A(1)*B(3), A(1)*B(2)-A(2)*B(1);];      
%         AxBn = sqrt(sum(AxB.^2));
%         
%         fDistance = abs(sum(AxB.*C)) / AxBn;
%         
%         bIntersect =  (AxBn == 0&& Cn < strctGridModel.m_strctGridParams.m_fMinimumDistanceBetweenHolesMM) || ... (% parallel)
%                                 (AxBn > 0 && fDistance < strctGridModel.m_strctGridParams.m_fMinimumDistanceBetweenHolesMM); % (non-parallel)
%         if bIntersect
%                 break;
%         end
%     end
%     
%     abIntersect(iHoleIter1) = bIntersect;
% end
% 
% end