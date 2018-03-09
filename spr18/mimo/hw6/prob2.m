close all
clear all
clc

l = 0.98;
g = 9.8;
m = 0.825;
M = 8.085;

A = [0 1 0 0; 0 0 -(m*g/M) 0; 0 0 0 1; 0 0 g/l 0];
B = [0; 1/M; 0; -1/(M*l)];
I = eye(length(A));

Q = sdpvar(length(A), length(A));
Z = sdpvar(1, 4);

alpha_up = 800;
alpha_lo = 0;
i = 0;
MAX_ITER = 25;

tol = 1e-8;

while( (abs(alpha_up - alpha_lo) > tol) && i < MAX_ITER)
    i = i + 1;
    alpha = 0.5*(alpha_up + alpha_lo);
    F = [Q > I, Q*A' + Z'*B' + A*Q + B*Z + 2*alpha*Q < -I];
    
    test = optimize(F);
    
    if test.problem == 1
        alpha_up = alpha;
    elseif test.problem == 0
        alpha_lo = alpha;
    else
        disp('everything broke')
    end
end

sprintf('%0.5g < alpha < %0.5g', [alpha_lo, alpha_up])
P = inv(value(Q));
K = value(Z)*P