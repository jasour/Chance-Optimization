function pass = applydiffop

d = domain(-3,-1.5);
D = diff(d);
f = chebfun(@(x) exp(sin(x).^2+2),d);
pass = norm(D*f - diff(f)) < eps;
