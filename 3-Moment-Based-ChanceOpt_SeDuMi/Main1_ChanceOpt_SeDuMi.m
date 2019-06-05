%% SEMIDEFINITE PROGRAMMING FOR CHANCE CONSTRAINED OPTIMIZATION OVER SEMIALGEBRAIC SETS
% SIAM J. OPTIM. Vol. 25, No. 3, pp. 1411–1440
% ASHKAN. M. JASOUR, N. S. AYBAT, AND C. M. LAGOA

%% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

%% This code obtains the optimal values of the SDP in (3.7)
%  which approximates the chance optimization problem in (1.2)
%  e.q, Find x such that Probability of set P={ q : p_j(x,q)>0, j=1,...l } becomes maximum 
%       where q: random variable with probability distribution muq. 
% In other words, x should be chosen such that the probability of the 
% random point (x,q) belonging to set P={ (x,q) : p_j(x,q)>0, j=1,...l } becomes maximum.

%% To use SeDuMi problem in (3.7) is reformulated as min b*x; s.t A*x<=c

%% To be able to extract the coefficients and degrees of given polynomial p, the variable type "pvar" and commands
% p.coef, p.deg from SOSTOOLS toolbox v3.00 is used. 
% http://www.cds.caltech.edu/sostools

%%
clc;clear all;

%%
%% Problem Parameters
d =2; % relaxation order
nx =1;% number of decision variables : x
nq= 1;% number of uncertain parameters : q

%% Varibailes (qi,i=1,...,nq) & (xi,i=1,...,nx), variable Vector: var
var=[];
for i=1:nx; eval(['pvar q',num2str(i),' real']); var=[var eval(['q',num2str(i)]) ]; end
for i=1:(nx+nq)-nx; eval(['pvar x',num2str(i),' real']); var=[var eval(['x',num2str(i)]) ]; end

%% semialgebraic set P ={ p_j(x,q)>0, j=1,...l }
P = [0.5*q1*(q1^2+(x1-0.5)^2)-(q1^4+q1^2*(x1-0.5)^2+(x1-0.5)^4); 
    0.3^2- (x1-0.5)^2 - (q1-0.4)^2];

%%
% all power of monomials [x^j q^i] up to degree 2d 
vpow2d=[]; for k = 0:2*d ; vpow2d = [vpow2d;genpow((nx+nq),k)]; end 
% all power of monomials [x^j q^i] up to degree d 
vpowd=[]; for k = 0:d ; vpowd = [vpowd;genpow((nx+nq),k)]; end
% all power of monomials [x^j] up to degree d 
vpowdx=[]; for k = 0:d ; vpowdx = [vpowdx;genpow(nx,k)]; end

% number of moments of measure mu supported on x-q space
Ny=factorial((nx+nq)+1*d)/(factorial(1*d)*factorial((nx+nq)));
% number of moments of measure mu_x supported on x space
Nx=factorial(nx+1*d)/(factorial(1*d)*factorial(nx));

% dimension of moment matrix of measure mu
Nmy=factorial((nx+nq)+2*d)/(factorial(2*d)*factorial((nx+nq)));
% dimension of moment matrix of measure mu_x
Nmx=factorial(nx+2*d)/(factorial(2*d)*factorial(nx));

%% A_y : each row of A_y contains an element of moment matrix of measure mu stated in terms of moment vector mv=[y,yx]; 
%  A_x : each row of A_x contains an element of moment matrix of measure mux stated in terms of moment vector mv=[y,yx];
%  A_x1: each row of A_xy contains an element of moment matrix of measure (mux*muq) stated in terms of moment vector mv=[y,yx];
% for example:
%  moments vector of measure mu and mux mv= [y00 y10 y01 y20 y11 y02, yx0 yx1 yx2] 
%  given moments of measure muq [yq0 yq1 yq2]
%  moment matirx of measure mu, mux, and (mux*muq-mu):
%
%           M(y)=[y00 y10 y01;    M(yx)=[yx0  yx1;     M(yx,yq)=[yx0yq0 yx1yq0 yx0yq1; - M(y)
%                 y10 y20 y11;           yx1   yx2];            yx1yq0  yx2yq0 yx1yq1;
%                 y01 y11 y02];                                 yx0yq1  yx1yq1 yx0yq2]
%
% A_y=[1 0 0 0 0 0 0 0 0 ;       A_x=[0 0 0 0 0 0 1 0 0 ;    A_xq=[0 0 0 0 0 0  yq0  0  0 ;  - A_y
%      0 1 0 0 0 0 0 0 0 ;            0 0 0 0 0 0 0 1 0 ;          0 0 0 0 0 0  0  yq0  0 ;
%      0 0 1 0 0 0 0 0 0 ;            0 0 0 0 0 0 0 1 0 ;          0 0 0 0 0 0  yq1  0  0 ;
%      0 1 0 0 0 0 0 0 0 ;            0 0 0 0 0 0 0 0 1 ];         0 0 0 0 0 0  0  yq0  0 ;
%      0 0 0 1 0 0 0 0 0 ;                                         0 0 0 0 0 0  0  0   yq0;
%      0 0 0 0 1 0 0 0 0 ;                                         0 0 0 0 0 0  0  yq1  0 ;
%      0 0 1 0 0 0 0 0 0 ;                                         0 0 0 0 0 0  yq1  0  0 ;
%      0 0 0 0 1 0 0 0 0 ;                                         0 0 0 0 0 0  0  yq1  0 ;
%      0 0 0 0 0 1 0 0 0 ];                                        0 0 0 0 0 0  yq2  0  0 ];

