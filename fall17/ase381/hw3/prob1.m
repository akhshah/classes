%% ASE381 - Optimal Space Control
% Problem 1
% @author akhil
% @date 10/15/2017

close all
clear all
clc

%% Set Up Necessary Functions

f = @(x) 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
h = @(x) (x(1) + 0.5)^2 + (x(2) + 0.5)^2 - 0.25;

phi = @(x, alpha) f(x) + 0.5*alpha*h(x)^2;

%% Parameters
% tolerance
tol = 1e-4;

% update parameters
alpha = 0.1;
beta = 6;

% intial conditions
x = [1 1]';
i = 1;

while abs(h(x)) > tol
    x_plot(:,i) = x;
    fun = @(x) phi(x,alpha);
    
    x = fminsearch(fun, x);
    i = i + 1;
    
    alpha = alpha*beta;
end

%% Plot
plot(x_plot(1,:), x_plot(2,:), '-o')
xlabel('$x_1$', 'interpreter', 'latex', 'FontSize', 15)
ylabel('$x_2$', 'interpreter', 'latex', 'FontSize', 15)
title('$x_1 - x_2$ Plane', 'interpreter', 'latex', 'FontSize', 17)
grid on;
print('prob1', '-depsc')