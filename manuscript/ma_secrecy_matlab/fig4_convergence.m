function res = fig4_convergence(prm)
%FIG4_CONVERGENCE  Fig. 4 of main.tex: convergence of Algorithm 2 (objective of (P3)
%   versus the AO iterations) for one random drop and three initializations (UPA and
%   two random feasible positions), at P_tot/sigma^2 = 10, 20, and 30 dB. To show the
%   complete trajectories, the stopping criterion is disabled here (aoTol = 0), i.e.,
%   every run performs prm.aoMaxIter iterations; res.itStop is the iteration at which
%   Algorithm 2 with the default tolerance prm.aoTol would terminate. The Monte Carlo
%   ESSR of each final solution is printed for reference.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.Plist = [10 20 30];
res.hist = cell(numel(res.Plist), 3);
res.essrMC = zeros(numel(res.Plist), 3);
res.itStop = zeros(numel(res.Plist), 3);
for ip = 1:numel(res.Plist)
    pr = prm;  pr.P_dB = res.Plist(ip);  pr.aoTol = 0;  % complete trajectories
    sc = gen_scenario(pr, prm.seed + 1);
    rng(prm.seed + 11);
    inits = {upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5), random_positions(sc), random_positions(sc)};
    for i = 1:3
        [T, p, q, hist] = ao_optimize(sc, inits{i}, pr, 'full');
        res.hist{ip, i} = hist;
        stop = find(diff(hist) < prm.aoTol*max(1, abs(hist(2:end))), 1);
        if isempty(stop), stop = numel(hist) - 1; end
        res.itStop(ip, i) = stop;
        [~, ~, essr] = mc_rates(sc, T, p, q, max(prm.S, 10000), prm.seed);
        res.essrMC(ip, i) = essr;
        fprintf('fig4: P = %d dB, init %d: F = %.3f after %d iterations (default stopping rule: %d), MC ESSR = %.3f\n', ...
                res.Plist(ip), i, hist(end), numel(hist) - 1, stop, essr);
    end
end
save(fullfile(results_dir(), 'fig4_convergence.mat'), 'res', 'prm', '-v7');
plot_fig4(res);
end
