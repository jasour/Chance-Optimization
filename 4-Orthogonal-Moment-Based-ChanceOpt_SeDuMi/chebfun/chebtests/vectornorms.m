function pass = vectornorms

% Nick Trefethen  27 October 2008

f = chebfun(1,2,0:4:8);
norms(1) = norm(f,1);
norms(2) = norm(f,2);
norms(3) = norm(f,inf);
norms(4) = norm(f,'fro');
norms(5) = norm(f',1);
norms(6) = norm(f',2);
norms(7) = norm(f',inf);
norms(8) = norm(f','fro');
s = sqrt(20);
exact = [12 s 2 s 12 s 2 s];
pass = (norm(norms-exact,inf) < 1e-14);
