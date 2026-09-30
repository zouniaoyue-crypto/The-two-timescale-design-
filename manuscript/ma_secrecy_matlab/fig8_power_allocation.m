function res = fig8_power_allocation(prm)
%FIG8_POWER_ALLOCATION  Benefit of the long-term per-user power allocation {p_m}
%   (Proposition 2/3 of main.tex) over the information--AN power splitting with equal
%   user power (alpha only). The large-scale fading coefficients of the LUs are
%   heterogeneous: beta_m (dB) = -spread*(m-1)/(M-1), i.e., [0, -spread/2, -spread]
%   for M = 3, and the ESSR is plotted versus the spread (dB).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.P_dB = 15;
spread = [0 5 10 15 20];
schemes = {'MA_full', 'MA_EPA', 'FPA_full', 'FPA_EPA'};
K = numel(schemes);
res.values = spread;
res.essr = zeros(numel(spread), K);
res.anfrac = zeros(numel(spread), K);
res.F = zeros(numel(spread), K);
for i = 1:numel(spread)
    pr = prm;
    pr.beta_dB = -spread(i) * (0:prm.M-1) / max(prm.M - 1, 1);
    t0 = tic;
    for dI = 1:prm.numDrops
        sc = gen_scenario(pr, prm.seed + dI);
        out = evaluate_schemes(sc, pr, schemes, prm.seed + dI);
        for k = 1:K
            r = out.(schemes{k});
            res.essr(i, k)   = res.essr(i, k)   + r.essr/prm.numDrops;
            res.anfrac(i, k) = res.anfrac(i, k) + r.anfrac/prm.numDrops;
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
        end
    end
    fprintf('fig8: spread = %g dB done (%.0f s): ESSR = %s\n', spread(i), toc(t0), mat2str(res.essr(i,:), 4));
end
res.names = {'Proposed MA (opt. t, p, q)', 'MA, equal power (opt. t, \alpha)', ...
             'FPA (\lambda/2 UPA), opt. p, q', 'FPA (\lambda/2 UPA), equal power (opt. \alpha)'};
save(fullfile(results_dir(), 'fig8_power_allocation.mat'), 'res', 'prm', '-v7');
plot_fig8(res);
end
