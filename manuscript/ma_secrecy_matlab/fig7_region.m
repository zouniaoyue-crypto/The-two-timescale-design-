function res = fig7_region(prm)
%FIG7_REGION  Fig. 7 of main.tex: ESSR (Monte Carlo) versus the side length A of the
%   movable region C = [-A/2, A/2]^2. The compact lambda/2 UPA (aperture 1.5 x 0.5
%   lambda) does not depend on A; the sparse UPA spans C.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'A', [1.5 2 3 4 5 6], main_schemes());
save(fullfile(results_dir(), 'fig7_region.mat'), 'res', 'prm', '-v7');
plot_fig7(res);
end
