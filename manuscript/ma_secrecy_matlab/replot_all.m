%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations, e.g., after changing the plot styles (fig_style.m,
%   scheme_style.m). In Octave, run under a display with the qt toolkit, e.g.,
%   xvfb-run -a octave --no-gui --eval replot_all

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
list = {'fig3_accuracy', @(r) plot_fig3(r); 'fig4_convergence', @(r) plot_fig4(r); ...
        'fig5_snr', @(r) plot_fig5(r); 'fig6_region', @(r) plot_fig6(r)};
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
f0 = fullfile(results_dir(), 'fig7_pa_identical.mat');
f1 = fullfile(results_dir(), 'fig7_pa_hetero.mat');
if exist(f0, 'file') && exist(f1, 'file')
    S0 = load(f0);  S1 = load(f1);
    plot_fig7(S0.res, S1.res);  close all;
    fprintf('replotted fig7_power_allocation\n');
end
f5 = fullfile(results_dir(), 'fig5_snr.mat');
if exist(f5, 'file')
    S = load(f5);
    if isfield(S.res, 'essr_tin'), print_table_eve(S.res, [10 20 30]); end
end
