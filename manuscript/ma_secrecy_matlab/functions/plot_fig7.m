function plot_fig7(resA, resN)
%PLOT_FIG7  Fig. 7: (a) ESSR versus the side length A of the movable region (resA,
%   fig7_region.m); (b) ESSR versus the number of MAs N (resN, extra_num_antennas.m).
%   Both panels show the schemes in main_schemes.m, including the sparse FPA spanning the
%   movable region and AS with the compact candidate array, whose subset is selected by the
%   swap search (as_swap.m) for all N, as in Figs. 5 and 8. AS with region-wide candidates
%   (extra_as_region.m) is a supplementary result and is not plotted. The legend is shared
%   by Figs. 5, 7, and 8 and saved separately (plot_legend_strip.m, results/legend_main_schemes).
s = fig_style();
% ---------------- (a) region size ----------------
[Y, keys] = pick_schemes(resA, 'essr');
ax = new_figure();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    plot_curve(ax, resA.values, Y(:, k), items{k});
end
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resA.values(1) resA.values(end)], 'XTick', resA.values, 'YLim', [14 24], 'YTick', 14:2:24);
save_figure('fig7a_essr_region');
plot_legend_strip('legend_main_schemes', items);   % one row above both panels (main.tex)
if nargin < 2 || isempty(resN), return; end
% ---------------- (b) number of MAs ----------------
ax = new_figure();
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    j = find(strcmp(resN.schemes, keys{k}), 1);
    plot_curve(ax, resN.values, resN.essr(:, j), items{k});
end
label_axes(ax, 'Number of MAs {\itN}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resN.values(1) resN.values(end)], 'XTick', resN.values, 'YLim', [10 24], 'YTick', 10:2:24);
save_figure('fig7b_essr_antennas');
end
