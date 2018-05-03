function v = bscont2(t, x, constants)
r = 0.05 + 0.01*sin(t);
rd = 0.01*cos(t);
rdd = -0.01*sin(t);
rddd = -0.01*cos(t);

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

x2d = -k/m*x2 + g - (L0*x3^2)/(2*m*a*(1 + x1/a)^2);

L = L1 + L0/(1 + x1/a);
e = x1 - r;
ed = x2 - rd;
edd = x2d - rdd;

z = 0.5*x3^2 + a*m*(1 + x1/a)^2/L0*(k/m*x2 - g + rdd - (1 + k1)*(e + ed));
v = R*x3 - (L0*x2*x3)/(a*(1 + x1/a)^2) + L/x3*(-k2*z - ...
    (2*m*(1+x1/a)*x2)/L0*(k/m*x2 - g + rdd - (1+k1)*(ed + e)) ...
    - a*m*(1 + x1/a)^2/(L0)*(k/m*x2d + rddd - (1+k1)*(edd + ed)));
end