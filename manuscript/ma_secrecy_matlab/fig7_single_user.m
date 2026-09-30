function res = fig7_single_user(prm)
%FIG7_SINGLE_USER  Single-LU case (M = 1, Remark 3 of main.tex). For M = 1 the ergodic
%   rate of the LU does not depend on the antenna positions for a given power, whereas
%   the leakage and the AN received by Eve do. Plots the Monte Carlo ESSR (fig7a) and
%   the optimized AN power fraction (fig7b) versus the angular offset Delta.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.M = 1;
Dvec = [0.02 0.05 0.1 0.2 0.3 0.5];
schemes = {'MA_full', 'FPA_full', 'SPA_full'};
res = sweep_schemes(prm, 'Delta', Dvec, schemes);
save(fullfile(results_dir(), 'fig7_single_user.mat'), 'res', 'prm', '-v7');
plot_fig7(res);
end
