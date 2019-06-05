function pass = grammatrix

% TAD

A = chebfun;
x = chebfun(@(x) x,domain(0,1));
for n=1:4
  A(:,n) = x.^(n-1);
end
G = A'*A;
pass = norm(G-hilb(4)) < 10*eps;

end
