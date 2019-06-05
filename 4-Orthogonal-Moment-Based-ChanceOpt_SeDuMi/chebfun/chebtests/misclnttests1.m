
function pass = misclnttests1

% LNT 24 May 2008
% This code fools around in various ways

pass1 = (sum(chebfun(1,2,3,4,5,0:5))==15);
pass2 = (sum(chebfun(1,1,2i,-2,-1i,-1i,0:6))==0);
x = chebfun('t',[1 2]);
n1 = norm(sin(x).^2+cos(x).^2-1);
pass3 = (n1<1e-15);
n2 = norm(sin(1i*x).^2+cos(1i*x).^2-1);
pass4 = (n2<1e-14);

pass = pass1 && pass2 && pass3 && pass4;
