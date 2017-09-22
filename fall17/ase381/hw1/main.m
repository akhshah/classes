close all
clear all
clc
%% Initial Conditions + Function Conditions
% three different initial conditions
x0(:,1) = [0; 0];
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

charvec{1} = ['-']
charvec{2} = ['--']
charvec{3} = ['-.']

figure
subplot(2,1,1)
title('x^* - x_n Error')
hold on
grid on
for i=1:length(x0)
    plot(1:iterations(i)+1, xstar(1) - x{i}(1,:), charvec{i})
end
ylabel('Dimension 1 Error')
legend('x0_1', 'x0_2', 'x0_3')
subplot(2,1,2)
hold on
grid on
for i=1:length(x0)
    plot(1:iterations(i)+1, xstar(2) - x{i}(2,:), charvec{i})
end
ylabel('Dimension 2 Error')
xlabel('# of Iterations')