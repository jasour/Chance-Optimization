function pass = mathieu

% Periodic Mathieu functions
% Finds eigenvalues and the periodic eigenfunctions for
%
%   u'' = (2q cos(2x) + lambda)*u

q = 25;
d = domain(-pi,pi);
c = chebfun('cos(2*x)',d);
A = diff(d,2) - 2*q*diag(c);
A.bc = 'periodic';

lam = eigs(A,30);

% From MMA
exactA25 = [ -40.256779546566787276, -21.314899690665726935, -3.5221647271582959443, ...
12.964079444326467300, 27.805240580928440859, 40.050190985807711970, ...
48.975786716161850782, 57.534689001082872507, 69.524065165941372023, ...
85.076999881816530410, 103.23020480449483818, 123.64301237608357484,...
146.20769064280234639, 170.87371080831606219, 197.61116494244372124 ]';

pass = norm( -lam(1:2:end) - exactA25, Inf) < 1e-10;