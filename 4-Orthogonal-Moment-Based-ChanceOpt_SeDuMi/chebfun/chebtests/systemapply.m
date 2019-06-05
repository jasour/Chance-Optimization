function pass = systemapply

% Test 2x2 systems applied to functions.
% TAD

d=domain(-pi,pi);
D=diff(d);
I=eye(d);
Z=zeros(d);
A=[I+2*D^2 -D; D Z];
B = A^2;
x=d(:);
u=[ sin(x) exp(x) ];

v = A*u;
w = A*v;
z = (B+3)*u;

u1 = u(:,1); u2 = u(:,2);
pass(1) = norm( v(:,1) - (u1+2*diff(u1,2)-diff(u2))) < eps;
pass(2) = norm( v(:,2) - (diff(u1))) < eps;
pass(3) = norm( w - B*u ) < 1e-10;
pass(4) = norm( z - w - 3*u ) < 1e-10;

end