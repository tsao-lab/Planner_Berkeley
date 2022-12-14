Update Dec/13/2022:

- Changed how .nii files are loaded from Tk coordinates to the nifti coordinates defined by the transform matrix in the file. The origin is no more the center of the volume, but the offset vector in the inverse of the transform matrix. 
    - As a result of this, external volumes (e.g. atlases) are loaded with the proper translation and rotation
- All volumes are now positioned in the same coordinate system. This is also the stereotaxic coordinate system in the EBZ frame, if you load the provided D99_template_ebz.nii Saleem-Logothetis atlas or any volume aligned to it properly.
    - Since the coordinate system is unified, 'Copy Orientation From' function is removed from all volumes.
- Because of the previous updates, how transform matrix is loaded has been changed. The target that you used during TkRegister has to be loaded first, and chosen as the target when you click 'Apply Transform To'. 'Apply Default Transform' assumes that you aligned the volume to the D99_template_ebz atlas, which you don't necessarily have to load.
- Atlas has been updated to D99_atlas_v2.0, which includes subcortical regions. 'Toggle Atlas' will show rasterized region borders in colors. If you hover the pointer over a labeled region, the text on the top left will display the latest label of the corresponding region.
- Shortcuts have been added to switch between different modes. Hints are on the bottom right side of the panel.
- Because of the changes in the coordinate system, chambers, targets and ROIs are now shared among all volumes. 'Copy To' functions has been removed. 
- A new chamber model 'Octagonal' has been added that corresponds to our new big chamber, and is now the default chamber.
- A new grid model 'Generic' has been added with the following features:
    - Automatic detection of parent chamber shape and border
    - Instead of loading a full NxN grid of holes by default and removing holes manually afterwards, now only 5 holes in a '+' configuration is loaded by default. Individual holes can be now added manually using 'Add Hole'.
    - Each group now has its own translation in X and Y that are saved permanently per group. Use this to move the group above desired targets.
    - You can now add a new group directly using 'Add Group', which will generate another 5 holes in the new group at the center of the chamber.
    - Changed the view in the GridGUI from bottom to top, such that left in the GUI correspond to left in the 3D volume. 


## About Planner

Planner is a software that assists in MR-guided electrophysiology. 
The software enables easy visualization of the target site and allows the user to place virtual chambers, grids, 
and electrodes with different designs. It can also find optimal trajectories by finding the optimal grid hole, 
rotation and tilt angle.  The other key feature of this software is its ability to automatically solve the 
registration problem between MR space and stereotactic space. 
It can report the stereotactic parameters needed to place the manipulator's tip and align it with the planned 
chamber position in any desierable direction.
Recently, we added a new feature that allows to design custom grids with each grid hole going in arbitrary direction.
 Such grids can be automatically exported as a Solidworks model and printed on a high end 3D printer (Projet).

Publication:
Detailed description of the approach can be found in the following manuscript: 
Ohayon S, Tsao DY, MR-Guided Stereotactic Navigation,
J Neurosci Methods. 2012 Mar 15;204(2):389-97. Epub 2011 Dec 13

System Requirements

Operating System: Windows XP/Vista (32 or 64 bit), Linux (64 bit only), Mac (64 bit only)
Matlab: Should be compatible with R2009b and later verions 
Solidworks: If you are planning to print custom grids using the grid export function, make sure you are running with Windows 64 bit. Solidworks 2011, 2012 and 2013 are supported.
Memory: Although you can probably run planner with as little as 1G of RAM, it is usually preferred to have at least 4G. The more volumes you load, the more memory will be required.
Screen Resolution: At least 800 vertical pixels. If you are running on a windows laptop with 1200x800 (or similar), move the taskbar location to the left.
CPU: No real requirement here, but you probably want Core 2 Duo or stronger
Graphic card: If you plan to visualize surfaces, a good graphics card is required (nVidia Geforce/Quadro)



Installation instructions:

1. check out the repository
 
2. Window users: add a system environment variable (Start->Control Panel->System->Edit the system environment variables)
Name: MATLAB64BIN
Value: C:\MATLAB\R2009b_x64\bin\win64\MATLAB.exe (modify this to where you installed matlab)
 
use Runme_x64.bat to run planner
 
If you are using 32 bin version, add this variable:
Name: MATLAB32BIN
Value: C:\MATLAB\R2009b_x32\bin\win64\MATLAB.exe (modify this to where you installed the 32-bit version of matlab)
 
use Runme.bat to run planner
 
Linux/Mac users:
use runme.csh to run planner (assuming matlab is already in the path)