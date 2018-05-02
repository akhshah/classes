function deriv = dyn(t, state, constants)
L0 = constants.L0;
L1 = constants.L1;
a = constants.a;
m = constants.m;
k = constants.k;
g = constants.g;
R = constants.R;
v = constants.v;

x1 = state(1);
x2 = state(2);
x3 = state(3);

L = L1 + L0/(1 + x1/a);
x1d = x2;
x2d = -k/m*x2 + g - (L0*x3^2)/(2*m*(a + x1));
x3d = 1/L*(v - R*x3 + (L0*x3*x2)/(a + x1));

deriv = [x1d; x2d; x3d];
