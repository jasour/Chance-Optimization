function pass = cumsumcos100x

% Rodrigo Platte

f = chebfun('cos(100*x)',[10 13]);
fint = chebfun('sin(100*x)/100',[10 13])-sin(1000)/100;

% real
pass = norm(cumsum(f)-fint) < 1e-13*f.scl;

%imaginary
pass = pass && norm(cumsum(f*1i)-1i*fint,inf) < 1e-13*f.scl;

