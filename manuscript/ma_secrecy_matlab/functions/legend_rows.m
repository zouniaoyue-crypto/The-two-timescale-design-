function rows = legend_rows(items, nc)
%LEGEND_ROWS  Arranges the legend entries items (cell array of styles) row-wise in nc
%   columns for place_legend.m; the last row is padded with empty entries.
nr = ceil(numel(items)/nc);
rows = cell(1, nr);
for r = 1:nr
    rows{r} = cell(1, nc);
    for c = 1:nc
        k = (r - 1)*nc + c;
        if k <= numel(items), rows{r}{c} = items{k}; else, rows{r}{c} = []; end
    end
end
end
