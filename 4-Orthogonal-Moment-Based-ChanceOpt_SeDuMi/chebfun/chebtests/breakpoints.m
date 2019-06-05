function pass = breakpoints

% Rodrigo Platte

f=chebfun(@(x) ceil(x-.1), [0 1 2]);
pass = length(f)==4;

f=chebfun(@(x) ceil(x-.1));
pass = pass & length(f) == 3;


