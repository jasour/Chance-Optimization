# Moment-Based Chance-Optimization


Matlab code for *Moment-Based Semidefinite Programming For Chance Optimization*.


**Description:**


Chance Optimization:  max_x Prob( q: p_j(x,q)>0, j=1,...l ), where "x" is a decision vector,  "q" is a random vector with given probability  distribution, and p_j are polynomials. In other words, x should be chosen such that the probability that random point (x,q) falls in to the semialgebraic set { (x,q) : p_j(x,q)>0, j=1,...l } becomes maximum. 
Provided Matlab code obtains the optimal values of the SDP in (3.7) which approximates the descibed chance optimization problem in (1.2), [1] 

**Matlab Packages:**

1) GloptiPoly 3.8 is used to solve SDP, http://homepages.laas.fr/henrion/software/gloptipoly

2) SDP solver: SeDuMi, Mosek, ...

**Instruction:**

Run *Main1_ChanceConstrained_GloptiPoly.m* and *Main2_ChanceConstrained_GloptiPoly_Ptilde.m*.
See *Example.pdf* for more information.



**Publications:**
 
 1) Ashkan M. Jasour, N. S. Aybat, and C. M. LagoaA
, "Semidefinite Programming For Chance Constrained Optimization Over Semialgebraic Sets", SIAM J. OPTIM. Vol. 25, No. 3, pp. 1411–1440.
https://epubs.siam.org/doi/pdf/10.1137/140958736

2) PhD Thesis, Ashkan M Jasour,"Convex Approximation of Chance Constrained Problems: Application in Systems and Control", School of Electrical Engineering and Computer Science, The Pennsylvania State University, 2016.
https://etda.libraries.psu.edu/catalog/13313aim5346

3) Ashkan Jasour, C. Lagoa, "Convex Constrained Semialgebraic Volume Optimization: Application in Systems and Control", (arXiv:1701.08910)
https://arxiv.org/abs/1701.08910

4) Ashkan Jasour, C. Lagoa, ”Semidefinite Relaxations of Chance Constrained Algebraic Problems”, 51st IEEE Conference on Decision and Control, Maui, Hawaii, 2012.
https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=6426305

