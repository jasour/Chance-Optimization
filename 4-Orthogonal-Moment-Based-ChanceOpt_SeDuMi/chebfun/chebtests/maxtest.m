function pass = maxtest

% Rodrigo Platte
% This used to crash because of double roots in sign.m

z = chebfun('x',[-1 1]);
y=max(abs(z),1-z.^2);
v=max(y,1);

pass = norm(v-1) == 0;