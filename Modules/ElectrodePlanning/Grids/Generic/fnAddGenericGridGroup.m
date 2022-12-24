function strctGridModel = fnAddGenericGridGroup(strctGridModel, x, y, rotation, tilt)

if ~exist('x', 'var') || isempty(x)
    x = 0;
end
if ~exist('y', 'var') || isempty(y)
    y = 0;
end
if ~exist('rotation', 'var') || isempty(rotation)
    rotation = 0;
end
if ~exist('tilt', 'var') || isempty(tilt)
    tilt = 0;
end

iNumGroups = length(strctGridModel.m_strctGridParams.m_acGroupNames);
iNewGroupIndex = iNumGroups+1;
a2fColors = lines(iNewGroupIndex);
afNextColor = a2fColors(end,:);
strctHoleGroup = fnDefaultHoleGroup();
iNumHoles = length(strctHoleGroup.afXc);

strctGridModel.m_strctGridParams.m_a2fGroupColor = ...
    [strctGridModel.m_strctGridParams.m_a2fGroupColor, afNextColor'];
strctGridModel.m_strctGridParams.m_acGroupNames = [strctGridModel.m_strctGridParams.m_acGroupNames ...
    sprintf('%d',iNewGroupIndex)];
strctGridModel.m_strctGridParams.m_aiGroupAssignment = [strctGridModel.m_strctGridParams.m_aiGroupAssignment ...
    repmat(iNewGroupIndex, 1, iNumHoles)];
strctGridModel.m_strctGridParams.m_afGridHoleXMM = [strctGridModel.m_strctGridParams.m_afGridHoleXMM ...
    strctHoleGroup.afXc];
strctGridModel.m_strctGridParams.m_afGridHoleYMM = [strctGridModel.m_strctGridParams.m_afGridHoleYMM ...
    strctHoleGroup.afYc];
strctGridModel.m_strctGridParams.m_afGroupXMM(iNewGroupIndex) = x;
strctGridModel.m_strctGridParams.m_afGroupYMM(iNewGroupIndex) = y;
strctGridModel.m_strctGridParams.m_afGroupRotationDeg(iNewGroupIndex) = rotation;
strctGridModel.m_strctGridParams.m_afGroupTiltDeg(iNewGroupIndex) = tilt;
strctGridModel.m_strctGridParams.m_abSelectedHoles = [strctGridModel.m_strctGridParams.m_abSelectedHoles ...
    strctHoleGroup.abSelected];
strctGridModel = fnBuildGridModelNew(strctGridModel.m_strctGridParams);
