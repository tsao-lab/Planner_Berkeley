%% 
delete('.\Config\PlannerConfig.xml');
movefile('.\Config\PlannerConfigOfficial.xml','.\Config\PlannerConfig.xml');
delete('.\TODO.Txt');

rmdir('.\MEX_CODE','s');
rmdir('.\Modules\AtlasMarker','s');
rmdir('.\Modules\DICOM_Import','s');
rmdir('.\Modules\DigitalReadout','s');
rmdir('.\Modules\GridMeasure','s');
rmdir('.\Modules\Registeration','s');
rmdir('.\Modules\VolumeViewer','s');

%%

acDirs = parsedirs(genpath('.\Core'));
    acDirs = [acDirs;parsedirs(genpath('.\Modules'));];
    iCounter = 1;
    clear acAvailFiles
    for k=1:length(acDirs)
        astrctFiles = dir([acDirs{k}(1:end-1),'\*.m']);
        for j=1:length(astrctFiles)
            acAvailFiles{iCounter} = [acDirs{k}(1:end-1),'\',astrctFiles(j).name];
            iCounter=iCounter+1;
        end
    end

acIgnoreFiles = {'fnBuildCannulaChamberModel',...
                 'fnBuildCristChamberModel',...
                 'fnBuildManipulatorTipModel',...
                 'fnCreateCylinderMeshWithBottom',...
                 'fnBuildGridMesh_Standard',...
                 'fnBuildGridModel_Standard',...
                 'fnDefineGridModel_Standard',...
                 'fnDraw2DGridModel_Standard',...
                 'fnBuildGridMesh_DualCircular',...
                 'fnBuildGridModel_DualCircular',...
                 'fnDefineGridModel_DualCircular',...
                 'fnDraw2DGridModel_DualCircular',...
                 'fnKopf900ALeftArmMod',...
                 'fnKopf1460LeftArm',...
                 'fnKopf1460RightArm',...
                 'fnKopf1460RightArm_MO',...
                 'fnUserDefinedImport',...
                 'fnBuildGridMesh_GenericCircular',...
                 'fnBuildGridModel_Generic',...
                 'fnDefineGridModel_Generic',...
                 'fnDraw2DGridModel_Generic',...
                 'GenericCircularGirdGUI'};
                 
 % covert
 for k=1:length(acAvailFiles)
     [strP,strF]=fileparts(acAvailFiles{k});
     if ~ismember(lower(strF),  lower(acIgnoreFiles))
        pcode(acAvailFiles{k},'-inplace');
        delete(acAvailFiles{k});
     end
 end;
 
pcode('EntryPoint.m','-inplace');
delete('EntryPoint.m');

   