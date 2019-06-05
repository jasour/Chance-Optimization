function pass = systemexpm

% Exponential test, inspired by Maxwell's equation
% TAD

d = domain(-1,1);
dt = 0.6;
sigma = 0.75;  % conductive attenuation

D = diff(d); I = eye(d); Z = zeros(d);
A = [ -sigma*I D;D Z ];
A.lbc = [I Z];
A.rbc = [I Z];

x = d(:);
f = exp(-20*x.^2) .* sin(30*x);
EH = [ f -f ];

% for n = 0:5
%   subplot(2,3,n+1)
%   plot( expm(n*dt*A & A.bc)*EH ), 
%   axis([-1 1 -1.25 1.25])
%   title(['t = ' num2str(n*dt)])
% end

u = expm(dt*A & A.bc)*EH;

% This is just taken from a stable version of chebops. Verify?
ucorrect = [
  -0.003493712804296   0.003507424266860
   0.017400438776808  -0.017569666673771
  -0.053993725617065   0.055047201484183
   0.098797781796113  -0.102583796707936
  -0.089121824015245   0.097254823360030
  -0.004069253343800  -0.006433053771176
   0.095392325253247  -0.087321637402261
  -0.101288249878077   0.098387426546698
   0.051307419712737  -0.057244515064558
];

pass = norm(u(0.1:0.1:0.9,:)-ucorrect,inf) < 1e-12;
