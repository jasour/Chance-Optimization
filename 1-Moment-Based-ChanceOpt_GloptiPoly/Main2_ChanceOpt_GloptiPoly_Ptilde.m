%% SEMIDEFINITE PROGRAMMING FOR CHANCE CONSTRAINED OPTIMIZATION OVER SEMIALGEBRAIC SETS
% SIAM J. OPTIM. Vol. 25, No. 3, pp. 1411–1440
% A. M. JASOUR, N. S. AYBAT, AND C. M. LAGOA

%% P^tilde: The optimal value of the SDP relaxation for the volume problem in (3.12) with relaxation order d.
% In fact, this code obtaines the "Improved Estimation" of Probability of a set { q : p_j(x,q)>0,j=1,...l } for
% a given point x = xd where q is random variable with probability distribution muq. 

%% GloptiPoly 3.8 is used to solve SDP
% http://homepages.laas.fr/henrion/software/gloptipoly
% http://homepages.laas.fr/henrion/software/gloptipoly
% SDP solver: SeDuMi, Mosek,...
%% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

%%
clc;clear all;
%%
d= 5; % Relaxatio Order
nq = 1; % number of uncertain parameters : q
xd = 0.5; % Optimal Point
 
%% 
% mu_tilde: measure supported on p_j(xd)>=0 j=1,...l, y_tilde: moments of mu_tilde
mpol('q',nq); mu_tilde = meas(q); y_tilde = mom(mmon(q,2*d));
% mu_s: slack measure, mu_s =muq - mu_tilde, y_s: moments of mu_s
mpol('q_s',nq); mu_s = meas(q_s); y_s = mom(mmon(q_s,2*d));

% semi Algebraic Set P ={ p_j(xd,q)>0, j=1,...l }
x=xd;
P=[0.5*q(1)*(q(1)^2+(x(1)-0.5)^2)-(q(1)^4+q(1)^2*(x(1)-0.5)^2+(x(1)-0.5)^4);
0.3^2- (x(1)-0.5)^2 - (q(1)-0.4)^2];

% yq_i: given moments of measure muq_i, i=1,...,nq
% moments of uniform distribution on [-1,1]
yq_1=[1];for i=1:2*d ;yq_1(i+1,1)=(1/2)*(((1)^(i+1) - (-1)^(i+1))/(i+1));end 
% yq=[yq_1,yq_2,...,yq_nq]
yq=[];for i=1:nq; yq=[yq,yq_1]; end

%Yq: moments of measure muq = muq_1*muq_2*...*muq_nq (independent measures)
vpow=[];for k = 0:2*d; vpow = [vpow;genpow(nq,k)];end
Yq=1; for i=1:nq; Yq=Yq.*yq(vpow(:,i)+1,i); end

%% optimization
mset('yalmip',true);mset(sdpsettings('solver','mosek')); % Calls mosek SDP solver through Yalmip
%mset(sdpsettings('solver','sedumi'))
Opt = msdp(max(prod(P)), P>=0, y_s==Yq-y_tilde,d); 
msol(Opt); 

%% Results
% moments of measure mu_tilde
y_tilde = double(mvec(mu_tilde)); 
% obtained probability of ponit xd
P_prime=y_tilde(1);

disp('Probailty:');P_prime

