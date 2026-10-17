function plot_fig6(resA, resAS, resN)
%PLOT_FIG6  Fig. 6: (a) ESSR versus the side length A of the movable region, including the
%   AS benchmark whose 2N candidate antennas span the region ('AS_region', resAS from
%   extra_as_region.m); (b) ESSR versus the number of MAs N (resN, extra_num_antennas.m),
%   where AS is drawn only for N <= 10 (exhaustive search over nchoosek(2N, N) subsets).
%   Both panels include the sparse FPA spanning the movable region (main_schemes.m).
s = fig_style();
% ---------------- (a) region size ----------------
[Y, keys] = pick_schemes(resA, 'essr');
ax = new_figure();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
if nargin >= 2 && ~isempty(resAS)
    st = scheme_style('AS_region');
    plot_curve(ax, resAS.values, resAS.essr(:, 1), st);
end
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    plot_curve(ax, resA.values, Y(:, k), items{k});
end
if nargin >= 2 && ~isempty(resAS)
    items = [items(1:3), {st}, items(4:end)];
end
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resA.values(1) resA.values(end)], 'XTick', resA.values, 'YLim', [15 25], 'YTick', 15:2:25);
m = s.margins;
if numel(items) == 6                           % two columns above the curves
    lg = {items([1 4]), items([2 5]), items([3 6])};
else
    lg = cellfun(@(c) {c}, items, 'UniformOutput', false);
end
manual_legend(gcf, [m(1) + 0.06, m(2) + 1.97 - 0.50, 2.80, 0.46], lg, 1.38, 0.14);
save_figure('fig6a_essr_region');
if nargin < 3 || isempty(resN), return; end
% ---------------- (b) number of MAs ----------------
ax = new_figure();
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
for k = numel(keys):-1:1                       % reverse order: the proposed design on top
    j = find(strcmp(resN.schemes, keys{k}), 1);
    plot_curve(ax, resN.values, resN.essr(:, j), items{k});   % NaN (AS for N > 10): not drawn
end
label_axes(ax, 'Number of MAs {\itN}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resN.values(1) resN.values(end)], 'XTick', resN.values, 'YLim', [8 24], 'YTick', 8:2:24);
manual_legend(gcf, [m(1) + 2.92 - 2.30, m(2) + 0.06, 2.24, 0.46], {items([1 4]), items([2 5]), items(3)}, 1.12, 0.14);
save_figure('fig6b_essr_antennas');
end
