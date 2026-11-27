function [eta, xi, psi, g] = rate_coeffs(sc, T)
% PILOT shadow of functions/rate_coeffs.m: with MA_DIR_AN = 1, the AN is directed toward
% the LoS component of Eve within the null space (removed Remark 1 of rev-7):
% psi_dir = (N - M)(kappa_e d + 1) instead of psi = kappa_e d + N - M.
g   = geo_quantities(sc, T);
N = sc.N;  M = sc.M;
eta = sc.zeta * (N - M) ./ (N * g.om);
xi  = sc.kappa_e * g.c + 1;
if strcmp(getenv('MA_DIR_AN'), '1')
    psi = (N - M) * (sc.kappa_e * g.d + 1);
else
    psi = sc.kappa_e * g.d + N - M;
end
end
