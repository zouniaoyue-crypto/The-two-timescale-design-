function plot_fig6(res, part)
%PLOT_FIG6  Fig. 6: ESSR versus the angular offset Delta between Eve and LU 1 for
%   (a) M = 3 and (b) M = 1 (for M = 1, the rate-oriented MA coincides with the
%   compact FPA). Logarithmic Delta axis.
keys = res.schemes;
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, res.essr, keys);
set(ax, 'XScale', 'log', 'XTick', res.values, 'XTickLabel', arrayfun(@num2str, res.values, 'UniformOutput', false));
xlim(ax, [res.values(1)*0.9 res.values(end)*1.1]);
if part == 'a'
    label_axes(ax, 'Angular offset {\Delta} between Eve and LU 1 (rad)', 'ESSR (bps/Hz)');
else
    label_axes(ax, 'Angular offset {\Delta} between Eve and the LU (rad)', 'Ergodic secrecy rate (bps/Hz)');
end
ymax = max(res.essr(:));
if part == 'a'                % all curves lie well above zero: legend in the lower part
    ylim(ax, [0 1.12*ymax]);
    add_legend(ax, h, names, 'south', 2);
else                          % single LU: legend above the curves
    ylim(ax, [0 1.55*ymax]);
    add_legend(ax, h, names, 'north', 2);
end
if part == 'a', save_figure('fig6a_essr_angle'); else, save_figure('fig6b_essr_single_user'); end
end
