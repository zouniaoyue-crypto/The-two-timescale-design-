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
f0 = fullfile(results_dir(), 'fig8_power_allocation_0dB.mat');
f1 = fullfile(results_dir(), 'fig8_power_allocation_20dB.mat');
if exist(f0, 'file') && exist(f1, 'file')
    S0 = load(f0);  S1 = load(f1);
    plot_fig8(S0.res, S1.res);  close all;
    fprintf('replotted fig8_power_allocation\n');
end
