function plot_fig7(resD3, resD1)
%PLOT_FIG7  Fig. 7: ESSR versus the AoD offset Delta between Eve and LU 1 for (a) M = 3
%   (resD3, extra_angle_offset.m) and (b) M = 1 (resD1, extra_single_user.m), each with its
%   own y-axis range. For M = 1, the rate-oriented MA keeps its UPA initialization and thus
%   coincides with the FPA; the FPA curve is redrawn on top of it, and the two curves are
%   labeled in the plot.
s = fig_style();
m = s.margins;
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
lg = {items([1 4]), items([2 5]), items(3)};
% ---------------- (a) M = 3 ----------------
if ~isempty(resD3)
    ax = draw_panel(resD3, keys, items);
    set(ax, 'YLim', [14 26], 'YTick', 14:2:26);
    manual_legend(gcf, [m(1) + 0.06, m(2) + 1.97 - 0.50, 2.30, 0.46], lg, 1.15, 0.14);
    save_figure('fig7a_essr_offset_M3');
end
% ---------------- (b) M = 1 ----------------
if nargin >= 2 && ~isempty(resD1)
    ax = draw_panel(resD1, keys, items);
    k = find(strcmp(keys, 'FPA_full'), 1);         % FPA on top of the identical
    j = find(strcmp(resD1.schemes, 'FPA_full'), 1);    % rate-oriented MA curve
    plot_curve(ax, resD1.values, resD1.essr(:, j), items{k});
    set(ax, 'YLim', [3 11], 'YTick', 3:1:11);
    axes_note(ax, 0.97, 0.29, 'Rate-oriented MA = FPA', 'right', 'top');
    manual_legend(gcf, [m(1) + 0.06, m(2) + 1.97 - 0.50, 2.30, 0.46], lg, 1.15, 0.14);
    save_figure('fig7b_essr_offset_M1');
end
end

function ax = draw_panel(res, keys, items)
ax = new_figure();
for k = numel(keys):-1:1                           % reverse order: the proposed design on top
    j = find(strcmp(res.schemes, keys{k}), 1);
    plot_curve(ax, res.values, res.essr(:, j), items{k});
end
label_axes(ax, 'AoD offset {\it\Delta} (rad)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [0 0.5], 'XTick', 0:0.1:0.5);
end
