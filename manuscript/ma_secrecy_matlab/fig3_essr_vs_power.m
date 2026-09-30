function res = fig3_essr_vs_power(prm)
%FIG3_ESSR_VS_POWER  ESSR (Monte Carlo) versus P_tot/sigma^2 for the proposed design
%   and the benchmarks, averaged over prm.numDrops random drops. Also plots the
%   optimized AN power fraction (N-M) q / P_tot (AN-saving effect, Remark 4).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
Pvec = 0:5:30;
schemes = {'MA_full', 'MA_EPA', 'MA_noAN', 'FPA_full', 'SPA_full', 'FPA_noAN'};
res = sweep_schemes(prm, 'P_dB', Pvec, schemes);
save(fullfile(results_dir(), 'fig3_essr_vs_power.mat'), 'res', 'prm', '-v7');
plot_fig3(res);
end
