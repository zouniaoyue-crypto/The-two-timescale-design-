function res = extra_ean_check(prm)
%EXTRA_EAN_CHECK  Section V-B 1) of main.tex (text): power allocation of the benchmark "FPA
%   with Eve-aware AN". Its power allocation follows Algorithm 1 with psi_dir
%   (rate_coeffs.m), whereas (eq:Re) is less accurate for an AN concentrated in a single
%   dimension. For each drop at the default point, the ESSR of Algorithm 1 is compared with
%   that of the best AN power fraction on the grid 0:0.05:0.85 (with the secrecy
%   water-filling of Algorithm 1 for each candidate), evaluated by Monte Carlo
%   simulation (an oracle selection). The same is done for the FPA with isotropic AN.
%   Saved in results/extra_ean_check.mat (about 5 min in Octave).
if nargin < 1 || isempty(prm), prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
D = prm.numDrops;  fr = 0:0.05:0.85;
res.alg1 = zeros(D, 2);  res.oracle = zeros(D, 2);  res.frac = zeros(D, 2);  res.labels = {'FPA_full', 'FPA_ean'};
for dI = 1:D
    sc = gen_scenario(prm, prm.seed + dI);
    T = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
    for k = 1:2
        scO = sc;  scE = sc;
        if k == 2, scO.anDir = true;  scE.anDirG = exp(1j*2*pi/sc.lambda*(T*sc.ae)); end
        [p, q] = power_opt(scO, T, prm, 'full');
        [~, ~, res.alg1(dI, k)] = mc_rates(scE, T, p, q, prm.S, prm.seed + dI);
        [eta, xi, psi] = rate_coeffs(scO, T);
        best = -inf;
        for f = fr
            qq = f*sc.P/(sc.N - sc.M);
            pp = secrecy_wf(eta, xi./(qq*psi + sc.sbe), sc.P - (sc.N - sc.M)*qq, prm.nBisect);
            [~, ~, e] = mc_rates(scE, T, pp, qq, prm.S, prm.seed + dI);
            if e > best, best = e;  res.frac(dI, k) = f; end
        end
        res.oracle(dI, k) = best;
    end
end
save(fullfile(results_dir(), 'extra_ean_check.mat'), 'res', 'prm', '-v7');
fprintf('Algorithm 1 vs oracle AN power (Monte Carlo): FPA %.3f / %.3f, FPA with Eve-aware AN %.3f / %.3f\n', ...
        mean(res.alg1(:, 1)), mean(res.oracle(:, 1)), mean(res.alg1(:, 2)), mean(res.oracle(:, 2)));
end
