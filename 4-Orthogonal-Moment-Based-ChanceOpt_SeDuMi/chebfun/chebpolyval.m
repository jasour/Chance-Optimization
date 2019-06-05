function v = chebpolyval(c)
%CHEBPOLYVAL   maps Chebyshev coefficients to values at Chebyshev points
%   CHEBPOLYVAL(C) returns the values of the polynomial 
%   P(x) = C(1)T_{N-1}(x)+C(2)T_{N-2}(x)+...+C(N) at Chebyshev nodes.
%               

% Copyright 2002-2008 by The Chebfun Team. See www.comlab.ox.ac.uk/chebfun.

c = c(:);       % input should be a column vector
lc = length(c);
if lc == 1, v = c; return; end
ii = 2:lc-1;
c(ii) = c(ii)/2;
v = [(c(end:-1:1)); c(ii)];
if isreal(c)
    v=real(ifft(v));
elseif isreal(1i*c)
    v=1i*real(ifft(imag(v)));
else
    v=ifft(v); 
end
v = (lc-1)*[2*v(1); (v(ii)+v(2*lc-ii)); 2*v(lc)];
v=flipud(v);