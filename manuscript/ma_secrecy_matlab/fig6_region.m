function res = fig6_region(prm)
%FIG6_REGION  Fig. 6 of main.tex: ESSR (Monte Carlo) versus the side length A of the
%   movable region C = [-A/2, A/2]^2. The FPA (compact lambda/2 UPA, aperture
%   1.5 x 0.5 lambda) and the antenna selection benchmark do not depend on A. The sparse
%   UPA spanning C ('SPA_full') is also evaluated and quoted in the text.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'A', [1.5 2 3 4 5 6], [main_schemes(), {'SPA_full'}]);
save(fullfile(results_dir(), 'fig6_region.mat'), 'res', 'prm', '-v7');
plot_fig6(res);
end
