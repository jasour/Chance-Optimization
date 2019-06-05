function pass = smallintervals
% Operations on small intervals
% Rodrigo Platte, July 2008.

f1 = chebfun(@(x) x,[-1 -1+eps/2 0]);
f2 = chebfun(@(x) x,[-1 -eps/2 0]);
f3 = chebfun(@(x) x.^2, [-1 0]);

pass = f1.*f2 == f3;

f2 = chebfun(@(x) x, [-1 -1+eps 0]);
pass = pass && f1.*f2 == f3;

h = chebfun(@(x) 1-abs(x));
f = conv(h,conv(h,h));
pass = pass && all(f.ends==(-3:3));