function res = fig8_power_allocation(prm, P_dB)
%FIG8_POWER_ALLOCATION  Fig. 8 of main.tex: ESSR (Monte Carlo) versus the spread of the
%   large-scale fading coefficients of the LUs, beta_m (dB) = -spread (m-1)/(M-1), i.e.,
%   [0, -spread/2, -spread] dB for M = 3, for different long-term power allocations (PA)
%   with the MA positions optimized by Algorithm 2 for each PA. Run once for each SNR
%   in prm.fig8SNR (default [0 10] dB: Fig. 8(a) and 8(b)); the figure is drawn when
%   both runs are available. The 20 dB run is only quoted in the text.
%     'MA_full' : proposed PA, per-user secrecy water-filling + optimized q (Algorithm 1)
%     'MA_EPA'  : equal user power, power-splitting factor alpha optimized (1-D search)
%     'MA_fix'  : equal user power, fixed alpha = prm.alphaFix (no power optimization)
%   For the equal-power schemes, the objective is the sum of [.]^+ terms, since an LU
%   with a negative secrecy rate cannot be switched off.

if nargin < 1, prm = default_params(); end
if nargin < 2, P_dB = 10; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.P_dB = P_dB;
res = sweep_schemes(prm, 'spread', [0 5 10 15 20], {'MA_full', 'MA_EPA', 'MA_fix'});
res.P_dB = P_dB;
save(fullfile(results_dir(), sprintf('fig8_pa_%ddB.mat', P_dB)), 'res', 'prm', '-v7');
fa = fullfile(results_dir(), sprintf('fig8_pa_%ddB.mat', prm.fig8SNR(1)));
fb = fullfile(results_dir(), sprintf('fig8_pa_%ddB.mat', prm.fig8SNR(2)));
if exist(fa, 'file') && exist(fb, 'file')                % plot when both runs are available
    Sa = load(fa);  Sb = load(fb);
    plot_fig8(Sa.res, Sb.res);
end
end
