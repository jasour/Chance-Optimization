function [Yq]=MomentIndexYq(nvar,nx,yq,vpow)

% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015

clc;disp('Moment Index Yq');

for i=1:size(vpow,1)
    Yq(i,:)=1;
    for j=1:nvar-nx
        Yq(i,:)=Yq(i,:)*yq(vpow(i,nx+j)+1,j);
    end
end
