function v = flcont(t, x, constants)
r = 0.05;
rd = 0;
rdd = 0;
rddd = 0;
L0 = constants.L0;
L1 = constants.L1;
a = constants.a;
m = constants.m;
k = constants.k;
g = constants.g;
R = constants.R;
k1 = constants.k1;
k2 = constants.k2;
k3 = constants.k3;

x1 = x(1);
x2 = x(2);
x3 = x(3);

L = L1 + L0/(1 + x1/a);

u = -k1*(x1 - r) - k2*x2 - k3*(-k/m*x2 + g - (L0*x3^2)/(2*m*a*(1 + x1/a)^2));

v = R*x3 - (L0*x3*x2)/(a*(1+x1/a)^2) + (L*x3*x2)/(a + x1)...
    - (L*a*m*(1+x1/a)^2)/(L0*x3)*u;
% v = R*x3 + (L1*x2*x3)/(a+x1) + m*L*(a+x1)^2/(a*L0*x3)*(-u);