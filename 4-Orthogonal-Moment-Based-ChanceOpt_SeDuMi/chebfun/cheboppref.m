function varargout = cheboppref(varargin)
% CHEBOPPREF Settings for chebops.
%
% By itself, CHEBOPPREF returns a structure with current preferences as
% fields/values. Use it to find out what preferences are available.
%
% CHEBOPPREF(PREFNAME) returns the value corresponding to the preference
% named in the string PREFNAME.
%
% CHEBOPPREF(PREFNAME,PREFVAL) sets the preference PREFNAME to the value
% PREFVAL.


% Toby Driscoll, 31 March 2008.

persistent prefs

if isempty(prefs)  % first call, default values
  prefs.storage = true;
  prefs.maxstorage = 50e6;
end

% Probably should use some nicer error catching...
if nargin==0
  varargout = { prefs };
elseif nargin==1
  varargout = { prefs.(varargin{1}) };
else
  prefs.(varargin{1}) = varargin{2};
end
