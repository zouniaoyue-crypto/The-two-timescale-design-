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
%   Run once with spread = 0 (identical LUs, results/fig7_pa_identical.mat) and once with
%   spread = 20 dB (heterogeneous LUs, results/fig7_pa_hetero.mat); the figure shows the
%   relative ESSR loss of the equal-power schemes and is drawn when both runs exist.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, spread = 20; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.beta_dB = -spread * (0:prm.M-1) / max(prm.M - 1, 1);
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_full', 'MA_EPA', 'MA_fix'});
res.spread = spread;
if spread == 0, tag = 'identical'; else, tag = 'hetero'; end
save(fullfile(results_dir(), ['fig7_pa_' tag '.mat']), 'res', 'prm', '-v7');
f0 = fullfile(results_dir(), 'fig7_pa_identical.mat');
f1 = fullfile(results_dir(), 'fig7_pa_hetero.mat');
if exist(f0, 'file') && exist(f1, 'file')                % plot when both runs are available
    S0 = load(f0);  S1 = load(f1);
    plot_fig7(S0.res, S1.res);
end
end
