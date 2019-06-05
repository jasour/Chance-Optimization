function [ALMy]=LMomentIndex(Dc,Cc,Nmy,NLy,d1)

% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

ALMy=zeros(NLy*NLy,Nmy);
n2=size(Dc,2);
vpow=[];
for k = 0:d1
    vpow = [vpow;genpow(n2,k)];
end

for i=1:size(vpow,1)   
    for j=1:i
        clc;disp({'LM',j,i,size(vpow,1)})
        a=vpow(i,:)+vpow(j,:);

        for k=1:size(Dc)
        ALMy( (i-1)*size(vpow,1)+j , glex2num(a+Dc(k,:)) ) = Cc(k);
        ALMy( (j-1)*size(vpow,1)+i , glex2num(a+Dc(k,:)) ) = Cc(k);
        end

    end
end