function res = extra_angle_offset(prm)
%EXTRA_ANGLE_OFFSET  ESSR (Monte Carlo) versus the AoD offset Delta between Eve and
%   LU 1 for M = 3 LUs (theta_e = theta_1 + Delta cos(phit), phi_e = phi_1 + Delta sin(phit),
%   phit ~ U[0, 2 pi)). Fig. 7(a) of main.tex (M = 3).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'Delta', [0.02 0.05 0.1 0.2 0.3 0.5], main_schemes());
save(fullfile(results_dir(), 'extra_angle_offset.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'Delta (rad)');
end
