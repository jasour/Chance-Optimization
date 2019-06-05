function pass = ivp1

d = domain(-1,1);
x = chebfun(@(x)x,d);
I = eye(d);
D = diff(d);
A = (D-I) & {'dirichlet',exp(-1)-1};
u = A\(1-x);

pass = norm( u - (exp(x)+x) ) < 100*eps;
