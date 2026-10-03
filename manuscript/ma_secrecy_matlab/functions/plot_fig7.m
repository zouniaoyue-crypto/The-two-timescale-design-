function plot_fig7(res)
%PLOT_FIG7  Fig. 7: ESSR versus the side length A of the movable region.
[Y, keys] = pick_schemes(res, 'essr');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
xlim(ax, [res.values(1) res.values(end)]);
yl = ylim(ax);  ymax = max(Y(:));
ylim(ax, [yl(1), ymax + 0.7*(ymax - yl(1))]);        % head room for the legend
add_legend(ax, h, names, 'north', 2);
save_figure('fig7_essr_region');
end
