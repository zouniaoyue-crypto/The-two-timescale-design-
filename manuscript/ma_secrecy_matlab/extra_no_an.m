function res = extra_no_an(prm)
%EXTRA_NO_AN  Fig. 6 of main.tex (no-AN curves): ESSR versus the transmit SNR of the MAs
%   and the FPA without AN (q = 0; for the MAs, the positions are optimized by Algorithm 2
%   with q = 0) on the same drops as fig5_snr.m, whose results provide the curves with the
%   power allocation of Algorithm 1 and with equal power. Saved in results/extra_no_an.mat
%   (about 55 min in Octave); Fig. 6 is drawn as soon as fig5_snr.mat is available.

if nargin < 1 || isempty(prm), prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'P_dB', 0:5:30, {'MA_noAN', 'FPA_noAN'});
save(fullfile(results_dir(), 'extra_no_an.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'P_tot/sigma^2 (dB)');
r5 = load_results('fig5_snr');
if ~isempty(r5), plot_fig6(r5, res); end                % Fig. 6
end
