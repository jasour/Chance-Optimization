function pass = pointevals

% LNT 20 May 2008
% This code makes sure point evaluations are working

f = chebfun(@(x) sign(x-1),[0 2]);
pass1 = (f(1+eps) == 1);
pass2 = (f(1-eps) == -1);
pass3 = (f(1) == 0);
f(1) = 3;
f(1.5) = 4;
pass4 = (f(1) == 3);
pass5 = (f(1.5) == 4);
pass6 = (sum(f) == 0);
pass = pass1 && pass2 && pass3 && pass4 && pass5 && pass6;
