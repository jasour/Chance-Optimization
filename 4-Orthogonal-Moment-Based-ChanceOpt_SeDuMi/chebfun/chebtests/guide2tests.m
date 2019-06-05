
function pass = guide2tests

% LNT 25 May 2008
% Various tests from chapter 2 of the Chebfun Guide.

  splitting on

  f = chebfun('log(1+tan(x))',[0 pi/4]);
  I = sum(f); Iexact = pi*log(2)/8;
  err1 = I-Iexact; pass1 = err1<1e-15;

  f = chebfun('sin(sin(x))',[0 1]);
  I = sum(f); Iexact = 0.4306061031206906049;
  err2 = I-Iexact; pass2 = err2<1e-15;

  t = chebfun('t',[0,1]);
  f = 2*exp(-t.^2)/sqrt(pi);
  I = sum(f); Iexact = erf(1);
  err3 = I-Iexact; pass3 = err3<1e-15;

  f = chebfun(@(x) abs(besselj(0,x)),[0 20]);
  I = sum(f); Iexact = 4.4450316030016;
  err4 = I-Iexact; pass4 = err4<1e-13;

  x = chebfun('x');
  f = sech(3*sin(10*x));
  g = sin(9*x); h = min(f,g);
  I = sum(h); Iexact = -0.38155644885025;
  err5 = I-Iexact; pass5 = err5<2e-15;

  splitting off
  x = chebfun('x',[0 1]);
  f = sech(10*(x-0.2)).^2 + sech(100*(x-0.4)).^4 + sech(1000*(x-0.6)).^6;
  I = sum(f); Iexact = 0.210802735500549;
  err6 = I-Iexact; pass6 = err6<1e-15;

  splitting on
  f = sech(10*(x-0.2)).^2 + sech(100*(x-0.4)).^4 + sech(1000*(x-0.6)).^6;
  I = sum(f);
  err7 = I-Iexact; pass7 = err7<1e-14;

  pass = pass1 && pass2 && pass3 && pass4 && pass5 && pass6 && pass7;
