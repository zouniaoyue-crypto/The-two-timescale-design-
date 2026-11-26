function res = extra_eve_beta(prm, vals)
%EXTRA_EVE_BETA  Supplementary result (rev-8 candidate, not in main.tex): ESSR (Monte
%   Carlo) versus the large-scale fading coefficient beta_e of Eve relative to that of the
%   LUs (beta_m = 0 dB), i.e., Eve farther from (beta_e < 0 dB) or closer to (beta_e > 0 dB)
%   the BS than the LUs, at the default SNR, for the schemes in main_schemes.m.
%   Saved in results/extra_eve_beta.mat.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(vals), vals = -10:5:10; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'betae_dB', vals, main_schemes());
save(fullfile(results_dir(), 'extra_eve_beta.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'beta_e (dB)');
end
