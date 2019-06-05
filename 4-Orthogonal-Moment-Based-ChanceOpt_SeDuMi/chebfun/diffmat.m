function D = diffmat(N)
% DIFFMAT  Chebyshev differentiation matrix.
% D = DIFFMAT(N) is the matrix that maps function values at N Chebyshev
% points to values of the derivative of the interpolating polynomial at
% those points. 
%
% Ref: Spectral Methods in MATLAB, L. N. Trefethen.

% Toby Driscoll, 12 May 2008.
% Copyright 2008.

N = N-1;  % to be compatible with SMM definitions
if N==0, D=0; return, end
x = sin(pi*(N:-2:-N)/(2*N))';
c = [2; ones(N-1,1); 2] .* (-1).^(0:N)';
X = repmat( x, [1,N+1] );
dX = X-X.';
D = (c*(1./c)') ./ (dX+eye(N+1));
D = D - diag(sum(D.'));
D = -D;   % left->right ordering, unlike SMM
