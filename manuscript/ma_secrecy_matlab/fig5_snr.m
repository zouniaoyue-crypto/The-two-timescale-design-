function res = fig5_snr(prm)
%FIG5_SNR  Figs. 5 and 6 of main.tex versus P_tot/sigma^2, averaged over prm.numDrops
%   drops: Fig. 5 (a) ESSR (Monte Carlo) and (b) optimized AN power fraction (N-M) q / P_tot
%   with its high-SNR prediction (an_highsnr.m) for the schemes in main_schemes.m (proposed,
%   rate-oriented MA, FPA with Eve-aware AN, and FPA); Fig. 6(a) ESSR of the 2 x 2
%   power-allocation design (pa_schemes.m: proposed, MA with equal power, FPA, and FPA with
%   equal power). The benchmarks of earlier revisions stored in fig5_snr.mat (AS, SPA_full,
%   MA_null, APS) are not plotted. For every scheme, res.essr_tin is the ESSR for an
%   eavesdropper that treats the other LUs' signals as noise (supplementary check,
%   print_table_eve.m).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'P_dB', 0:5:30, [main_schemes(), {'MA_eq', 'FPA_eq'}]);
save(fullfile(results_dir(), 'fig5_snr.mat'), 'res', 'prm', '-v7');
plot_fig5(res);
plot_fig6(res, load_results('extra_no_an'));   % Fig. 6(b) uses the no-AN results
end
