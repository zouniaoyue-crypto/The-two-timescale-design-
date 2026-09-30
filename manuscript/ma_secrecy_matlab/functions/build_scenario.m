function sc = build_scenario(prm, th, ph, th_e, ph_e)
%BUILD_SCENARIO  Scenario struct for given AoDs (all other quantities from prm).
%
%   Wave vectors (eq. (2)):  a_m = [cos(theta_m) sin(phi_m); sin(theta_m)],  a_e likewise.
%   zeta_m    = beta_m / ((kappa_m + 1) sigma_m^2)               (eq. (15))
%   sbar_e^2  = sigma_e^2 (kappa_e + 1) / beta_e                  (eq. (22))

M = prm.M;
sc.N = prm.N;  sc.M = M;
sc.lambda = prm.lambda;  sc.A = prm.A;  sc.Dmin = prm.Dmin;
sc.th = th(:);  sc.ph = ph(:);  sc.th_e = th_e;  sc.ph_e = ph_e;
sc.au = [cos(sc.th.') .* sin(sc.ph.'); sin(sc.th.')];      % 2 x M
sc.ae = [cos(th_e) * sin(ph_e); sin(th_e)];                % 2 x 1
sc.kappa   = expand(10.^(prm.kappa_dB/10), M);
sc.kappa_e = 10^(prm.kappae_dB/10);
sc.beta    = expand(10.^(prm.beta_dB/10), M);
sc.beta_e  = 10^(prm.betae_dB/10);
sc.sigma2  = expand(prm.sigma2, M);
sc.sigma2e = prm.sigma2e;
sc.P       = 10^(prm.P_dB/10);
sc.zeta    = sc.beta ./ ((sc.kappa + 1) .* sc.sigma2);
sc.sbe     = sc.sigma2e * (sc.kappa_e + 1) / sc.beta_e;
end

function x = expand(x, M)
x = x(:);
if numel(x) == 1, x = repmat(x, M, 1); end
end
