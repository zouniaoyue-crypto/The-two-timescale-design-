%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations. Useful after changing plot styles (fig_style.m,
%   scheme_style.m).

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
list = {'fig3_accuracy', @(r) plot_fig3(r); 'fig4_convergence', @(r) plot_fig4(r); ...
        'fig5_snr', @(r) plot_fig5(r); 'fig6a_angle', @(r) plot_fig6(r, 'a'); ...
        'fig6b_single_user', @(r) plot_fig6(r, 'b'); 'fig7_region', @(r) plot_fig7(r)};
for k = 1:size(list, 1)
    f = fullfile(results_dir(), [list{k,1} '.mat']);
    if exist(f, 'file')
        S = load(f);
        list{k,2}(S.res);
        close all;
        fprintf('replotted %s\n', list{k,1});
    else
        fprintf('skipped %s (no results file)\n', list{k,1});
    end
end
prm = default_params();
fa = fullfile(results_dir(), sprintf('fig8_pa_%ddB.mat', prm.fig8SNR(1)));
fb = fullfile(results_dir(), sprintf('fig8_pa_%ddB.mat', prm.fig8SNR(2)));
if exist(fa, 'file') && exist(fb, 'file')
    Sa = load(fa);  Sb = load(fb);
    plot_fig8(Sa.res, Sb.res);  close all;
    fprintf('replotted fig8_power_allocation\n');
end
f5 = fullfile(results_dir(), 'fig5_snr.mat');
if exist(f5, 'file')
    S = load(f5);
    if isfield(S.res, 'essr_tin'), print_table2(S.res, [10 20 30]); end
end
