function varargout = chebfunpref(varargin)
% CHEBFUNPREF Settings for chebfuns.
%
% By itself, CHEBFUNPREF returns a structure with current preferences as
% fields/values. Use it to find out what preferences are available.
%
% CHEBFUNPREF(PREFNAME) returns the value corresponding to the preference
% named in the string PREFNAME.
%
% CHEBFUNPREF('factory') restore all preferences to their factory defined
% values.
%
% CHEBFUNPREF(PREFNAME,PREFVAL) sets the preference PREFNAME to the value
% PREFVAL. If PREFVAL is 'factory', PREFNAME is set to its factory defined
% value.
%
% CHEBFUNPREF creates a persistent variable that stores the these preferences.
% CLEAR ALL will not clear preferences, but quiting Matlab will.
%
% CHEBFUN PREFERENCES (case sensitive)
%
% minn - Minimum number of points used by the constructor. The contructed
%        fun or chebfun might be shorter as a result of the simplify
%        command. MUST BE 2^n+1 to conform with fun/growfun.
%        Factory value is 9.
%
% maxn - Maximum number of points used by the constructor in SPLITTING
%        OFF mode. Factory value is 2^16+1.
%
% nsplit - Maximum number of points used by the constructor in SPLITTING ON
%        mode. Note: 2^n+1 conforms with the way fun/growfun works.
%        Factory value is 129.
%
% splitting - Spliting option. Must be either true (1) or false (0).
%        Factory value is true.
%
% resample -  Resample option. Must be either true (1) or false (0).
%        Factory value is true.
%
% domain - Domain of definition of a chebfun. Factory definition is [-1 1].
%
% Examples
%       chebfunpref
%       chebfunpref('minn', 17)
%       chebfunpref('minn','factory')
%       chebfunpref('factory')
%
% See also SPLITTING, RESAMPLE
%

% Copyright 2002-2008 by The Chebfun Team. See www.comlab.ox.ac.uk/chebfun.

% persistent variables are known only to the function in which they are
% declared.
persistent prefs

% To speedup preference checks, try this first. 
% -----------------------------------------------
if nargin == 1
    try
        varargout{1} = prefs.(varargin{1});
        return
    catch
        % Move on to longer precess.
    end        
end        
% -----------------------------------------------

% If the above didn't work, go through the longer process:

% These are the options
options =    {'minn', 'maxn', 'nsplit', 'splitting', 'resample', 'domain'};
factoryvals = {9,     2^16+1,   129,     true,        true,      [-1 1]};

% Restore defaults ?
factory_flag = false;
if nargin == 1 && strncmpi(varargin{1},'factory',3)
    prefs = [];
    factory_flag = true;
elseif nargin>=1
    % Error catching ...
    [truepref, indpref] = ismember(varargin{1},options);
    if ~truepref
        error('CHEBFUN:chebfunpref:argin','unknown chebfun preference')
    end
end

% first call, set factory values
if isempty(prefs)
    
    for k = 1:length(factoryvals)
        prefs.(options{k}) = factoryvals{k};
    end
    
    mlock %locks the currently running M-file so that clear functions do not remove it.
          % Use munlock and clear chebfunpref if you edit this file.
end

% Assign output values
if nargin==0 || factory_flag
    varargout = { prefs };
elseif nargin==1 && not(factory_flag)
    varargout = { prefs.(varargin{1}) };
elseif nargin==2

    % Set preference to its factory value.
    if strncmpi(varargin{2},'factory',3)
        prefs.(options{indpref}) = factoryvals{indpref};
    else
        if ischar(varargin{2})
            error('CHEBFUN:chebfunpref:argin','invalid second argument')
        end

%         % If preference is 'minn', check for consistency!
%         if strcmp(varargin{1},'minn')
%             minn = varargin{2};
%             varargin{2} = max(2,2^floor(log2(minn-1))+1);
%         end

        % Set preference!
        prefs.(varargin{1}) = varargin{2};

    end

else
    error('CHEBFUN:chebfunpref:argin','Check number of input arguments.')
end

