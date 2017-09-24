close all
clear all
clc
%% Initial Conditions + Function Conditions
% three different initial conditions
x0(:,1) = [1; -1];
x0(:,2) = [10; 15];
x0(:,3) = [-100; -150];

% Data
Q = [6 1; 1 4];
b = [1; 0];

% Error Epsilon
epsilon = 0.001;

%% Truth
xstar = inv(Q)*b;
x{3} = [];
iterations = zeros(3,1);
for i=1:length(x0)
    [x{i}, iterations(i)] = minimizer(x0(:,i), Q, b, epsilon);
end

charvec{1} = ['*-'];
charvec{2} = ['o--'];
charvec{3} = ['-.'];

iterations

figure
subplot(2,1,1)
title('Error $x^* - x_n$','interpreter', 'latex', 'FontSize', 15)
hold on
grid on
for i=1:length(x0)
    plot(1:iterations(i)+1, xstar(1) - x{i}(1,:), charvec{i})
end
ylabel('Error $x_{1}$' ,'interpreter', 'latex', 'FontSize', 15)
legprop = legend('$x_{0_1}$', '$x_{0_2}$', '$x_{0_3}$');
set(legprop,'interpreter', 'latex', 'FontSize', 15)
subplot(2,1,2)
hold on
grid on
for i=1:length(x0)
    plot(1:iterations(i)+1, xstar(2) - x{i}(2,:), charvec{i})
end
ylabel('')
ylabel('Error $x_{2}$' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('\# of Iterations','interpreter', 'latex', 'FontSize', 15)

print('error', '-depsc')
