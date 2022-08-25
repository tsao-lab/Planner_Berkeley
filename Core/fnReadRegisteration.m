function [T, strSubjectName, strVolType,afVoxelSpacing] = fnReadRegisteration(strFilename)
hFileID = fopen(strFilename, 'rb');
strSubjectName = fgets(hFileID);

fdC = sscanf(fgets(hFileID),'%f'); % in-plane resolution
if isempty(fdC)
    fdC = sscanf(fgets(hFileID),'%f');
end
fdR = sscanf(fgets(hFileID),'%f'); % between-plane resolution
fdS = sscanf(fgets(hFileID),'%f'); % intensity

T1 = sscanf(fgets(hFileID),'%e %e %e %e');
T2 = sscanf(fgets(hFileID),'%e %e %e %e');
T3 = sscanf(fgets(hFileID),'%e %e %e %e');
T4 = sscanf(fgets(hFileID),'%e %e %e %e');

T = [T1';T2';T3';T4'];
strVolType = fgets(hFileID); % float2int
afVoxelSpacing = [fdC, fdR, fdS]; % ???
fclose(hFileID);

m2tk = [1 0 0 0;
        0 0 1 0;
        0 1 0 0;
        0 0 0 1];
T = m2tk\T*m2tk;