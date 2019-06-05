function pass = convspline

B = (1/6)*chebfun( {'(2+x)^3','1+3*(1+x)+3*(1+x)^2-3*(1+x)^3',...
  '1+3*(1-x)+3*(1-x)^2-3*(1-x)^3','(2-x)^3'}, -2:2 );

s = chebfun(1,[-.5 .5]);
f = s;
for k = 1:3, f = conv(f,s); end

pass = norm( f-B ) < 1e-14;

end