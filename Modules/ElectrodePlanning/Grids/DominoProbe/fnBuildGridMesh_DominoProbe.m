function astrctMesh = fnBuildGridMesh_DominoProbe(strctGridModel, bDrawShort,bHighlight)
clear astrctMesh
if ~exist('bHighlight','var')
    bHighlight = false;
end;

% iNumGroups = length(strctGridModel.m_strctGridParams.m_acGroupNames);
astrctMesh = [];

fWidthMM = strctGridModel.m_strctGridParams.m_fWidthMM;
fLengthMM = strctGridModel.m_strctGridParams.m_fLengthMM;


fHeightMM = 20; %Height of the flag plane
fHeightMM_Projection = 60;

strctMesh.m_a2fVertices= [0, 0, 0;
                          0, +fLengthMM/2, 0;
                          0, 0, -fHeightMM;
                          0, +fLengthMM/2, -fHeightMM]';
                          
strctMesh.m_a2iFaces = [1, 3;
                        2, 4;
                        3, 2];
strctMesh.m_afColor = [0 1 1];
strctMesh.m_fOpacity = 0.4;

astrctMesh = [astrctMesh, strctMesh];
astrctMesh  = [astrctMesh, fnCreateRectChamberMeshAux2(fWidthMM, fLengthMM, -fHeightMM,  0, [0 1 1])];
astrctMesh  = [astrctMesh, fnCreateRectChamberMeshAux2(fWidthMM, fLengthMM, -fHeightMM-fHeightMM_Projection,  -fHeightMM, [0 1 1])];


%mid line
strctMesh.m_a2fVertices= [0, -fLengthMM/2, -fHeightMM;
                          0, +fLengthMM/2, -fHeightMM;
                          0, -fLengthMM/2, -fHeightMM-fHeightMM_Projection;
                          0, +fLengthMM/2, -fHeightMM-fHeightMM_Projection]';
                          
strctMesh.m_a2iFaces = [1, 3;
                        2, 4;
                        3, 2];
strctMesh.m_afColor = [0 1 1];
strctMesh.m_fOpacity = 0.4;

astrctMesh = [astrctMesh, strctMesh]; %add mid line
astrctMesh = fnShiftXY(astrctMesh, 2, 2);
return;

function strctMesh = fnCreateRectChamberMeshAux2(fWidthMM, fLengthMM, fLowZ, fHighZ, afColor)
strctMesh.m_a2fVertices= [-fWidthMM/2, -fLengthMM/2, fLowZ;
                          -fWidthMM/2, +fLengthMM/2, fLowZ;
                          +fWidthMM/2, -fLengthMM/2, fLowZ;
                          +fWidthMM/2, +fLengthMM/2, fLowZ;
                          -fWidthMM/2, -fLengthMM/2, fHighZ;
                          -fWidthMM/2, +fLengthMM/2, fHighZ;
                          +fWidthMM/2, -fLengthMM/2, fHighZ;
                          +fWidthMM/2, +fLengthMM/2, fHighZ]';
                          
strctMesh.m_a2iFaces = [1, 1, 1, 3, 3, 3, 2, 4;
                        2, 6, 3, 5, 8, 4, 4, 6;
                        6, 5, 5, 7, 7, 8, 6, 8];
strctMesh.m_afColor = afColor;
strctMesh.m_fOpacity = 0.4;
return;

function astrctMesh = fnShiftXY(astrctMesh, fShiftX, fShiftY)
for k=1:length(astrctMesh)
    vertices = astrctMesh(k).m_a2fVertices;
    shiftMax = [fShiftX.*ones(1, size(vertices, 2)); fShiftY.*ones(1, size(vertices, 2)); zeros(1, size(vertices, 2))];
    astrctMesh(k).m_a2fVertices = vertices + shiftMax;
end
return;


% function strctMesh = fnCreateRectChamberMeshAux(fWidthMM, fLowZ, fHighZ, afColor)
% strctMesh.m_a2fVertices= [-fWidthMM/2, -fWidthMM/2, fLowZ;
%                           -fWidthMM/2, +fWidthMM/2, fLowZ;
%                           +fWidthMM/2, -fWidthMM/2, fLowZ;
%                           +fWidthMM/2, +fWidthMM/2, fLowZ;
%                           -fWidthMM/2, -fWidthMM/2, fHighZ;
%                           -fWidthMM/2, +fWidthMM/2, fHighZ;
%                           +fWidthMM/2, -fWidthMM/2, fHighZ;
%                           +fWidthMM/2, +fWidthMM/2, fHighZ]';
%                           
% strctMesh.m_a2iFaces = [1, 1, 1, 3, 3, 3, 2, 4;
%                         2, 6, 3, 5, 8, 4, 4, 6;
%                         6, 5, 5, 7, 7, 8, 6, 8];
% strctMesh.m_afColor = afColor;
% strctMesh.m_fOpacity = 0.4;
% return;



