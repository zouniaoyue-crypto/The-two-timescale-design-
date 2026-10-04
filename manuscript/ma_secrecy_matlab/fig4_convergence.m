function res = fig4_convergence(prm)
%FIG4_CONVERGENCE  Fig. 4 of main.tex: convergence of Algorithm 2.
%   Objective value of (P3) versus the number of AO iterations, averaged over
%   prm.numDrops random drops (the same drops as in Figs. 5-7), for four settings
%   (N, P_tot/sigma^2) in {8, 12} x {10, 20} dB, with the UPA initialization. To show the
%   complete trajectories, the stopping criterion is disabled (aoTol = 0) and every run
%   performs res.nIt iterations. In addition, the script stores
%     res.itStop  : iteration at which Algorithm 2 with the default tolerance prm.aoTol
%                   terminates (per setting and drop);
%     res.histRnd : trajectories from two random initializations (N = 8, 20 dB);
%     res.histMM  : trajectories without the global search of Stage 1, i.e., pure
%                   element-wise MM updates (prm.gridStep = 0; N = 8, 20 dB).
%   For N = 12, the UPA initialization is a 3 x 4 UPA with lambda/2 spacing.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.Nlist = [8 12];
res.Plist = [10 20];
res.nIt   = 50;
D = prm.numDrops;
res.hist   = zeros(numel(res.Nlist), numel(res.Plist), D, res.nIt + 1);
res.itStop = zeros(numel(res.Nlist), numel(res.Plist), D);
res.histRnd = zeros(2, D, res.nIt + 1);
res.histMM  = zeros(D, res.nIt + 1);
for iN = 1:numel(res.Nlist)
    for iP = 1:numel(res.Plist)
        pr = prm;  pr.N = res.Nlist(iN);  pr.P_dB = res.Plist(iP);
        pr.aoTol = 0;  pr.aoMaxIter = res.nIt;                 % complete trajectories
        rc = [ceil(pr.N/4), 4];                                % 2 x 4 or 3 x 4 UPA
        t0 = tic;
        for dI = 1:D
            sc = gen_scenario(pr, prm.seed + dI);
            T0 = upa_positions(sc.N, rc(1), rc(2), 0.5);
            [~, ~, ~, h] = ao_optimize(sc, T0, pr, 'full');
            res.hist(iN, iP, dI, :) = h;
            stop = find(diff(h) < prm.aoTol*max(1, abs(h(2:end))), 1);
            if isempty(stop), stop = res.nIt; end
            res.itStop(iN, iP, dI) = stop;
            if pr.N == 8 && pr.P_dB == 20
                rng(prm.seed + dI + 7919);                     % as in evaluate_schemes.m
                for i = 1:2
                    [~, ~, ~, h] = ao_optimize(sc, random_positions(sc), pr, 'full');
                    res.histRnd(i, dI, :) = h;
                end
                pm = pr;  pm.gridStep = 0;
                [~, ~, ~, h] = ao_optimize(sc, T0, pm, 'full');
                res.histMM(dI, :) = h;
            end
        end
        hm = squeeze(mean(res.hist(iN, iP, :, :), 3));
        fprintf('fig4: N = %d, P = %d dB (%.0f s): F = %.3f -> %.3f (1 it: %.3f), stop at %.1f its on average\n', ...
                pr.N, pr.P_dB, toc(t0), hm(1), hm(end), hm(2), mean(res.itStop(iN, iP, :)));
    end
end
save(fullfile(results_dir(), 'fig4_convergence.mat'), 'res', 'prm', '-v7');
plot_fig4(res);
end
