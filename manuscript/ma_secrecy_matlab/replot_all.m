%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations. Useful after changing plot styles.

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
list = {'fig1_accuracy', @plot_fig1; 'fig2_convergence', @plot_fig2; ...
        'fig3_essr_vs_power', @plot_fig3; 'fig4_essr_vs_angle', @plot_fig4; ...
        'fig5_essr_vs_region', @plot_fig5; 'fig7_single_user', @plot_fig7; ...
        'fig8_power_allocation', @plot_fig8};
for k = 1:size(list, 1)
    f = fullfile(results_dir(), [list{k,1} '.mat']);
    if exist(f, 'file')
        S = load(f);
        list{k,2}(S.res);
        fprintf('replotted %s\n', list{k,1});
    else
        fprintf('skipped %s (no results file)\n', list{k,1});
    end
end
