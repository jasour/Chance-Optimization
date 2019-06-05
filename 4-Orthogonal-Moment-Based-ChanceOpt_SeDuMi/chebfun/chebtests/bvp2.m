function pass = bvp2

d = domain(-1,0);
D = diff(d);  I = eye(d);
A = D*D + 4*D + 200;
A.lbc = {D+2,1};
A.rbc = D;
f = chebfun( 'x.*sin(3*x).^2',d );
u = A\f;
du = diff(u);

pass = norm( diff(u,2) + 4*diff(u) + 200*u - f ) < 1e-10;
pass = pass && ( abs(du(d(1))+2*u(d(1))-1)<1e-11 );
pass = pass && ( abs(feval(diff(u),d(2)))<1e-11 );



