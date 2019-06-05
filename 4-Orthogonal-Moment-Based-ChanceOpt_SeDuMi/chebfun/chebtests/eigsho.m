function pass = eigsho

d = domain(0,pi);
A = diff(d,2) & 'dirichlet';
lam = eigs(A,10);
k = sqrt(-lam);

pass = norm( k - (1:10)', Inf ) < 1000*eps; 



