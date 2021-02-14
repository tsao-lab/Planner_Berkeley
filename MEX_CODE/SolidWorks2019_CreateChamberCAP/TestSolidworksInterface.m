% Test the solid works mex interface
addpath('C:\Users\Hongsun\Documents\GitHub\Planner\MEX\Win_x64');
afX = -1:1;
afY = -1:1;
[a2fX,a2fY]=meshgrid(afX,afY);


P = [a2fX(:)';a2fY(:)'];
N = size(P,2);
Tilt = zeros(1,N);
Rot = zeros(1,N);
Rad = ones(1,N) * 0.375;
strTemplate = 'C:\Users\Hongsun\Documents\GitHub\Planner\Solidworks\Grid_Template.SLDPRT';
strOutputFile = 'C:\Users\Hongsun\Documents\GitHub\Planner\Solidworks\RecordingChamberMod_aa.SLDPRT';


chamber_innerDiameter = 20;
chamber_outerDiameter = 22;
chamber_height = 15;
% iErr = fndllSolidWorksCreateChamberCAP2019(P, Tilt, Rot, Rad, strTemplate, strOutputFile,false);

grid_outerDiameter = chamber_innerDiameter-0.5;
grid_innerDiamter = grid_outerDiameter-2;
grid_outerHeight = 20;
grid_innerHeight = 10;

iErr = fndllSolidWorksCreateChamberCAP2019(P, Tilt, Rot, Rad, strTemplate, strOutputFile,false, ...
    chamber_innerDiameter, ... %7
    chamber_outerDiameter, ... %8
    chamber_height, ... %9
    grid_innerDiamter, ... %10
    grid_outerDiameter, ... %11
    grid_innerHeight, ... %12
    grid_outerHeight); %13

clear all
% 
% iErr = fndllSolidWorksRecordingChamber2016(P, Tilt, Rot, Rad, strTemplate, strOutputFile,false);
% %%
% addpath('C:\Users\shayo\SkyDrive\Planner\Code\MEX\Win_x64');
% load('C:\Users\shayo\SkyDrive\Planner\Code\SolidWorksDebug.mat');
% iErr = fndllSolidWorksRecordingChamber(P, Tilt, Rot, Rad, strTemplate, strOutputFile);
