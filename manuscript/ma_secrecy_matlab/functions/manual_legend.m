function manual_legend(fig, pos, items, colW, rowH)
%MANUAL_LEGEND  Legend drawn with the plotted symbols in an invisible overlay axes, so
%   that its size and layout are identical in MATLAB and Octave (the built-in legend
%   of Octave spreads multi-column legends and cannot be placed in inches).
%   fig   : figure handle (its Units must be inches)
%   pos   : [left bottom width height] of the legend box (inches)
%   items : cell array of rows; each row is a cell array of structs with the fields
%           name, color, ls (line style or 'none'), and marker ('none' for a line only);
%           an empty entry [] leaves a cell free
%   colW  : width of each column (inches), a scalar or one value per column
%   rowH  : height of each row (default s.legRow)
%   place_legend.m measures the text and computes pos and colW automatically.
s = fig_style();
if nargin < 5 || isempty(rowH), rowH = s.legRow; end
fp = get(fig, 'Position');  W = fp(3);  H = fp(4);
lax = axes('Parent', fig, 'Units', 'inches', 'Position', [0 0 W H], 'Visible', 'off', ...
           'XLim', [0 W], 'YLim', [0 H]);
hold(lax, 'on');
rectangle('Parent', lax, 'Position', pos, 'EdgeColor', s.legEdge, 'LineWidth', s.axLw, 'FaceColor', 'w');
tok = s.legTok;                                     % length of the line samples (in)
nr = numel(items);
nc = max(cellfun(@numel, items));
if isscalar(colW), colW = repmat(colW, 1, nc); end
x0 = pos(1) + 0.06 + [0, cumsum(colW(1:end-1))];   % left edge of each column
y0 = pos(2) + pos(4)/2 + (nr - 1)*rowH/2;           % center of the first row
for r = 1:nr
    y = y0 - (r - 1)*rowH;
    for c = 1:numel(items{r})
        it = items{r}{c};
        if isempty(it), continue; end
        x = x0(c);
        [lw, mfc] = curve_style(it, s);
        if ~strcmp(it.ls, 'none')
            plot(lax, x + [0 tok], [y y], 'LineStyle', it.ls, 'Color', it.color, 'LineWidth', lw);
        end
        if ~strcmp(it.marker, 'none')
            plot(lax, x + tok/2, y, 'LineStyle', 'none', 'Marker', it.marker, 'Color', it.color, ...
                 'MarkerSize', s.ms, 'LineWidth', lw, 'MarkerFaceColor', mfc, 'MarkerEdgeColor', it.color);
        end
        text(x + tok + 0.06, y, it.name, 'Parent', lax, 'FontName', s.font, ...
             'FontSize', s.fsLegend, 'VerticalAlignment', 'middle');
    end
end
end
