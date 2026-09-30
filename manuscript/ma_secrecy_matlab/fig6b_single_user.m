function res = fig6b_single_user(prm)
%FIG6B_SINGLE_USER  Fig. 6(b) of main.tex: single-LU case (M = 1, Remark 3). The
%   ergodic rate of the LU does not depend on the antenna positions for a given power,
%   so that the rate-oriented MA design keeps its initial positions (compact UPA) and
%   coincides with the compact FPA, whereas the proposed design reduces the leakage.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.M = 1;
res = sweep_schemes(prm, 'Delta', [0.02 0.05 0.1 0.2 0.3 0.5], main_schemes());
save(fullfile(results_dir(), 'fig6b_single_user.mat'), 'res', 'prm', '-v7');
plot_fig6(res, 'b');
end
