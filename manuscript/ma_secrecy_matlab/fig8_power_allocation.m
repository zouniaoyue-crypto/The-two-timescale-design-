function res = fig8_power_allocation(prm, spread)
%FIG8_POWER_ALLOCATION  Fig. 8 of main.tex: ESSR (Monte Carlo) versus P_tot/sigma^2 for
%   different long-term power allocations (PA) with the MA positions optimized for
%   each PA, where the large-scale fading coefficients of the LUs are
%   beta_m (dB) = -spread (m-1)/(M-1), i.e., [0, -spread/2, -spread] dB for M = 3.
%   Run once with spread = 0 (identical LUs) and once with spread = 20 dB.
%     'MA_full' : proposed PA, per-user secrecy water-filling + optimized q (Algorithm 1)
%     'MA_EPA'  : equal user power, power-splitting factor alpha optimized (1-D search)
%     'MA_fix'  : equal user power, fixed alpha = prm.alphaFix (no power optimization)
%   For the equal-power schemes, the objective is the sum of [.]^+ terms, since an LU
%   with a negative secrecy rate cannot be switched off.

if nargin < 1, prm = default_params(); end
if nargin < 2, spread = 20; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.beta_dB = -spread * (0:prm.M-1) / max(prm.M - 1, 1);
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_full', 'MA_EPA', 'MA_fix'});
res.spread = spread;
save(fullfile(results_dir(), sprintf('fig8_power_allocation_%ddB.mat', spread)), 'res', 'prm', '-v7');
f0 = fullfile(results_dir(), 'fig8_power_allocation_0dB.mat');
f1 = fullfile(results_dir(), 'fig8_power_allocation_20dB.mat');
if exist(f0, 'file') && exist(f1, 'file')                % plot when both runs are available
    S0 = load(f0);  S1 = load(f1);
    plot_fig8(S0.res, S1.res);
end
end
