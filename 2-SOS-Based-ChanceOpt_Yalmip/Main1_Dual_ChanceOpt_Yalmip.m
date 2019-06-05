%% SEMIDEFINITE PROGRAMMING FOR CHANCE CONSTRAINED OPTIMIZATION OVER SEMIALGEBRAIC SETS
% SIAM J. OPTIM. Vol. 25, No. 3, pp. 1411–1440
% ASHKAN. M. JASOUR, N. S. AYBAT, AND C. M. LAGOA

%% This code solves SDP on Polynomial Dual to the SDP in (3.7) on moments

%% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

clc;clear;close all
% order of polynomial P^d_A(a)and sos polynomials
d=10;d_sos=d;
% variables
sdpvar x q Beta
% polynomial P^d_W(a,x) with unknown coefficients coef
[P_W,coef] = polynomial([x,q],d);
% set K
K=0.5*q*(q^2+(x-0.5)^2)-(q^4+q^2*(x-0.5)^2+(x-0.5)^4); 
% set X
X=(x+1)*(1-x);
% sos polynomials
[s1,c1] = polynomial([x q],d_sos);
[s2,c2] = polynomial([x],d_sos);
% constraints of the SDP
F = [sos(P_W-1-[s1]*K), sos(s1), sos(P_W), sos(Beta-(1/2)*int(P_W,q,-1,1)-[s2]*X), sos(s2) ];
% mosek solver
ops = sdpsettings('solver','mosek');
[sol,v,Q]=solvesos(F, Beta,[],[c1;c2;Beta;coef]);
%% results
% obtained Beta 
OBeta=value(Beta);
% obtained polynomial P^d_w(a,x)
OP_W=sdisplay(v{3}'*Q{3}*v{3});
% obtained Integral of P^d_w(a,x)
syms q x;
Int_P_W=1/2*int(eval(cell2mat((OP_W))),q,-1,1);

%% Plots

% plot P^d_w(a,x)
O2P_W=strrep(strrep(OP_W,'*','.*'),'^','.^');
O3P_W=cell2mat((O2P_W));
[x,q]=meshgrid([-1:0.01:1],[-1:0.01:1]);
surf(x,q,eval(O3P_W),'FaceColor','red','FaceAlpha',0.85,'EdgeColor','none','FaceLighting','phong');hold on;grid on;
surf(x,q,ones(size(eval(O3P_W))),'FaceColor','blue','FaceAlpha',0.85,'EdgeColor','none','FaceLighting','phong')
axis tight;hidden off;ylabel('y');xlabel('x');hold on;xlim([-1,1]);ylim([-1,1]);zlim([0,3]);
h=legend('$\mathcal{P}^d_{\mathcal{W}}(x,q)$','$1$');set(h,'Interpreter','latex');set(gca,'fontsize',30);

% plot set K1
for x=0:0.05:1; for q=0:0.05:1
        if (0.5*q*(q^2+(x-0.5)^2)-(q^4+q^2*(x-0.5)^2+(x-0.5)^4)) >=0; plot3([x x],[q q],[0 1],'k-*');end
end;end
xlabel('$x$','Interpreter','latex', 'FontSize',31);ylabel('$q$','Interpreter','latex', 'FontSize',31)
str1 = '$ \mathcal{K} $';text(0.94,0.2,str1,'HorizontalAlignment','right','Interpreter','latex','FontSize',30) 

% plot Integral of P^d_W
figure
x=[-1:0.01:1];
plot(x,eval(Int_P_W),x,OBeta*ones(size(x)),'LineWidth',5);grid;hold on
plot(0.5*ones(1,6),[0:0.1:value(Beta)],'--','LineWidth',3); ylim([0 0.7])
h=legend('$\int \mathcal{P}^d_{\mathcal{W}}(x,q) d\mu_q$','$\beta$');h=set(h,'Interpreter','latex');
xlabel('$x$','Interpreter','latex', 'FontSize',31);set(gca,'fontsize',20)
str2 = '$ x^* =0.5 $';text(0.80,0.05,str2,'HorizontalAlignment','right','Interpreter','latex','FontSize',30)         
str3 = '$ \mathbf{P_d^*} = \beta $';text(0.80,0.55,str3,'HorizontalAlignment','right','Interpreter','latex','FontSize',30)  