disp('generate A_y, A_x, and A_xq for moment matrices')

% yq_i: given moments of measure muq_i, i=1,...,nq
% moments of uniform distribution on [-1,1]
yq_1=[1];for i=1:2*d ;yq_1(i+1,1)=(1/2)*(((1)^(i+1) - (-1)^(i+1))/(i+1));end
% yq=[yq_1,yq_2,...,yq_nq]
yq=[];for i=1:nq; yq=[yq,yq_1]; end

[Yq]=MomentIndexYq((nx+nq),nx,yq,vpow2d);
[AMy,AMx,AMup]=MomentIndex(Yq,nx,vpowd,vpowdx);

A_y=[AMy,zeros(size(AMy,1),Nmx)];
A_x=[zeros(size(AMx,1),Nmy),AMx(:,1:end)];
A_xq=[zeros(size(AMup,1),Nmy),AMup(:,1:end)]-A_y;


%% AL_y : each row of AL_y contains an element of localization matrix of measure mu stated in terms of moment vector mv=[y,yx]; 

disp('generate AL_y for localization matrices')

AL_y=[];NLy=[];
for i=1:size(P,1)
clear p pc
% extract the coefficients and powers vector of polynomial
pt=1000*prod(var.^1000);
pc= P(i);
p = pc + pt;
% Cc1: Coefficents vector
Cpc1=p.coef; Cc1=0+Cpc1(2:end,:);  
% Dc1: Degree vector: [i j] for x^i q^j
Dpc1=p.deg;  Dc1=0+Dpc1(2:end,:); Dc1=[Dc1(:,nq+1:end),Dc1(:,1:nq)];
% relaxation order of localization matrix
d1=floor(abs(2*d- max(sum(Dc1,2)) )/2);
% dimension of localization matrix
nly=factorial((nx+nq)+1*d1)/(factorial(1*d1)*factorial((nx+nq)));

[ALMy]=LMomentIndex(Dc1,Cc1,Nmy,nly,d1);
al_y=[ALMy,zeros(size(ALMy,1),Nmx)];
AL_y=[AL_y;al_y];
% vector of dimension of all localization matrices
NLy=[NLy,nly];
end

%% || yx || <= 1
% e.g. moments vector of measure mu and mux mv= [y00 y10 y01 y20 y11 y02, yx0 yx1 yx2] 
% AL1_x=[0 0 0 0 0 0 1 0 0 ;   AL2_x=[0 0 0 0 0 0 -1 0 0 ;  
%        0 0 0 0 0 0 0 1 0 ;          0 0 0 0 0 0 0 -1 0 ;            
%        0 0 0 0 0 0 0 0 1 ];         0 0 0 0 0 0 0 0 -1 ];          


disp('generate AL_x for localization matrices')

AL1_x=[zeros(Nmx,Nmy),eye(Nmx)];
NLx1 =ones(1,Nmx);

AL2_x=[zeros(Nmx,Nmy),-eye(Nmx)];
NLx2 =ones(1,Nmx);

%% SeDuMi:  min b*x; s.t A*x<=c

A=[-A_y;-AL_y;-A_x;-A_xq;-AL1_x;-AL2_x];
b=[1;zeros(Nmy+Nmx-1,1)];
c=[zeros(size(A_y,1),1);zeros(size(AL_y,1),1);zeros(size(A_x,1),1);zeros(size(A_xq,1),1);ones(Nmx,1);ones(Nmx,1)];


K.f=[];
% dimension of all matrices and constraints
K.s=[Ny,NLy,Nx,Ny,NLx1,NLx2];
pars = [];
pars.fid = 0;
clc;disp('start')
% y: obtained moment vector [y,yx];
[x,y,info] = sedumi(A,b,c,K,pars);

info
%% Results
% obtained moments of measure mu
Y=y(1:Nmy);
% obtained moments of measure mux
Yx1= [y(Nmy+1:Nmy+Nmx)];
% estimated probability
Probailty =Y(1); 
% estimated decision variables x
DecisionX = Yx1(2:1+nx); 

fprintf('\n\n Probailty = %f  ',Probailty);
fprintf('\n Decision Var x = %f \n\n' ,DecisionX);