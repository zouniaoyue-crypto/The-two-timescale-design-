function manual_legend(fig, pos, items, colW, rowH)
%MANUAL_LEGEND  Legend drawn with the plotted symbols in an invisible overlay axes, so
%   that its size and layout are identical in MATLAB and Octave (the built-in legend
%   of Octave spreads multi-column legends and cannot be placed in inches).
%   fig   : figure handle (its Units must be inches)
%   pos   : [left bottom width height] of the legend box (inches)
%   items : cell array of rows; each row is a cell array of structs with the fields
%           name, color, ls (line style or 'none'), and marker ('none' for a line only)
%   colW  : width of each column (inches), rowH: height of each row (default 0.15 in)
s = fig_style();
if nargin < 5, rowH = 0.15; end
fp = get(fig, 'Position');  W = fp(3);  H = fp(4);
lax = axes('Parent', fig, 'Units', 'inches', 'Position', [0 0 W H], 'Visible', 'off', ...
           'XLim', [0 W], 'YLim', [0 H]);
hold(lax, 'on');
rectangle('Parent', lax, 'Position', pos, 'EdgeColor', s.edge, 'LineWidth', s.axLw, 'FaceColor', 'w');
tok = 0.24;                                         % length of the line samples (in)
nr = numel(items);
y0 = pos(2) + pos(4)/2 + (nr - 1)*rowH/2;           % center of the first row
for r = 1:nr
    y = y0 - (r - 1)*rowH;
    for c = 1:numel(items{r})
        it = items{r}{c};
        if isempty(it), continue; end
        x = pos(1) + 0.06 + (c - 1)*colW;
        if ~strcmp(it.ls, 'none')
            plot(lax, x + [0 tok], [y y], 'LineStyle', it.ls, 'Color', it.color, 'LineWidth', s.lw);
        end
        if ~strcmp(it.marker, 'none')
            plot(lax, x + tok/2, y, 'LineStyle', 'none', 'Marker', it.marker, 'Color', it.color, ...
                 'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
        end
        text(x + tok + 0.06, y, it.name, 'Parent', lax, 'FontName', s.font, ...
             'FontSize', s.fsLegend, 'VerticalAlignment', 'middle');
    end
end
end
