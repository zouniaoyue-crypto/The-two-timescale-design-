function plot_fig7(resA, resN)
%PLOT_FIG7  Fig. 7: (a) ESSR versus the side length A of the movable region (resA,
%   fig7_region.m); (b) ESSR versus the number of MAs N (resN, extra_num_antennas.m).
%   Both panels show the schemes in main_schemes.m (proposed, rate-oriented MA, FPA with
%   Eve-aware AN, and FPA), as in Figs. 5 and 8. Each panel has its own two-column legend
%   inside the axes: (a) in the upper-left area, (b) in the lower-right area, below the
%   curves (y-axis from 6 bps/Hz).
% ---------------- (a) region size ----------------
[Y, keys] = pick_schemes(resA, 'essr');
ax = new_figure();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    plot_curve(ax, resA.values, Y(:, k), items{k});
end
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resA.values(1) resA.values(end)], 'XTick', resA.values, 'YLim', [14 26], 'YTick', 14:2:26);
place_legend(ax, legend_rows(items, 2), 'nw');
save_figure('fig7a_essr_region');
if nargin < 2 || isempty(resN), return; end
% ---------------- (b) number of MAs ----------------
[Y, keys] = pick_schemes(resN, 'essr');
ax = new_figure();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    plot_curve(ax, resN.values, Y(:, k), items{k});
end
label_axes(ax, 'Number of MAs {\itN}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resN.values(1) resN.values(end)], 'XTick', resN.values, 'YLim', [6 24], 'YTick', 6:2:24);
place_legend(ax, legend_rows(items, 2), 'se');
save_figure('fig7b_essr_antennas');
end
