function pass = systemtest1

% Test solution of a 2x2 system
% TAD

d=domain(-1,1);
D=diff(d);
I=eye(d);
Z=zeros(d);
A=[D+I 2*I;D-I D];
x=d(:);
f=[ exp(x) chebfun(1,d) ];
A.lbc = [I+D Z];
A.rbc = [Z D];
u = A\f;

u1 = u(:,1); u2 = u(:,2);
pass(1) = norm( diff(u1)+u1+2*u2-exp(x)) < 1e-12;
pass(2) = norm( diff(u1)-u1+diff(u2)-1 ) < 1e-12;
