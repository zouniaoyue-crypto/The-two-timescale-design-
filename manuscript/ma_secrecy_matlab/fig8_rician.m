function res = fig8_rician(prm, panels)
%FIG8_RICIAN  Fig. 8 of main.tex: ESSR (Monte Carlo) versus the Rician factors at the
%   default SNR for the schemes in main_schemes.m, (a) versus the common Rician factor
%   kappa_m = kappa_e (field 'kappa_common' of sweep_schemes.m) and (b) versus the Rician
%   factor kappa_e of Eve with kappa_m = prm.kappa_dB (10 dB). The two panels use the same
%   drops and can be run in parallel sessions, e.g., fig8_rician([], 'a') and
%   fig8_rician([], 'b'); each is saved in results/fig8_rician_<panel>.mat, and the figure
%   is drawn as soon as both are available.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(panels), panels = 'ab'; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
kv = -10:5:20;                                   % Rician factors (dB)
for pnl = panels
    if pnl == 'a', field = 'kappa_common'; else, field = 'kappae_dB'; end
    res = sweep_schemes(prm, field, kv, main_schemes());
    save(fullfile(results_dir(), ['fig8_rician_' pnl '.mat']), 'res', 'prm', '-v7');
end
ra = load_results('fig8_rician_a');  rb = load_results('fig8_rician_b');
if ~isempty(ra) && ~isempty(rb), plot_fig8(ra, rb); end
end
