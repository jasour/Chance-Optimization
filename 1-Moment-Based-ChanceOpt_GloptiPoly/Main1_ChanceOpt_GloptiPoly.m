%% SEMIDEFINITE PROGRAMMING FOR CHANCE CONSTRAINED OPTIMIZATION OVER SEMIALGEBRAIC SETS
% SIAM J. OPTIM. Vol. 25, No. 3, pp. 1411–1440
% ASHKAN. M. JASOUR, N. S. AYBAT, AND C. M. LAGOA

%% This code obtains the optimal values of the SDP in (3.7)
%  which approximates the chance optimization problem in (1.2)
%  e.q, Find x such that Probability of set { q : p_j(x,q)>0, j=1,...l } becomes maximum 
%       where q: random variable with probability distribution muq. 
% In other words, x should be chosen such that the probability of the 
% random point (x,q) belonging to set { (x,q) : p_j(x,q)>0, j=1,...l } becomes maximum.

%% GloptiPoly 3.8 is used to solve SDP
% http://homepages.laas.fr/henrion/software/gloptipoly
% SDP solver: SeDuMi, Mosek, ...
%% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

%%
clc;clear;clear all; 

%% Problem Parameters
d =2; % relaxation order
nx =1;% number of decision variables : x
nq= 1;% number of uncertain parameters : q

%%
%% ***********************************************************************

% mu_s: slack measure, mu_s = mux*muq - mu, y s: moments of mu s
mpol('x_s',nx); mpol('q_s',nq); mu_s = meas([x_s;q_s]); y_s=mom(mmon([x_s;q_s],2*d));

% mu: measure supported on p_j>=0 j=1,...l, y: moments of mu
mpol('x',nx); mpol('q',nq); mu = meas([x;q]); y=mom(mmon([x;q],2*d)); 

% semi Algebraic Set P ={ p_j(x,q)>0, j=1,...l }
P=[0.5*q(1)*(q(1)^2+(x(1)-0.5)^2)-(q(1)^4+q(1)^2*(x(1)-0.5)^2+(x(1)-0.5)^4);
0.3^2- (x(1)-0.5)^2 - (q(1)-0.4)^2];

% mux: measure, yx: moments of mux
mpol('xm',nx);mux= meas([xm]); yx=mom(mmon([xm],2*d)); 

% yq_i: given moments of measure muq_i, i=1,...,nq
% moments of uniform distribution on [-1,1]
yq_1=[1];for i=1:2*d ;yq_1(i+1,1)=(1/2)*(((1)^(i+1) - (-1)^(i+1))/(i+1));end 
% yq=[yq_1,yq_2,...,yq_nq]
yq=[];for i=1:nq; yq=[yq,yq_1]; end

% yxq: moments of cross product measure mux*muq
% muq = muq_1*muq_2*...*muq_nq (independent measures)
vpow=[];for k = 0:2*d; vpow = [vpow;genpow(nx+nq,k)]; end
Yx=[];
for i=1:size(vpow,1)
Yx=[Yx;glex2num([vpow(i,1:nx)])];
Yq(i,:)=1; for j=1:nq; Yq(i,:)=Yq(i,:)*yq(vpow(i,nx+j)+1,j); end
end
yxq=yx(Yx).*Yq; 

%% Optimization
mset('yalmip',true);mset(sdpsettings('solver','mosek')); % Calls mosek SDP solver through Yalmip
%mset(sdpsettings('solver','sedumi'))

Opt=msdp(max(mass(mu)),mass(mux)==1,P>=0,y_s==(yxq - y),-1<=yx,yx<=1,d);
msol(Opt);

%% Results
% moments of measure mu
y=double(mvec(mu)); 
% moment matrix of measure mu
M=double(mmat(mu)); 
% moments of measure mux
yx=double(mvec(mux)); 
% moment matrix of measure mux
Mx=double(mmat(mux)); 
% obtained probability
Probailty =y(1); 
% obtained decision variables x
DecisionX = yx(2:1+nx); 

disp('Probailty:');Probailty
disp('Decision parameter x:');DecisionX

