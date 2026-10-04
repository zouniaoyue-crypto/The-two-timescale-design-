function plot_fig6(res)
%PLOT_FIG6  Fig. 6: ESSR versus the side length A of the movable region for the schemes
%   in main_schemes.m (the FPA and antenna selection do not depend on A).
[Y, keys] = pick_schemes(res, 'essr');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [15 24], 'YTick', 15:2:23);
add_legend(ax, h, names, 'north', 2);                % two columns above the curves
save_figure('fig6_essr_region');
end
