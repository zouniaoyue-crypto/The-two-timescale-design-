function style_axes(ax)
%STYLE_AXES  Applies the common axes style: box, light solid grid, inward ticks,
%   Times fonts, and thin dark axes lines drawn on top of the curves.
s = fig_style();
hold(ax, 'on');  box(ax, 'on');  grid(ax, 'on');
set(ax, 'FontName', s.font, 'FontSize', s.fsTick, 'LineWidth', s.axLw, 'TickDir', 'in', ...
        'GridLineStyle', '-', 'XColor', s.edge, 'YColor', s.edge, 'Layer', 'top');
try, set(ax, 'GridAlpha', s.gridAlpha, 'GridColor', [0 0 0], 'TickLength', [0.012 0.012]); catch, end %#ok<CTCH>
try, set(ax, 'XMinorGrid', 'off', 'YMinorGrid', 'off'); catch, end %#ok<CTCH>
end
