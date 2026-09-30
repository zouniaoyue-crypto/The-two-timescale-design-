function res = fig5_snr(prm)
%FIG5_SNR  Fig. 5 of main.tex: (a) ESSR (Monte Carlo) and (b) optimized AN power
%   fraction (N-M) q / P_tot versus P_tot/sigma^2, averaged over prm.numDrops drops.
%   Schemes (same in Figs. 5-7): proposed, rate-oriented MA, sparse FPA, compact FPA,
%   and proposed without AN.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'P_dB', 0:5:30, main_schemes());
save(fullfile(results_dir(), 'fig5_snr.mat'), 'res', 'prm', '-v7');
plot_fig5(res);
end
