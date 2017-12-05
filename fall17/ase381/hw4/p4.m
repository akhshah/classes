%% 
close all
clear all
clc
%% Problem Setup
% inital conditions
x0 = 4.0;
v0 = 0.5;

% final time
T = 1.2;
vT = 0;
xT = 0;

sigmax_ = [1e0, 1e1, 1e2, 1e3, 1e4, 1e5];
%% Intercept
t = 0:0.01:1.2;
syms ts
for i = 1:length(sigmax_)
    sigmax = sigmax_(i);
    c1 = -6*sigmax*(v0*T + x0)/(6 + T^3*sigmax);
    c2 = c1*T;
    
    u{i} = 1/2*(-c1*t + c2);
    v{i} = -c1*t.^2/4 + c2*t/2 + v0;
    x{i} = -c1*t.^3/12 + c2*t.^2/4 + v0*t + x0;
    
    u_2_i(i) = int((0.5*(-c1*ts +  c2))^2, ts, 0, T);
end
% c1 = -6*sigmax*(v0*T + x0)/(6 + T^3*sigmax);
% c2 = c1*T;
%
% t = 0:0.01:1.2;
% u = 1/2*(-c1*t + c2);
% v = -c1*t.^2/4 + c2*t/2 + v0;
% x = -c1*t.^3/12 + c2*t.^2/4 + v0*t + x0;

figure(1)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,x{i})
end
plot(t, 0.2*ones(length(t),1), 'r')
plot(t, -0.2*ones(length(t),1), 'r')
legprop = legend('$\sigma_x = 10^0$', '$\sigma_x = 10^1$',...
    '$\sigma_x = 10^2$', '$\sigma_x = 10^3$',...
    '$\sigma_x = 10^4$', '$\sigma_x = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15, 'Location', 'West')
hold off

ylabel('Position' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('interx', '-depsc')

figure(2)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,v{i})
end

legprop = legend('$\sigma_x = 10^0$', '$\sigma_x = 10^1$',...
    '$\sigma_x = 10^2$', '$\sigma_x = 10^3$',...
    '$\sigma_x = 10^4$', '$\sigma_x = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15,...
    'Location', 'SouthWest')
hold off

ylabel('Velocity' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('interv', '-depsc')

figure(3)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,u{i})
end
legprop = legend('$\sigma_x = 10^0$', '$\sigma_x = 10^1$',...
    '$\sigma_x = 10^2$', '$\sigma_x = 10^3$',...
    '$\sigma_x = 10^4$', '$\sigma_x = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15,...
    'Location', 'SouthEast')
hold off

ylabel('Control Effort' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('interu', '-depsc')
%% Rendezvous
clear u v x

sigmax = 1000;
sigmav_ = [1e0, 1e1, 1e2, 1e3, 1e4, 1e5];

for i = 1:length(sigmav_)
    sigmav = sigmav_(i);
    temp = -v0 - 2*x0/T - 4*v0/(T*sigmav) - 4*x0/(T^2*sigmav);
    temp2 = (T/sigmav + 4/(T^2*sigmax*sigmav) - T/(3*sigmav) + T^2/4 +...
        2/(T*sigmax) - T^2/6);
    c1 = temp/temp2;
    c2 = (-4/T^2)*(c1/sigmax - c1*T^3/12 + v0*T + x0);
    
    u{i} = 1/2*(-c1*t + c2);
    v{i} = -c1*t.^2/4 + c2*t/2 + v0;
    x{i} = -c1*t.^3/12 + c2*t.^2/4 + v0*t + x0;
    
    u_2_r(i) = int((0.5*(-c1*ts +  c2))^2, ts, 0, T);
end

% temp = -v0 - 2*x0/T - 4*v0/(T*sigmav) - 4*x0/(T^2*sigmav);
% temp2 = (T/sigmav + 4/(T^2*sigmax*sigmav) - T/(3*sigmav) + T^2/4 +...
%     2/(T*sigmax) - T^2/6);
% c1 = temp/temp2;
% c2 = (-4/T^2)*(c1/sigmax - c1*T^3/12 + v0*T + x0);
%
% t = 0:0.01:1.2;
% u = 1/2*(-c1*t + c2);
% v = -c1*t.^2/4 + c2*t/2 + v0;
% x = -c1*t.^3/12 + c2*t.^2/4 + v0*t + x0;

figure(4)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,x{i})
end
plot(t, 0.2*ones(length(t),1), 'r')
plot(t, -0.2*ones(length(t),1), 'r')
legprop = legend('$\sigma_v = 10^0$', '$\sigma_v = 10^1$',...
    '$\sigma_v = 10^2$', '$\sigma_v = 10^3$',...
    '$\sigma_v = 10^4$', '$\sigma_v = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15, 'Location', 'West')
hold off

ylabel('Position' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('rendezx', '-depsc2')

figure(5)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,v{i})
end
plot(t, 0.1*ones(length(t),1), 'r')
plot(t, -0.1*ones(length(t),1), 'r')
legprop = legend('$\sigma_v = 10^0$', '$\sigma_v = 10^1$',...
    '$\sigma_v = 10^2$', '$\sigma_v = 10^3$',...
    '$\sigma_v = 10^4$', '$\sigma_v = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15,...
    'Location', 'SouthWest')
hold off

ylabel('Velocity' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('rendezv', '-depsc')

figure(6)
hold on; grid on;
for i = 1:length(sigmax_)
    plot(t,u{i})
end

legprop = legend('$\sigma_v = 10^0$', '$\sigma_v = 10^1$',...
    '$\sigma_v = 10^2$', '$\sigma_v = 10^3$',...
    '$\sigma_v = 10^4$', '$\sigma_v = 10^5$');
set(legprop,'interpreter', 'latex', 'FontSize', 15,...
    'Location', 'SouthEast')
hold off

ylabel('Control Effort' ,'interpreter', 'latex', 'FontSize', 15)
xlabel('Time','interpreter', 'latex', 'FontSize', 15)

print('rendezu', '-depsc')