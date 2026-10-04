function res = extra_single_user(prm)
%EXTRA_SINGLE_USER  Single-LU case (M = 1, Remark 3): ergodic secrecy rate (Monte Carlo)
%   and AN power fraction versus the angular offset Delta between Eve and the LU. The
%   ergodic rate of the LU does not depend on the antenna positions for a given power, so
%   that the rate-oriented MA design keeps its initial positions (compact UPA) and
%   coincides with the FPA, whereas the proposed design reduces the leakage. The results
%   are quoted in Section V-E of main.tex (no figure).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.M = 1;
res = sweep_schemes(prm, 'Delta', [0.02 0.05 0.1 0.2 0.3 0.5], [main_schemes(), {'SPA_full'}]);
save(fullfile(results_dir(), 'extra_single_user.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'Delta (rad)');
end
