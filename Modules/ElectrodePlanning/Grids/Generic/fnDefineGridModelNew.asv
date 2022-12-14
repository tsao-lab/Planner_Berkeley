function strctGridParams = fnDefineGridModelNew()
% Generate a new grid model.

% Define the default 0 deg grid that has 2 holes along the major axis

global g_strctModule

strctChamberParams = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber ...
    ).m_strctModel.m_strctModel.strctParams;
strctGridParams.m_fGridWidthMM = strctChamberParams.m_fWidthMM;
strctGridParams.m_fGridLengthMM = strctChamberParams.m_fLengthMM;
strctGridParams.m_fMinimumDistanceBetweenHolesMM = 1;
strctGridParams.m_fGridHoleDiameterMM = 0.73;
% strctGridParams.m_fGridInnerDiameterMM = 16.6;
% strctGridParams.m_fGridOuterDiameterMM = 19; %Added by Hongsun 2020-11
strctGridParams.m_fGridHeightMM = 10;
strctGridParams.m_fGridHeightAboveMM = 2;
strctGridParams.m_hValid = strctChamberParams.m_hInChamberFunc;
strctHoleGroup = fnDefaultHoleGroup();
iNumHoles = length(strctHoleGroup.a2fXc);

strctGridParams.m_a2fGroupColor = [0;1;0];
strctGridParams.m_acGroupNames = {'1'};
strctGridParams.m_aiGroupAssignment = ones(1, iNumHoles);  % one is the default group!
strctGridParams.m_afGridHoleXMM = strctHoleGroup.a2fXc();
strctGridParams.m_afGridHoleYMM = strctHoleGroup.a2fYc();
iNumGroups = 1;
strctGridParams.m_afGroupRotationDeg = zeros(1, iNumGroups);
strctGridParams.m_afGroupTiltDeg = zeros(1, iNumGroups);
strctGridParams.m_afGroupXMM = zeros(1, iNumGroups);
strctGridParams.m_afGroupYMM = zeros(1, iNumGroups);

% Members that must be present in a grid model
strctGridParams.m_strGridType = 'Generic';
strctGridParams.m_abSelectedHoles = [];



