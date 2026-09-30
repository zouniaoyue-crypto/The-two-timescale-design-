function res = fig5_essr_vs_region(prm)
%FIG5_ESSR_VS_REGION  ESSR (Monte Carlo) versus the side length A of the movable
%   region C = [-A/2, A/2]^2. The lambda/2 UPA (aperture 1.5 lambda x 0.5 lambda)
%   does not depend on A; the sparse FPA spans C.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
Avec = [1.5 2 3 4 5 6];
schemes = {'MA_full', 'FPA_full', 'SPA_full'};
names = {'Proposed MA (opt. t, p, q)', 'FPA (\lambda/2 UPA), opt. p, q', 'Sparse FPA, opt. p, q'};
res = sweep_schemes(prm, 'A', Avec, schemes);
res.names = names;
save(fullfile(results_dir(), 'fig5_essr_vs_region.mat'), 'res', 'prm', '-v7');
plot_fig5(res);
end
