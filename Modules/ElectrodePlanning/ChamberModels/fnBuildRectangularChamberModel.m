function strctModel = fnBuildRectangularChamberModel(fChamberWidthMM)
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% Future versions may automatically do this projection so only the short
% version will be needed.
strctModel.strctParams = fnGetStandardRectChamberParams(fChamberWidthMM);
strctModel.m_astrctMeshShort = fnBuildRectModel( strctModel.strctParams, 80); %change from 0 to 80
strctModel.m_astrctMeshLong = fnBuildRectModel( strctModel.strctParams, 80);

return;


function strctParams = fnGetStandardRectChamberParams(fChamberWidthMM)
% Builds a 3D wire-frame model of a rectangular chamber
fChamberHeightMM = 20; %change from 20 to 80
strctParams.m_strManufacterer = 'Rectangular';
strctParams.m_strName = sprintf('Rect %d mm',fChamberWidthMM);
strctParams.m_fWidthMM = fChamberWidthMM;
strctParams.m_fHeightMM = fChamberHeightMM;

return;

function astrctMesh = fnBuildRectModel(strctChamberParams, fDepthMM)
astrctMesh= fnCreateRectChamberMesh(strctChamberParams.m_fWidthMM, strctChamberParams.m_fHeightMM,fDepthMM,...
     [1 0 1]);
return;

