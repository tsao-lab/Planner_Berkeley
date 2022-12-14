function strctModel = fnBuildOctChamberModel()
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% Future versions may automatically do this projection so only the short
% version will be needed.
fChamberWidthMM = 55;
fChamberLengthMM = 52;
fChamberChamferMM = 4+3*sqrt(2);
fChamberHeightMM = 9.5;
fChamberDepthMM = 20;
strctModel.strctParams = fnGetStandardRectChamberParams(fChamberWidthMM, ...
    fChamberLengthMM, fChamberChamferMM, fChamberHeightMM, fChamberDepthMM);
strctModel.m_astrctMeshShort = fnBuildRectModel(strctModel.strctParams);
strctModel.m_astrctMeshLong = fnBuildRectModel(strctModel.strctParams);

end


function strctParams = fnGetStandardRectChamberParams(fChamberWidthMM, ...
    fChamberLengthMM, fChamberChamferMM, fChamberHeightMM, fChamberDepthMM)
% Builds a 3D wire-frame model of a rectangular chamber
strctParams.m_strManufacterer = 'Octagonal';
strctParams.m_strName = sprintf('Oct');
strctParams.m_fWidthMM = fChamberWidthMM;
strctParams.m_fLengthMM = fChamberLengthMM;
strctParams.m_fChamferMM = fChamberChamferMM;
strctParams.m_fHeightMM = fChamberHeightMM;
strctParams.m_fDepthMM = fChamberDepthMM;
f1 = fChamberWidthMM/2+fChamberLengthMM/2-fChamberChamferMM;
strctParams.m_hInChamberFunc = @(x, y) abs(x)<fChamberWidthMM/2 & abs(y)<fChamberLengthMM/2 & ...
    abs(x+y)<f1 & abs(x-y)<f1;
end

function astrctMesh = fnBuildRectModel(strctChamberParams)
astrctMesh= fnCreateOctChamberMesh(strctChamberParams.m_fWidthMM, strctChamberParams.m_fLengthMM, ...
    strctChamberParams.m_fChamferMM, strctChamberParams.m_fHeightMM, strctChamberParams.m_fDepthMM,...
     [1 0 1]);
end

