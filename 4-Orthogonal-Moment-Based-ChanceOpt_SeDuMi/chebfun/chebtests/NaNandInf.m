function pass = NaNandInf

% Rodrigo Platte

% If an evaluation returns NaN or Inf, the constructro should give an error
% message!

splitting off
% NaN
pass1 = false;
try 
    chebfun(@(x) x.^6.*sin(1./x.^2),[-1 1]);
catch
    pass1 = true;
end

% Inf
pass2 = false;
try 
    chebfun(@(x) log(x+1));
catch
    pass2 = true;
end

splitting on

% NaN
pass3 = false;
try 
    chebfun(@(x) x.^6.*sin(1./x.^2),[-1 1]);
catch
    pass3 = true;
end

% Inf
pass4 = false;
try 
    chebfun(@(x) log(x+1));
catch
    pass4 = true;
end


pass = pass1 && pass2 && pass3 && pass4;

chebfunpref factory;