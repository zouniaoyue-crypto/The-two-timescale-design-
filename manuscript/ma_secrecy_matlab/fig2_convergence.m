function res = fig2_convergence(prm)
%FIG2_CONVERGENCE  Convergence of Algorithm 2 (objective of (P3) versus AO iterations)
%   for one random drop and three initializations (UPA and two random positions),
%   at P_tot/sigma^2 = 10, 20, and 30 dB. The Monte Carlo ESSR of each final
%   solution is printed for reference.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.Plist = [10 20 30];
res.hist = cell(numel(res.Plist), 3);
res.essrMC = zeros(numel(res.Plist), 3);
for ip = 1:numel(res.Plist)
    pr = prm;  pr.P_dB = res.Plist(ip);
    sc = gen_scenario(pr, prm.seed + 1);
    rng(prm.seed + 11);
    inits = {upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5), random_positions(sc), random_positions(sc)};
    for i = 1:3
        [T, p, q, hist] = ao_optimize(sc, inits{i}, pr, 'full');
        res.hist{ip, i} = hist;
        [~, ~, essr] = mc_rates(sc, T, p, q, max(prm.S, 10000), prm.seed);
        res.essrMC(ip, i) = essr;
        fprintf('fig2: P = %d dB, init %d: %d iterations, F = %.3f, MC ESSR = %.3f\n', ...
                res.Plist(ip), i, numel(hist) - 1, hist(end), res.essrMC(ip, i));
    end
end
save(fullfile(results_dir(), 'fig2_convergence.mat'), 'res', 'prm', '-v7');
plot_fig2(res);
end
