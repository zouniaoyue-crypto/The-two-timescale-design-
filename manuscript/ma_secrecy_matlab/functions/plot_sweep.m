function plot_sweep(res, x, xl, yl, field, names, loc, sel, styleIdx)
%PLOT_SWEEP  Plots res.(field)(:, k) versus x for the schemes k in sel.
%   styleIdx(j) selects the line style/color of the j-th plotted scheme
%   (default: styleIdx = sel), so that a scheme keeps its style across figures.
if nargin < 8 || isempty(sel), sel = 1:numel(names); end
if nargin < 9, styleIdx = sel; end
styles = {'-o', '-s', '-^', '--o', '--d', '--^', ':v', ':x'};
colors = {[0 0.447 0.741], [0.850 0.325 0.098], [0.466 0.674 0.188], ...
          [0.494 0.184 0.556], [0.929 0.694 0.125], [0.301 0.745 0.933], [0.635 0.078 0.184], [0 0 0]};
new_figure();
Y = res.(field);
for j = 1:numel(sel)
    s = styleIdx(j);
    plot(x, Y(:, sel(j)), styles{s}, 'Color', colors{s}, 'LineWidth', 1.6, 'MarkerSize', 7);
end
xlabel(xl);  ylabel(yl);
legend(names(sel), 'Location', loc, 'FontSize', 9);
end
