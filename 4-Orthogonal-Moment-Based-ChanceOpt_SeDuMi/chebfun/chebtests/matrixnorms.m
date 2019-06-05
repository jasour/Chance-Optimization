function pass = matrixnorms

% Nick Trefethen  31 May 2008
% This matrix should have all norms equal to 1

x = chebfun(1,[0 1]);
A = [0*x 0*x 0*x x 0*x];
norms = zeros(4,1);
norms(1) = norm(A,1);
norms(2) = norm(A,2);
norms(3) = norm(A,inf);
norms(4) = norm(A,'fro');
pass = (norm(norms-ones(4,1))==0);
