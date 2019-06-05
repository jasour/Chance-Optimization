function pass = subspacetest
% test the subspace function (angle between subspaces). Also calls vander.m
% Rodrigo Platte, October 2008.

[d,theta] = domain(0,2*pi);

A = [vander(exp(-i*theta), 3) vander(exp(i*theta), 3)];
B = [cos(5*theta) sin(10*theta)];

angle = subspace(A,B);
% Note only single precision can be expected here because of the
% singularity of asin(x) at x=1.
pass = abs(angle - pi/2)< 1e-7;

angle = subspace(A,sin(2*theta));
pass = pass && (angle < 1e-14);