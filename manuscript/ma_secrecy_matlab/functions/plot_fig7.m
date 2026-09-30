function plot_fig7(res)
%PLOT_FIG7  Fig. 7: ESSR versus the side length A of the movable region.
keys = res.schemes;
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, res.essr, keys);
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
xlim(ax, [res.values(1) res.values(end)]);
yl = ylim(ax);  ylim(ax, [yl(1) yl(2) + 0.35*(yl(2) - yl(1))]);
add_legend(ax, h, names, 'north', 2);
save_figure('fig7_essr_region');
end
