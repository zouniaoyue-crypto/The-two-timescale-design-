function res = extra_no_an(prm)
%EXTRA_NO_AN  Supplementary result (rev-8 candidate, not in main.tex): AN ablation versus
%   the transmit SNR. The proposed design and the FPA without AN (q = 0; for the MAs, the
%   positions are optimized by Algorithm 2 with q = 0) on the same drops as fig5_snr.m,
%   whose results provide the AN-aided counterparts. Saved in results/extra_no_an.mat.

if nargin < 1 || isempty(prm), prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_noAN', 'FPA_noAN'});
save(fullfile(results_dir(), 'extra_no_an.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'P_tot/sigma^2 (dB)');
end
