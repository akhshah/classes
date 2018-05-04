%%
close all
clear all
clc

%% Constants
constants.k = 0.001;  % N/m/s
constants.m = 0.1;  % kg
constants.g = 9.81;
constants.a = 0.05;
constants.L0 = 0.01;
constants.L1 = 0.02;
constants.R = 1;
constants.k1 = 3000;
constants.k2 = 500;
constants.k3 = 50;

%% Initial Conditions
x0 = [0.0; 0.0; 1];

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8);

%% Propagate State (c)
tspan = 0:0.1:100;
[t, x] = ode45(@(t,x)dyn(t, x, flcont(t, x, constants), constants), tspan, x0);
x_fes = x;

figure
plot(t, x_fes(:,1))
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Position [m]', 'interpreter', 'latex', 'FontSize', 15)

print('fbstable', '-depsc')

figure
plot(t, x_fes(:,1) - 0.05)
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Error [m]', 'interpreter', 'latex', 'FontSize', 15)

print('fbstableerror', '-depsc')

%% Propagate State (d)
[t, x] = ode45(@(t,x)dyn(t, x, flcont2(t, x, constants), constants), tspan, x0);
r = 0.05 + 0.01*sin(tspan);
x_fet = x;

figure
plot(t, x_fet(:,1))
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Position [m]', 'interpreter', 'latex', 'FontSize', 15)

print('fbtrack', '-depsc')

figure
plot(t, x_fet(:,1) - r')
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Error [m]', 'interpreter', 'latex', 'FontSize', 15)

print('fbtrackerror', '-depsc')

%% Propagate state (f-c)
constants.k1 = 40;
constants.k2 = 20;
constants.k3 = 1;

[t, x] = ode45(@(t,x)dyn(t, x, bscont(t, x, constants), constants), tspan, x0);
x_bss = x;

figure
plot(t, x_bss(:,1))
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Position [m]', 'interpreter', 'latex', 'FontSize', 15)

print('bsstable', '-depsc')

figure
plot(t, x_bss(:,1) - 0.05)
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Error [m]', 'interpreter', 'latex', 'FontSize', 15)

print('bsstableerror', '-depsc')

%% Propagate state (f-d)
[t, x] = ode45(@(t,x)dyn(t, x, bscont2(t, x, constants), constants), tspan, x0);
x_bst = x;

figure
plot(t, x_bst(:,1))
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Position [m]', 'interpreter', 'latex', 'FontSize', 15)

print('bstrack', '-depsc')

figure
plot(t, x_bst(:,1) - r')
xlabel('Time [s]', 'interpreter', 'latex', 'FontSize', 15)
ylabel('Error [m]', 'interpreter', 'latex', 'FontSize', 15)

print('bstrackerror', '-depsc')
