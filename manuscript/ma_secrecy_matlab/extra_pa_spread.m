function res = extra_pa_spread(prm, P_dB)
%EXTRA_PA_SPREAD  Power-allocation study versus the spread of the large-scale fading of
%   the LUs, beta_m (dB) = -spread (m-1)/(M-1), i.e., [0, -spread/2, -spread] dB for M = 3,
%   at a given P_tot/sigma^2 (default 10 dB; main.tex uses 0 and 10 dB). It complements
%   Fig. 7 (which uses spread = 0 and 20 dB) and is quoted in Section V-F of main.tex
%   (no figure). Schemes as in fig7_power_allocation.m.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, P_dB = 10; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.P_dB = P_dB;
res = sweep_schemes(prm, 'spread', [0 5 10 15 20], {'MA_full', 'MA_EPA', 'MA_fix'});
res.P_dB = P_dB;
save(fullfile(results_dir(), sprintf('extra_pa_spread_%ddB.mat', P_dB)), 'res', 'prm', '-v7');
print_sweep(res, 'spread (dB)');
end
