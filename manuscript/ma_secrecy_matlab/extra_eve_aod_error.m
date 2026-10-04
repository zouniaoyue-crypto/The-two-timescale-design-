function res = extra_eve_aod_error(prm, errList, tag)
%EXTRA_EVE_AOD_ERROR  Robustness to imperfect statistical CSI of Eve (quoted in Section V-D
%   of main.tex, no figure): the BS designs all schemes with an AoD of Eve that deviates
%   from the true one by err (rad) in a random direction (design_scenario.m), and the
%   designs are evaluated by Monte Carlo simulation for the true AoD.
%   Default: err in {0, 0.01, 0.02, 0.05, 0.1} rad at P_tot/sigma^2 = 20 dB. For err = 0,
%   the results coincide with the 20 dB point of Fig. 5.
%   The optional tag is appended to the results file name (for runs split over sessions).

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(errList), errList = [0 0.01 0.02 0.05 0.1]; end
if nargin < 3, tag = ''; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'eveAoDErr', errList, main_schemes());
save(fullfile(results_dir(), ['extra_eve_aod_error' tag '.mat']), 'res', 'prm', '-v7');
fprintf('\nESSR (bps/Hz) versus the AoD error of Eve at the BS (rows: %s rad)\n', mat2str(errList));
for k = 1:numel(res.schemes)
    fprintf('%-20s %s\n', scheme_name(res.schemes{k}), sprintf('%8.2f', res.essr(:, k)));
end
end
