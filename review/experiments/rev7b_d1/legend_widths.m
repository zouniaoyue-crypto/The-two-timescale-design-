function legend_widths()
%LEGEND_WIDTHS  Widths (in) of the candidate legend strips at 9 pt (text_width.m metrics and
%   the column layout of plot_legend_strip.m). Rows: entries 1-4 and 5-7 of the full set;
%   the five-entry set (schemes 1, 3-6) of Figs. 6-7 in one row.
s = fig_style();
A = {'Proposed (opt {\bf t}, {\bf p}, {\it q})', 'MA (opt {\bf t}, equal {\bf p}, {\it q})', ...
     'Rate-oriented MA (opt {\bf p}, {\it q})', 'AS (opt {\bf p}, {\it q})', ...
     'Sparse FPA (opt {\bf p}, {\it q})', 'FPA (opt {\bf p}, {\it q})', 'FPA (equal {\bf p}, {\it q})'};
B = {'Proposed', 'MA, equal power', 'Rate-oriented MA', 'AS', 'Sparse FPA', 'FPA', 'FPA, equal power'};
C = {'MA: {\bf t}^*, {\bf p}^*, {\it q}^* (proposed)', 'MA: {\bf t}^*, equal {\bf p}, {\it q}', ...
     'MA: {\bf t}_{rate}, {\bf p}^*, {\it q}^*', 'AS: {\bf p}^*, {\it q}^*', ...
     'Sparse FPA: {\bf p}^*, {\it q}^*', 'FPA: {\bf p}^*, {\it q}^*', 'FPA: equal {\bf p}, {\it q}'};
sets = {A, B, C};  nm = 'ABC';
strip = @(L) 0.06 + sum(s.legTok + 0.06 + cellfun(@(x) text_width(x, s.fsLegend), L) + s.legGap) - s.legGap + 0.06;
for k = 1:3
    L = sets{k};
    printf('Set %s: 7 entries in one row %.2f in; rows 1-4 / 5-7: %.2f + %.2f in; 5 entries (1,3-6) one row %.2f in\n', ...
        nm(k), strip(L), strip(L(1:4)), strip(L(5:7)), strip(L([1 3 4 5 6])));
end
end
