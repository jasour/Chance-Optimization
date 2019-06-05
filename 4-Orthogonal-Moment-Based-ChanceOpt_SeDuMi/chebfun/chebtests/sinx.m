function pass = sinx

% Rodrigo Platte
% Tests for uniform splitting (bisection)
% ends must be equispaced.

f = chebfun(@(x) sin(x), [0 1e4]);
pass = all(diff(diff(f.ends)) == 0);