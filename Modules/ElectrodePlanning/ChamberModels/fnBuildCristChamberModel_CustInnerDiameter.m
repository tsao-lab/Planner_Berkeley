%Added by Hongsun 2020-10-06
function strctModel = fnBuildCristChamberModel_CustInnerDiameter(fChamberAngle)
% A chamber must have only two strctures that describe the 3D geometry
% One is "short" (normal size) and one is "long" to see its projection in
% the volume. 
%
% Future versions may automatically do this projection so only the short
% version will be needed.

%Added by Hongsun 2020-10-06
res = inputdlg({'Inner diameter (mm)','Chamber Angle'},...
              'Customer', [1 30; 1 30], {'19','0'}); 
if isempty(res)
    fInnerDiameterMM = 19.00;
    fChamberAngle = 0;
else
    newInnerDiameter = str2num(res{1});
    fChamberAngle = str2num(res{2});
end

% newInnerDiameter = 20;
% fChamberAngle = 0;
strctModel.strctParams = fnGetStandardCristChamberParams(fChamberAngle, newInnerDiameter);
strctModel.m_astrctMeshShort = fnBuildShortModel( strctModel.strctParams);
strctModel.m_astrctMeshLong = fnBuildLongModel( strctModel.strctParams);
return;

function strctParams = fnGetStandardCristChamberParams(fChamberAngle, newInnerDiameter)
% Builds a 3D wire-frame model of a chamber
fInnerDiameterMM = newInnerDiameter; % mm
fOuterDiameterMM = fInnerDiameterMM + 5;

% comment by Hongsun
% fOuterDiameterMM = 24.0; % mm
% fInnerDiameterMM = 19.00;

% fOuterDiameterMM = 22.0; % mm
% fInnerDiameterMM = 16.00;


fChamberH1 = 20.25;
if (fChamberAngle == 0)
    fChamberH2  = 20.25;
else
    % These values are for a "30" deg chamber
    fChamberH2 = 33;
end
strctParams.m_strManufacterer = 'Crist';
strctParams.m_strName = sprintf('Crist %d Deg',fChamberAngle);
strctParams.m_fOuterDiameterMM = fOuterDiameterMM;
strctParams.m_fInnerDiameterMM = fInnerDiameterMM;
strctParams.m_fChamberH1 = fChamberH1;
strctParams.m_fChamberH2 = fChamberH2;
strctParams.m_fChamberAngleDeg = fChamberAngle;
strctParams.m_iQuat = 20;
return;

function astrctMeshShort = fnBuildShortModel(strctChamberParams)
astrctMeshShort(1)= fnCreateChamberMesh(strctChamberParams.m_fInnerDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(2)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(3)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -80,...
    -80, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMeshShort(4)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -80,...
    -80, 0,strctChamberParams.m_iQuat, [1 0 1]);

strctMesh.m_a2fVertices = [ 0                                      0            0                           0; ...
                          strctChamberParams.m_fInnerDiameterMM/2  0 strctChamberParams.m_fInnerDiameterMM/2 0;...
                           -strctChamberParams.m_fChamberH1 -strctChamberParams.m_fChamberH1 0  0];
strctMesh.m_a2iFaces = [1,2,3; 2 3 4]';       
strctMesh.m_afColor = [1 1 0];
strctMesh.m_fOpacity = 0.4;

astrctMeshShort(5) = strctMesh;

return;

function astrctMesh = fnBuildLongModel(strctChamberParams)

astrctMesh(1)= fnCreateChamberMesh(strctChamberParams.m_fInnerDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

astrctMesh(2)= fnCreateChamberMesh(strctChamberParams.m_fOuterDiameterMM, -strctChamberParams.m_fChamberH1,...
    -strctChamberParams.m_fChamberH2, 0,strctChamberParams.m_iQuat, [1 0 1]);

strctMesh.m_a2fVertices = [ 0                                      0            0                           0; ...
                          strctChamberParams.m_fInnerDiameterMM/2  0 strctChamberParams.m_fInnerDiameterMM/2 0;...
                           -strctChamberParams.m_fChamberH1 -strctChamberParams.m_fChamberH1 0  0];
strctMesh.m_a2iFaces = [1,2,3; 2 3 4]';       
strctMesh.m_afColor = [1 1 0];
strctMesh.m_fOpacity = 0.4;
astrctMesh(3) = strctMesh;

return;