function plot_fig7(resD1)
%PLOT_FIG7  Fig. 7: ergodic secrecy rate of a single LU (M = 1) versus the AoD offset
%   Delta between Eve and the LU (resD1, extra_single_user.m). For M = 1, the
%   rate-oriented MA keeps its UPA initialization and coincides with the FPA (its
%   objective does not depend on the positions); the FPA curve is drawn on top of it, and
%   the two curves are labeled in the plot. The results for M = 3
%   (extra_angle_offset.m) are quoted in Section V-F without a figure.
if nargin < 1 || isempty(resD1), return; end
s = fig_style();
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
ax = new_figure();
for k = numel(keys):-1:1                           % reverse order: the proposed design on top
    j = find(strcmp(resD1.schemes, keys{k}), 1);
    plot_curve(ax, resD1.values, resD1.essr(:, j), items{k});
end
k = find(strcmp(keys, 'FPA_full'), 1);             % FPA on top of the identical
j = find(strcmp(resD1.schemes, 'FPA_full'), 1);    % rate-oriented MA curve
plot_curve(ax, resD1.values, resD1.essr(:, j), items{k});
label_axes(ax, 'AoD offset {\it\Delta} (rad)', 'Ergodic secrecy rate (bps/Hz)');
set(ax, 'XLim', [0 0.5], 'XTick', 0:0.1:0.5, 'YLim', [3 12], 'YTick', 3:1:12);
text(0.49, 4.85, 'Rate-oriented MA = FPA', 'Parent', ax, 'FontName', s.font, ...
     'FontSize', s.fsLegend, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
place_legend(ax, {items([1 4]), items([2 5]), items(3)}, 'nw');
save_figure('fig7_essr_offset');
end
