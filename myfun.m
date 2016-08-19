% First, write a file to compute the 10-component vector F.

function F = myfun(x)
k = 1:10;
F = 2 + 2*k-exp(k*x(1))-exp(k*x(2))+y(1)*y(2)^2;

% Next, invoke an optimization routine.

   % Invoke optimizer

% After about 24 function evaluations, this example gives the solution

% x,resnorm
% x = 
%      0.2578   0.2578
% 
% resnorm = 
%      124.3622