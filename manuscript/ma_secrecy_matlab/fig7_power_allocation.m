function res = fig7_power_allocation(prm, spread)
%FIG7_POWER_ALLOCATION  Fig. 7 of main.tex: benefit of the long-term power allocation
%   (PA). ESSR (Monte Carlo) versus P_tot/sigma^2 for three PAs, with the MA positions
%   optimized by Algorithm 2 for each PA:
%     'MA_full' : proposed PA, per-user secrecy water-filling + optimized q (Algorithm 1)
%     'MA_EPA'  : equal user power, power-splitting factor alpha optimized (1-D search)
%     'MA_fix'  : equal user power, fixed alpha = prm.alphaFix (no power optimization)
%   For the equal-power schemes, the objective is the sum of [.]^+ terms, since an LU
%   with a negative secrecy rate cannot be switched off. The large-scale fading of the
%   LUs is beta_m (dB) = -spread (m-1)/(M-1), i.e., [0, -spread/2, -spread] dB for M = 3.
%   Fig. 7(a) uses spread = 20 dB (default, results/fig7_pa_hetero.mat); Fig. 7(b) uses the
%   results of extra_pa_spread.m at 0 and 10 dB and is drawn when these are available.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, spread = 20; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.beta_dB = -spread * (0:prm.M-1) / max(prm.M - 1, 1);
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_full', 'MA_EPA', 'MA_fix'});
res.spread = spread;
if spread == 0, tag = 'identical'; else, tag = 'hetero'; end
save(fullfile(results_dir(), ['fig7_pa_' tag '.mat']), 'res', 'prm', '-v7');
if spread == 20
    plot_fig7(res, load_results('extra_pa_spread_0dB'), load_results('extra_pa_spread_10dB'));
end
end
