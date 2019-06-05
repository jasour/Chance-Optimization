function pass = adaptapply

d = domain(0,2);
x = chebfun('x',d);
f = sin(exp(2*x));
g = x.^3-cos(x);

% Operator mode
F = diag(f);
pass(1) = norm( F*g - f.*g ) < eps;

% Apply mode
F = chebop( @(n) diag( f(1-cos(pi*(0:n-1)/(n-1)))), [], d, 0);
pass(2) = norm( F*g - f.*g ) < 1e-13;