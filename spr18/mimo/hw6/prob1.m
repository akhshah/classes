close all
clear all
clc

A = [-1 0; 1 -2];
P = sdpvar(length(A), length(A));
I = eye(length(A));

alpha_up = 800;
alpha_lo = 0;
i = 0;

tol = 1e-8;

while((abs(alpha_up - alpha_lo) > tol) && i < 25)
    i = i + 1;
    alpha = 0.5*(alpha_up + alpha_lo);
    F = [P > I, A'*P + P*A + 2*alpha*P < - I];
    test = optimize(F);

    if test.problem == 1
        alpha_up = alpha;
    elseif test.problem == 0
        alpha_lo = alpha;
    else
        disp('everything broke')
    end
end
