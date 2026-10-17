function res = fig5_snr(prm)
%FIG5_SNR  Fig. 5 of main.tex: (a) ESSR (Monte Carlo) and (b) optimized AN power
%   fraction (N-M) q / P_tot versus P_tot/sigma^2, averaged over prm.numDrops drops.
%   Schemes (same in Figs. 5 and 6, main_schemes.m): proposed, rate-oriented MA, antenna
%   selection, sparse FPA spanning the region, and FPA (compact lambda/2 UPA). The
%   proposed design without AN is also evaluated (Table I, not plotted). For
%   every scheme, res.essr_tin is the ESSR for an eavesdropper that treats the other LUs'
%   signals as noise (robustness check of the worst-case assumption of Section II-C).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'P_dB', 0:5:30, [main_schemes(), {'MA_noAN'}]);
save(fullfile(results_dir(), 'fig5_snr.mat'), 'res', 'prm', '-v7');
plot_fig5(res);
print_table_eve(res, [10 20 30]);   % Table I (both eavesdropper models)
end
