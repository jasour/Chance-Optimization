function pass = realize_eye

d = domain(0,4);
I = eye(d);
pass = norm(I(10)-eye(10)) < eps;