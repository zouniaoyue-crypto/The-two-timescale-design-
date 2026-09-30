function res = fig4_essr_vs_angle(prm)
%FIG4_ESSR_VS_ANGLE  ESSR (Monte Carlo) versus the angular offset Delta between Eve
%   and LU 1 (theta_e = theta_1 + Delta cos(phit), phi_e = phi_1 + Delta sin(phit), phit ~ U[0, 2 pi)).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
Dvec = [0.02 0.05 0.1 0.2 0.3 0.5];
schemes = {'MA_full', 'MA_EPA', 'FPA_full', 'SPA_full'};
res = sweep_schemes(prm, 'Delta', Dvec, schemes);
save(fullfile(results_dir(), 'fig4_essr_vs_angle.mat'), 'res', 'prm', '-v7');
plot_fig4(res);
end
