function pass = scaleinvariance

% LNT 20 May 2008
% This code makes sure a few things are scale-invariant.

d = [1 2];
scale = 2^300;
f = chebfun(@(x) exp(x),d);
maxf = max(f);

f1 = chebfun(@(x) exp(x*scale),d/scale);
pass1 = (max(f1)==maxf);

f2 = chebfun(@(x) exp(x/scale),d*scale);
pass2 = (max(f2)==maxf);

f3 = chebfun(@(x) exp(x)*scale,d);
pass3 = (max(f3)==maxf*scale);

f4 = chebfun(@(x) exp(x)/scale,d);
pass4 = (max(f4)==maxf/scale);

pass = pass1 && pass2 && pass3 && pass4;


