function pass = circplate
% Deflection of a circular plate

d = domain(0,1);
f = chebfun('exp(-50*r)',d);  % loading function

r = chebfun('r',d);
D = diff(d);  I = eye(d);
B = diag(r.^3)*D^4 + diag(2*r.^2)*D^3 - diag(r)*D^2 + D;  % r^3*(biharm)

B.lbc(1)=D; B.lbc(2)=D^3;   % symmetry at origin
B.rbc(1)=I; B.rbc(2)=D;     % clamped at boundary

u1 = B\(r.^3.*f);
load circplate

pass = norm(u-u1) < 1e-10;