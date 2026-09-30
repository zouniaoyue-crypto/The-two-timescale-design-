function [Rb, Re, leak, an] = analytic_rates(sc, T, p, q)
%ANALYTIC_RATES  Closed-form approximations of main.tex:
%   Rb(m) : LU ergodic rate, eq. (15) (existing ZF approximation [Zhang14, Zheng25])
%   Re(m) : Eve ergodic rate, Proposition 1, eq. (23)
%   leak(m) = beta_e/(kappa_e+1) (kappa_e c_m + 1)      ~ E{|g^H wbar_m|^2}
%   an      = beta_e/(kappa_e+1) (kappa_e d + N - M)     ~ E{g^H P_H^perp g}
[eta, xi, psi, g] = rate_coeffs(sc, T);
p  = p(:);
Rb = log2(1 + eta .* p);
Re = log2(1 + xi .* p / (q*psi + sc.sbe));
bt = sc.beta_e/(sc.kappa_e + 1);
leak = bt*xi;
an   = bt*psi;
end
