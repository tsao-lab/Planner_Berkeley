function fnACPC2EBZ(strNiiFileName, strNiiFileNameNew)
%FNACPC2EBZ Converts nii files from ACPC to EBZ coordinates

if ~exist(strNiiFileName, 'file')
    error('File does not exist')
end
if exist(strNiiFileNameNew, 'file')
    answer = questdlg(sprintf('%s already exists. Overwrite?', strNiiFileNameNew), ...
        'File already exists', 'Yes');
    if ~strcmp(answer, 'Yes')
        return
    end
end

info = niftiinfo(strNiiFileName);
V = niftiread(strNiiFileName);
tmp = eye(4);
tmp(2, 4) = 20;
tmp(3, 4) = 13.75;
tmp2 = tmp*info.Transform.T.';
info.Transform.T = tmp2.';
niftiwrite(V, strNiiFileNameNew, info);

end

