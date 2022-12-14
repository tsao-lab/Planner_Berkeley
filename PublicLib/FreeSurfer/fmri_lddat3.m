function hdrdat = fmri_lddat3(datfile)
%
% Load information and parameters from a data file into an hdrdata
% structure. Upgrade for fmri_lddat2().
% 
% datfile - (string) name of data file
%
% $Id: fmri_lddat3.m,v 1.1 2003/03/04 20:47:39 greve Exp $

if(nargin ~= 1)
  msg = 'Usage: hdrdat = fmri_lddat3(datfile)'
  qoe(msg); error(msg);
end

fid=fopen(deblank(datfile),'r');
if( fid == -1 )
  msg = sprintf('Could not open dof file %s\n',datfile);
  qoe(msg); error(msg);
end

hdrdat = fmri_hdrdatstruct;

%% --- selavg stuff --- %%
hdrdat.TR      = fscanf2(fid,'%f');
hdrdat.TimeWindow      = fscanf2(fid,'%f');
hdrdat.TPreStim     = fscanf2(fid,'%f');
nPS     = floor(hdrdat.TPreStim/hdrdat.TR);
hdrdat.Nc   = fscanf2(fid,'%d');
hdrdat.Nnnc    = hdrdat.Nc - 1;
hdrdat.Nh   = fscanf2(fid,'%d'); % nperevent

%% --- selxavg stuff --- %%
if(isempty(hdrdat.Version))
  %fprintf('    INFO: Data file in selavg format\n');
  hdrdat.Version = 0;
  hdrdat.TER     = hdrdat.TR;
  hdrdat.DOF     = [];
  return;
end
hdrdat.Version = fscanf2(fid,'%d');
if(hdrdat.Version == 1 | hdrdat.Version == 2)
  fclose(fid);
  hdrdat = fmri_lddat2(datfile);
  return;
end

hdrdat.TER   = fscanf2(fid,'%f');
hdrdat.DOF   = fscanf2(fid,'%f');

dummy = fscanf(fid,'%s',1);
hdrdat.Npercond = fscanf(fid,'%d',hdrdat.Nc);

hdrdat.Nruns = fscanf2(fid,'%d');
hdrdat.Ntp   = fscanf2(fid,'%d');
hdrdat.Nrows = fscanf2(fid,'%d');
hdrdat.Ncols = fscanf2(fid,'%d');
hdrdat.Nskip = fscanf2(fid,'%d');
hdrdat.DTOrder  = fscanf2(fid,'%d');
hdrdat.RescaleFactor  = fscanf2(fid,'%f');
hdrdat.HanningRadius   = fscanf2(fid,'%f');
hdrdat.nNoiseAC = fscanf2(fid,'%d');
hdrdat.BrainAirSeg    = fscanf2(fid,'%d');

%%--------- Gamma Fit -------------%%%
hdrdat.GammaFit   = fscanf2(fid,'%d');
if(hdrdat.GammaFit == 0)
  hdrdat.gfDelta = [];
  hdrdat.gfTau = [];
else
  dummy = fscanf(fid,'%s',1);
  hdrdat.gfDelta  = fscanf(fid,'%f',hdrdat.GammaFit);
  dummy = fscanf(fid,'%s',1);
  hdrdat.gfTau    = fscanf(fid,'%f',hdrdat.GammaFit);
end

hdrdat.NullCondId = fscanf2(fid,'%d');

if(~hdrdat.GammaFit)  Nch = hdrdat.Nnnc*hdrdat.Nh;
else                  Nch = hdrdat.Nnnc*length(hdrdat.gfDelta);
end

dummy      = fscanf(fid,'%s',1);
hdrdat.SumXtX     = fscanf(fid,'%f',Nch*Nch);

nSumXtX = prod(size(hdrdat.SumXtX));
if(nSumXtX ~= Nch*Nch )
  msg = sprintf('Inconsistent Dimensions: nSumXtX=%d, Nch^2 = %d\n',...
                nSumXtX,Nch*Nch);
  qoe(msg);error(msg);
end
hdrdat.SumXtX     = reshape(hdrdat.SumXtX,[Nch Nch]);

dummy          = fscanf(fid,'%s',1);
[hdrdat.hCovMtx c] = fscanf(fid,'%f',Nch*Nch);
if(c ~= Nch*Nch)
  msg = sprintf('Could not read hCovMtx from %s\n',datfile);
  hdrdat = [];
  qoe(msg); error(msg);
end
hdrdat.hCovMtx = reshape(hdrdat.hCovMtx,[Nch Nch]);

dummy            = fscanf(fid,'%s',1);
hdrdat.CondIdMap = fscanf(fid,'%f',hdrdat.Nc);


dummy = fscanf(fid,'%s',1);
hdrdat.LPFFlag = fscanf(fid,'%d',1);

dummy = fscanf(fid,'%s',1);
hdrdat.HPF = fscanf(fid,'%f',2);

dummy = fscanf(fid,'%s',1);
hdrdat.WhitenFlag = fscanf(fid,'%d',1);


dummy = fscanf(fid,'%s',1);
hdrdat.runlist = fscanf(fid,'%d',hdrdat.Nruns);

dummy = fscanf(fid,'%s',1);
hdrdat.funcstem = fscanf(fid,'%s',1);

dummy = fscanf(fid,'%s',1);
hdrdat.parname  = fscanf(fid,'%s',1);

dummy = fscanf(fid,'%s',1);
hdrdat.extregstem  = fscanf(fid,'%s',1);

dummy = fscanf(fid,'%s',1);
hdrdat.nextreg = fscanf(fid,'%d',1);

dummy = fscanf(fid,'%s',1);
hdrdat.extregortho = fscanf(fid,'%d',1);

fclose(fid);

return


%%%%%%%%%%%%%%------------------------%%%%%%%%%%%%%%%%%%
%- reads a string followed by a value -----%
function x = fscanf2(fid,fmt)
  fscanf(fid,'%s',1);
  [x c] = fscanf(fid,fmt,1);
  if(c ~= 1)
    x = []; return;
  end
return;
