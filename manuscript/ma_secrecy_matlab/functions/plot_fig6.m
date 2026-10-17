function plot_fig6(resA, resAS, resD3, resD1)
%PLOT_FIG6  Fig. 6: (a) ESSR versus the side length A of the movable region, including the
%   AS benchmark whose 2N candidate antennas span the region ('AS_region', resAS from
%   extra_as_region.m); (b) ESSR versus the angular separation Delta between Eve and LU 1 for
%   M = 3 (resD3, extra_angle_offset.m) and M = 1 (resD1, extra_single_user.m). For M = 1,
%   the rate-oriented MA coincides with the FPA and is therefore not drawn.
s = fig_style();
% ---------------- (a) region size ----------------
[Y, keys] = pick_schemes(resA, 'essr');
ax = new_figure();
items = {};
for k = 1:numel(keys)
    st = scheme_style(keys{k});
    plot_curve(ax, resA.values, Y(:, k), st);
    items{end+1} = st; %#ok<AGROW>
end
if nargin >= 2 && ~isempty(resAS)
    st = scheme_style('AS_region');
    plot_curve(ax, resAS.values, resAS.essr(:, 1), st);
    items = [items(1:3), {st}, items(4:end)];
end
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resA.values(1) resA.values(end)], 'XTick', resA.values, 'YLim', [15 25], 'YTick', 15:2:25);
m = s.margins;
manual_legend(gcf, [m(1) + 0.06, m(2) + 1.97 - 0.80, 1.42, 0.76], cellfun(@(c) {c}, items, 'UniformOutput', false), 1.4, 0.14);
save_figure('fig6a_essr_region');
if nargin < 4 || isempty(resD3) || isempty(resD1), return; end
% ---------------- (b) angular separation, M = 3 and M = 1 ----------------
ax = new_figure();
keys = main_schemes();  items = {};
for k = 1:numel(keys)
    st = scheme_style(keys{k});
    j = find(strcmp(resD3.schemes, keys{k}), 1);
    h = plot_curve(ax, resD3.values, resD3.essr(:, j), st);
    items{end+1} = st; %#ok<AGROW>
    if ~strcmp(keys{k}, 'MA_rate')                      % coincides with the FPA for M = 1
        j = find(strcmp(resD1.schemes, keys{k}), 1);
        plot_curve(ax, resD1.values, resD1.essr(:, j), st);
    end
end
label_axes(ax, 'Angular separation {\it\Delta} (rad)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [0 0.5], 'XTick', 0:0.1:0.5, 'YLim', [0 25], 'YTick', 0:5:25);
axes_note(ax, 0.97, 0.97, '{\itM} = 3', 'right', 'top');
axes_note(ax, 0.97, 0.21, '{\itM} = 1', 'right', 'top');
manual_legend(gcf, [m(1) + 0.35, m(2) + 0.78, 2.30, 0.34], {items(1:2), items(3:4)}, 1.12, 0.15);
save_figure('fig6b_essr_offset');
end
