function res = fig6_region(prm)
%FIG6_REGION  Fig. 6(a) of main.tex: ESSR (Monte Carlo) versus the side length A of the
%   movable region C = [-A/2, A/2]^2. The FPA (compact lambda/2 UPA, aperture
%   1.5 x 0.5 lambda) and the antenna selection benchmark do not depend on A, whereas the
%   sparse UPA ('SPA_full') spans C. Fig. 6 also uses the
%   results of extra_as_region.m (panel (a)), extra_angle_offset.m and
%   extra_single_user.m (panel (b)), if available; otherwise, see replot_all.m.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'A', [1.5 2 3 4 5 6], main_schemes());
save(fullfile(results_dir(), 'fig6_region.mat'), 'res', 'prm', '-v7');
plot_fig6(res, load_results('extra_as_region'), load_results('extra_angle_offset'), ...
          load_results('extra_single_user'));
end
