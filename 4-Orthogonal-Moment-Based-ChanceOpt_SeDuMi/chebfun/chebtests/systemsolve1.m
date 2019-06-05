function pass = systemtest0

% Test 2x2 system (sin/cos)
% TAD

d=domain(-pi,pi);
D=diff(d);
I=eye(d);
Z=zeros(d);
A=[I -D; D I];
x=d(:);
f=[ 0*x 0*x ];
A.lbc = {[I Z],-1};
A.rbc = [Z I];
u = A\f;

u1 = u(:,1); u2 = u(:,2);
pass(1) = norm( u1 - cos(x)) < 100*eps;
pass(2) = norm( u2 - sin(x) ) < 100*eps;
