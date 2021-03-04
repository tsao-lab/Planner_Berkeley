function strctGridParam = fnDefineGridModel_DominoProbe()
% Generate a Domino Probe  model for fUS imaging.
% Domino Probe is in rectangular shape

strctGridParam.m_fWidthMM = 2; %assume fUS plane is 2 mm in thickness
strctGridParam.m_fLengthMM = 16; % activate region of the proble, which is 16 mm
strctGridParam.m_fXcMM = 0; % assume it is at the center of the chamber
strctGridParam.m_fYcMM = 0; % assume it is at the center of the chamber

% Members that must be present in a grid model
strctGridParam.m_strGridType = 'Domino Probe';
return;


