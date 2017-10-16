close all
clear all
clc

f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
h = @(x) (x(1) + 0.5)^2 + (x(2) + 0.5)^2 - 0.25;

phi = @(x, alpha) f(x) + 0.5*alpha*h(x)^2;
tol = 1e-4;
alpha = 0.1;
beta = 6;
x = [1 1]';
i = 1;

while abs(h(x)) > tol
    x_plot(:,i) = x;
    fun = @(x) phi(x,alpha);
    
    x = fminsearch(fun, x);
    i = i + 1;
    
    alpha = alpha*beta;
end

plot(x_plot(1,:), x_plot(2,:), '-o')