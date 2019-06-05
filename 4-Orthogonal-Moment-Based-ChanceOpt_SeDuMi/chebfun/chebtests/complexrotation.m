function pass = complexrotation

% LNT 20 May 2008
% This code makes sure a few things are ok if you make them complex

f = chebfun(@(x) exp(x));
fi = chebfun(@(x) 1i*exp(x));
g = chebfun('1./(2-x)');
gi = chebfun('1i./(2-x)');
A = [f g];

pass1 = (sum(fi)==1i*sum(f));
pass2 = norm(fi)==norm(f);
pass3 = abs((f'*g)-((1i*f)'*(1i*g))) < 1e-15;
pass4 = (norm(gi,inf)-norm(g,inf)) < 1e-15;
pass5 = (norm(fi,1)-norm(f,1)) < 1e-15;
pass6 = norm(svd(A) - svd(1i*A)) < 1e-15;

pass = pass1 && pass2 && pass3 && pass4 && pass5 && pass6;


