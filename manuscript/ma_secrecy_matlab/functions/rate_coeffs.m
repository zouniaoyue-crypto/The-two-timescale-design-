function [eta, xi, psi, g] = rate_coeffs(sc, T)
%RATE_COEFFS  Effective coefficients of problem (P3) in main.tex (eq:Rm, eq:Re):
%   eta_m(t) = zeta_m (N - M) / (N omega_m(t))      effective ZF gain of LU m
%   xi_m(t)  = kappa_e c_m(t) + 1                   normalized leakage to Eve
%   psi(t)   = kappa_e d(t) + N - M                 normalized AN power at Eve
%   With sc.anDir = true (benchmark "FPA with Eve-aware AN", evaluate_schemes.m), the AN
%   is steered toward the LoS component of Eve within the null space of H^H, i.e.,
%   Sigma = (N-M) q P gbar gbar^H P / (gbar^H P gbar) with P the null-space projector.
%   Since E{|g^H P gbar|^2 | H} / (gbar^H P gbar) = beta_e~ (kappa_e gbar^H P gbar + 1),
%   the same steps as for (eq:Re) give
%   psi_dir(t) = (N - M)(kappa_e d(t) + 1) >= psi(t).

g   = geo_quantities(sc, T);
N   = sc.N;  M = sc.M;
eta = sc.zeta * (N - M) ./ (N * g.om);
xi  = sc.kappa_e * g.c + 1;
if isfield(sc, 'anDir') && sc.anDir
    psi = (N - M) * (sc.kappa_e * g.d + 1);      % Eve-aware (directional) AN
else
    psi = sc.kappa_e * g.d + N - M;               % isotropic null-space AN
end
end
