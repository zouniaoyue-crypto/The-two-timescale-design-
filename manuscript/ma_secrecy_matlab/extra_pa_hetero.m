function res = extra_pa_hetero(prm, spread)
%EXTRA_PA_HETERO  Supplementary result (former Section V-G, removed from main.tex in rev-7):
%   benefit of the long-term power allocation (PA), no figure. ESSR (Monte Carlo) versus P_tot/sigma^2 for three
%   PAs, with the MA positions optimized by Algorithm 2 for each PA:
%     'MA_full' : proposed PA, per-user secrecy water-filling + optimized q (Algorithm 1)
%     'MA_EPA'  : equal user power, power-splitting factor alpha optimized (1-D search)
%     'MA_fix'  : equal user power, fixed alpha = prm.alphaFix (no power optimization)
%   For the equal-power schemes, the objective is the sum of [.]^+ terms, since an LU
%   with a negative secrecy rate cannot be switched off. The large-scale fading of the
%   LUs is beta_m (dB) = -spread (m-1)/(M-1), i.e., [0, -spread/2, -spread] dB for M = 3.
%   Default spread = 20 dB (results/extra_pa_hetero.mat); extra_pa_spread.m sweeps the
%   spread (supplementary figure plot_pa_spread.m).

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, spread = 20; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.beta_dB = -spread * (0:prm.M-1) / max(prm.M - 1, 1);
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_full', 'MA_EPA', 'MA_fix'});
res.spread = spread;
if spread == 0, tag = 'identical'; else, tag = 'hetero'; end
save(fullfile(results_dir(), ['extra_pa_' tag '.mat']), 'res', 'prm', '-v7');
print_sweep(res, 'P_tot/sigma^2 (dB)');
end
