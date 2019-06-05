function pass = orthosincos

% TAD

S = []; C = [];
for n = 1:5
  S = [S chebfun(@(x) sin(n*x),[0 2*pi])];
  C = [C chebfun(@(x) cos(n*x),[0 2*pi])];
end
ip = S'*C;
pass = norm(ip) < 100*eps;

end
