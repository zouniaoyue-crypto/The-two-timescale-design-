function [eta, xi, psi, g] = rate_coeffs(sc, T)
%RATE_COEFFS  Effective coefficients of problem (P3) in main.tex (eqs. (17), (26)):
%   eta_m(t) = zeta_m (N - M) / (N omega_m(t))      effective ZF gain of LU m
%   xi_m(t)  = kappa_e c_m(t) + 1                   normalized leakage to Eve
%   psi(t)   = kappa_e d(t) + N - M                 normalized AN power at Eve

g   = geo_quantities(sc, T);
N   = sc.N;  M = sc.M;
eta = sc.zeta * (N - M) ./ (N * g.om);
xi  = sc.kappa_e * g.c + 1;
psi = sc.kappa_e * g.d + N - M;
end
