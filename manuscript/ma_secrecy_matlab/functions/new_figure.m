function ax = new_figure(width, height)
%NEW_FIGURE  Opens a figure of the given size (inches, default: one IEEE column)
%   and returns styled axes.
s = fig_style();
if nargin < 1 || isempty(width),  width  = s.width;  end
if nargin < 2 || isempty(height), height = s.height; end
f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 width height]);
set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 width height], 'PaperSize', [width height]);
ax = axes('Parent', f);
hold(ax, 'on');  box(ax, 'on');  grid(ax, 'on');
set(ax, 'FontName', s.font, 'FontSize', s.fsTick, 'LineWidth', s.axLw, 'TickDir', 'in', ...
        'GridLineStyle', ':', 'Layer', 'top');
try, set(ax, 'GridAlpha', 0.45, 'TickLength', [0.015 0.015]); catch, end   %#ok<CTCH>
end
