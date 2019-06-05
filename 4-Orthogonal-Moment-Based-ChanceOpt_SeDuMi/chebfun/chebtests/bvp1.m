function pass = bvp1

d = domain(-3,4);
D = diff(d);  I = eye(d);
A = D*D + 4*D + I;
A.lbc = -1;
A.rbc = 'neumann';
f = chebfun( 'exp(sin(x))',d );
u = A\f;

pass = norm( diff(u,2) + 4*diff(u) + u - f ) < 1e-10;
pass = pass && ( abs(u(d(1))+1)<1e-12 );
pass = pass && ( abs(feval(diff(u),d(2)))<1e-11 );



