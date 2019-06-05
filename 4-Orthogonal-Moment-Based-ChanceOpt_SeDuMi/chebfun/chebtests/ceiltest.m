function pass = ceiltest

% Rodrigo Platte

f1 = chebfun(@(x) ceil(x), -10:2); % Prescribed brkpoints
f2 = chebfun(@(x) ceil(x), [-10 2]); 
pass = f1 == f2;