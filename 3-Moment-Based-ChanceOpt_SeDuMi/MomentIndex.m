function [AMy,AMx,AMup]=MomentIndex(Yq,nx,vpowd,vpowdx)

% Ashkan Jasour
% Ph.D. Candidate,
% Robust Machine Intelligence and Control Lab,
% The School of Electrical Engineering and Computer Science,
% The Pennsylvania State University.
% https://sites.google.com/site/ashkanjasour
% November, 2015


for i=1:size(vpowd,1)   
    for j=1:i
        clc
        disp('Moment Matrix')
        disp([i,j,size(vpowd,1)])
       
      AMy( (i-1)*size(vpowd,1)+j, (glex2num(vpowd(i,:)+vpowd(j,:))) ) = 1;
      AMy( (j-1)*size(vpowd,1)+i, (glex2num(vpowd(i,:)+vpowd(j,:))) ) = 1;
      
      AMup( (i-1)*size(vpowd,1)+j, (glex2num(vpowd(i,1:nx)+vpowd(j,1:nx))) ) = Yq((glex2num(vpowd(i,:)+vpowd(j,:))));
      AMup( (j-1)*size(vpowd,1)+i, (glex2num(vpowd(i,1:nx)+vpowd(j,1:nx))) ) = Yq((glex2num(vpowd(i,:)+vpowd(j,:))));
      
    end
end


for i=1:size(vpowdx,1)   
    for j=1:i
        clc;disp('Moment Matrix x');disp([i,j,size(vpowdx,1)])
      AMx( (i-1)*size(vpowdx,1)+j, (glex2num(vpowdx(i,:)+vpowdx(j,:))) ) = 1;
      AMx( (j-1)*size(vpowdx,1)+i, (glex2num(vpowdx(i,:)+vpowdx(j,:))) ) = 1;
    end
end
