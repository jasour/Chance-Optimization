function pass = sumcos20x

% TAD

f = chebfun('cos(20*x)');
pass = abs(sum(f)-sin(20)/10) < 1e-15;

% RodP
pass = pass && abs(sum(f*1i)-1i*sin(20)/10) < 1e-15;

