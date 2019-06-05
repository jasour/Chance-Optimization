function failfun = chebtest(dirname)
% CHEBTEST Probe chebfun system against standard test files.
% CHEBTEST DIRNAME runs each M-file in the directory DIRNAME. Each M-file
% should be a function that takes no inputs and returns a logical scalar 
% value. If this value is true, the function is deemed to have 'passed'. 
% If its result is false, the function 'failed'. If the function
% threw an error, it is considered to have 'crashed'. A report is
% generated in the command window.
%
% CHEBTEST by itself tries to find a directory named 'chebtests' in the
% directory in which chebtest.m resides.
%
% FAILED = CHEBTEST('DIRNAME') returns a cell array of all functions that
% either failed or crashed.

% Copyright 2002-2008 by The Chebfun Team. See www.comlab.ox.ac.uk/chebfun.

if nargin < 1
  % Attempt to find "chebtests" directory.
  w = which('chebtest.m');
  dirname = fileparts(w);
  dirname = fullfile(dirname,'chebtests');
end
  
if exist(dirname)~=7
  msg = ['The name "' dirname '" does not appear to be a directory on the path.'];
  error('chebfun:probe:nodir',msg)
end

dirlist = dir( fullfile(dirname,'*.m') );
mfile = {dirlist.name};

fprintf('\nTesting %i functions:\n\n',length(mfile))
failed = zeros(length(mfile),1);

addpath(dirname)
warnstate = warning;
warning off
for j = 1:length(mfile)
  
  fun = mfile{j}(1:end-2);
  link = ['<a href="matlab: edit ' dirname filesep fun '">' fun '</a>'];
  msg = ['  Function #' num2str(j) ' (' link ')... ' ];
  msg = strrep(msg,'\','\\');  % escape \ for fprintf
  numchar = fprintf(msg);
  
  try
    close all
    chebfunpref('factory');
    failed(j) = ~ all(feval( fun ));
    if failed(j)
      fprintf('FAILED\n')
    else
      fprintf('passed\n')
      pause(0.1)
      %fprintf( repmat('\b',1,numchar) )
    end
  catch
    failed(j) = -1;
    fprintf('CRASHED: ')
    msg = lasterror;  
    lf = findstr(sprintf('\n'),msg.message); 
    if ~isempty(lf), msg.message(1:lf(end))=[]; end
    fprintf([msg.message '\n'])
  end
  
end
rmpath(dirname)
warning(warnstate)
chebfunpref('factory');

if all(~failed)
  fprintf('\nAll tests passed!\n\n')
  if nargout>0, failfun = {}; end
else
  fprintf('\n%i failed and %i crashed\n\n',sum(failed>0),sum(failed<0))
  failfun = mfile(failed~=0);
end

end
