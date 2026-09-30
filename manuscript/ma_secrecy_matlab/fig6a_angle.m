function res = fig6a_angle(prm)
%FIG6A_ANGLE  Fig. 6(a) of main.tex: ESSR (Monte Carlo) versus the angular offset
%   Delta between Eve and LU 1 for M = 3 LUs (theta_e = theta_1 + Delta cos(phit),
%   phi_e = phi_1 + Delta sin(phit), phit ~ U[0, 2 pi)).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'Delta', [0.02 0.05 0.1 0.2 0.3 0.5], main_schemes());
save(fullfile(results_dir(), 'fig6a_angle.mat'), 'res', 'prm', '-v7');
plot_fig6(res, 'a');
end
