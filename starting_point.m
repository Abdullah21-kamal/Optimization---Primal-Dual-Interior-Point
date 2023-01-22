function [x,y,s] = starting_point(A,c,b)
%this function works on the given matricies of the coefficient of the
%objective function and the constraints to find suitable points to start
%with
%By implementing the formula mentioned in the Numerical optimization
%textbook
A_transpose = A';
x = A_transpose*((A*A_transpose)^-1)*b;
y = ((A*A_transpose)^-1)*A*c;
s = c- A_transpose*y;

% as mentioned, x and s vectors are nonpositive components
DeltaX = max([0,-3*min(x)/2]);
DeltaS = max([0,-3*min(s)/2]);

x = x+DeltaX;
s = s+DeltaS;
%to approach zero
DeltaXHat = x'*s/(2*sum(s));
DeltaSHat = x'*s/(2*sum(x));
x = x+DeltaXHat;
s = s+DeltaSHat;
end