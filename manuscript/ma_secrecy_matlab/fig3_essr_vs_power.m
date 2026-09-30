function res = fig3_essr_vs_power(prm)
%FIG3_ESSR_VS_POWER  ESSR (Monte Carlo) versus P_tot/sigma^2 for the proposed design
%   and the benchmarks, averaged over prm.numDrops random drops. Also plots the
%   optimized AN power fraction (N-M) q / P_tot (AN-saving effect, Remark 4).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
Pvec = 0:5:30;
schemes = {'MA_full', 'MA_EPA', 'MA_noAN', 'FPA_full', 'SPA_full', 'FPA_noAN'};
names = {'Proposed MA (opt. t, p, q)', 'MA, equal power (opt. t, \alpha)', 'MA without AN', ...
         'FPA (\lambda/2 UPA), opt. p, q', 'Sparse FPA, opt. p, q', 'FPA without AN'};
res = sweep_schemes(prm, 'P_dB', Pvec, schemes);
res.names = names;
save(fullfile(results_dir(), 'fig3_essr_vs_power.mat'), 'res', 'prm');

plot_sweep(res, Pvec, 'P_{tot}/\sigma^2 (dB)', 'Ergodic secrecy sum rate (bps/Hz)', 'essr', names, 'northwest');
save_figure('fig3_essr_vs_power');

sel = [1 2 4 5];
plot_sweep(res, Pvec, 'P_{tot}/\sigma^2 (dB)', 'AN power fraction (N-M)q/P_{tot}', 'anfrac', names, 'southeast', sel);
save_figure('fig6_an_fraction');
end
