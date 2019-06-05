function pass = rootspol
% Roots of a perturbed polynomial
% Rodrigo Platte, July 2008.

p = chebfun( '(x-.1).*(x+.9).*x.*(x-.9) + 1e-14*x.^5' );
r = roots(p);

pass = length(r)==4 && norm(p(r),inf)<1e-13;