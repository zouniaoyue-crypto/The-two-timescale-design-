function res = table_mechanisms(prm)
%TABLE_MECHANISMS  Section V-C of main.tex (text): secrecy mechanisms of the designs at the default
%   point (N = 8, M = 3, A = 4 lambda, 20 dB; the same drops as fig5_snr.m; the text quotes
%   rho1, xi of LU 1, and psi for the FPA, the rate-oriented MA, and the proposed design;
%   the other quantities are stored for reference). For each scheme
%   of main_schemes.m and each drop, the designed positions T are evaluated in terms of the
%   quantities of Section III-D:
%     rho1   normalized LoS correlation between Eve and LU 1, |hbar_1^H gbar|/N
%     etaN   effective ZF gain eta_m(t) normalized by its upper bound zeta_m (N-M)(kappa_m+1)
%            in (eq:etabound), averaged over the LUs (LoS decorrelation of the LUs)
%     xi     normalized information leakage xi_m(t) = kappa_e c_m(t) + 1 (per LU)
%     psi    normalized AN power received by Eve psi(t) = kappa_e d(t) + N - M
%     Xi     leakage-to-AN ratio Xi_m(t) = (N-M) xi_m(t) / (M psi(t)) of (eq:highsnr) (per LU)
%   The Monte Carlo ESSR of each drop is stored as well (res.essr) and compared with
%   fig5_snr.mat at 20 dB as a consistency check (identical designs). Saved in
%   results/table_mechanisms.mat (about 12 min in Octave).

if nargin < 1 || isempty(prm), prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
schemes = main_schemes();
D = prm.numDrops;  K = numel(schemes);  M = prm.M;
res.schemes = schemes;
res.rho1 = zeros(D, K);  res.etaN = zeros(D, K);  res.psi = zeros(D, K);
res.xi = zeros(D, K, M);  res.Xi = zeros(D, K, M);  res.essr = zeros(D, K);  res.anfrac = zeros(D, K);
t0 = tic;
for dI = 1:D
    sc  = gen_scenario(prm, prm.seed + dI);                    % as in sweep_schemes.m
    scD = design_scenario(prm, sc, prm.seed + dI);
    out = evaluate_schemes(scD, prm, schemes, prm.seed + dI, sc);
    k0 = 2*pi/sc.lambda;
    for k = 1:K
        r = out.(schemes{k});  T = r.T;  N = size(T, 1);
        [eta, xi, psi] = rate_coeffs(sc, T);
        res.rho1(dI, k) = abs(exp(1j*k0*(T*sc.au(:, 1)))' * exp(1j*k0*(T*sc.ae))) / N;
        res.etaN(dI, k) = mean(eta(:) ./ (sc.zeta(:) * (N - M) .* (sc.kappa(:) + 1)));
        res.xi(dI, k, :) = xi;  res.psi(dI, k) = psi;
        res.Xi(dI, k, :) = (N - M) * xi / (M * psi);
        res.essr(dI, k) = r.essr;  res.anfrac(dI, k) = r.anfrac;
    end
end
fprintf('table_mechanisms: %d drops (%.1f min)\n', D, toc(t0)/60);
save(fullfile(results_dir(), 'table_mechanisms.mat'), 'res', 'prm', '-v7');
fprintf('%-18s %7s %7s %7s %7s %7s %7s %7s %7s\n', 'scheme', 'rho1', 'etaN', 'xi1', 'xi', 'psi', 'Xi1', 'Xi', 'ESSR');
for k = 1:K
    fprintf('%-18s %7.3f %7.3f %7.2f %7.2f %7.2f %7.3f %7.3f %7.2f\n', schemes{k}, mean(res.rho1(:, k)), ...
            mean(res.etaN(:, k)), mean(res.xi(:, k, 1)), mean(mean(res.xi(:, k, :))), mean(res.psi(:, k)), ...
            mean(res.Xi(:, k, 1)), mean(mean(res.Xi(:, k, :))), mean(res.essr(:, k)));
end
end
