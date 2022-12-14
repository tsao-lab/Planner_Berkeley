function strctModel = fnBuildRectangularChamberModel_CustWidth(fChamberWidthMM)
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% Future versions may automatically do this projection so only the short
% version will be needed.
global g_strctModule
if isempty(g_strctModule.m_acAnatVol)
    fChamberWidthMM = 20;
else
    chamberParams = g_strctModule.m_astrctChambers(g_strctModule.m_iCurrChamber).m_strctModel.m_strctModel.strctParams;
    
    if ~isfield(chamberParams, 'm_fWidthMM')
        %not exist. May just changed from a circular chamber
        fChamberWidthMM = 20;
    else
        fChamberWidthMM = chamberParams.m_fWidthMM;
    end
 
    res = inputdlg({'Chamber width (mm)'},'Customer', [1 30], {num2str(fChamberWidthMM)}); 
    if isempty(res)
        ;
    else
        fChamberWidthMM = str2num(res{1});
    end
end

strctModel.strctParams = fnGetStandardRectChamberParams(fChamberWidthMM);
strctModel.m_astrctMeshShort = fnBuildRectModel( strctModel.strctParams, 80); %change from 0 to 80
strctModel.m_astrctMeshLong = fnBuildRectModel( strctModel.strctParams, 80);
return;


function strctParams = fnGetStandardRectChamberParams(fChamberWidthMM)
% Builds a 3D wire-frame model of a rectangular chamber
fChamberHeightMM = 20;
strctParams.m_strManufacterer = 'Rectangular';
strctParams.m_strName = sprintf('Rect %d mm',fChamberWidthMM);
strctParams.m_fWidthMM = fChamberWidthMM;
strctParams.m_fLengthMM = fChamberWidthMM;
strctParams.m_fHeightMM = fChamberHeightMM;
strctParams.m_hInChamberFunc = @(x, y) abs(x)<fChamberWidthMM/2 & abs(y)<fChamberLengthMM/2;

return;

function astrctMesh = fnBuildRectModel(strctChamberParams, fDepthMM)
astrctMesh= fnCreateRectChamberMesh(strctChamberParams.m_fWidthMM, strctChamberParams.m_fWidthMM, strctChamberParams.m_fHeightMM,fDepthMM,...
     [1 0 1]);
return;

