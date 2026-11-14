function pos = place_legend(ax, items, where, dx, dy)
%PLACE_LEGEND  Draws a legend (manual_legend.m) inside the axes ax, with column widths
%   computed from the text of its entries (text_width.m), so that the legend fits its
%   text at any font size. items: cell array of rows (see manual_legend.m); an entry
%   with the field span = true may extend over the following empty columns of its row
%   and is not used to size its column.
%   where: two letters, vertical ('n' top, 's' bottom) and horizontal ('w' left,
%   'e' right, 'c' centered), e.g., 'nw'; dx, dy: distances (in) from the axes edges
%   (default 0.05 in). Returns the legend box [left bottom width height] (in).
s = fig_style();
if nargin < 3 || isempty(where), where = 'nw'; end
if nargin < 4 || isempty(dx), dx = 0.05; end
if nargin < 5 || isempty(dy), dy = 0.05; end
fig = get(ax, 'Parent');
nc = max(cellfun(@numel, items));
w = zeros(1, nc);  wSpan = 0;
for r = 1:numel(items)
    for c = 1:numel(items{r})
        it = items{r}{c};
        if isempty(it), continue; end
        e = text_width(it.name, s.fsLegend);       % from the Times font metrics (in)
        if isfield(it, 'span') && it.span
            wSpan = max(wSpan, e);
        else
            w(c) = max(w(c), e);
        end
    end
end
colW = s.legTok + 0.06 + w + s.legGap;          % sample, gap, text, gap to the next column
width = 0.06 + sum(colW) - s.legGap + 0.06;
width = max(width, 0.06 + s.legTok + 0.06 + wSpan + 0.06);
height = numel(items)*s.legRow + 0.06;
p = get(ax, 'Position');                          % axes position (in)
switch where(2)
    case 'w', x = p(1) + dx;
    case 'e', x = p(1) + p(3) - dx - width;
    otherwise, x = p(1) + (p(3) - width)/2 + dx;
end
if where(1) == 'n', y = p(2) + p(4) - dy - height; else, y = p(2) + dy; end
pos = [x, y, width, height];
manual_legend(fig, pos, items, colW);
end
