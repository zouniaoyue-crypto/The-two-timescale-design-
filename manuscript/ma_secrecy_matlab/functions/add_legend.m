function lg = add_legend(ax, h, names, loc, ncol)
%ADD_LEGEND  Legend with the common style (7-pt Times, thin dark box, white background).
s = fig_style();
if nargin < 4 || isempty(loc), loc = 'best'; end
lg = legend(ax, h, names, 'Location', loc, 'FontName', s.font, 'FontSize', s.fsLegend);
set(lg, 'Box', 'on', 'Color', 'w', 'EdgeColor', s.edge, 'LineWidth', s.axLw);
if nargin >= 5 && ncol > 1
    try, set(lg, 'NumColumns', ncol); catch, end   %#ok<CTCH>   (MATLAB R2018a+, Octave 7+)
end
if ~exist('OCTAVE_VERSION', 'builtin')
    try, lg.ItemTokenSize = [20 8]; catch, end   %#ok<CTCH>   (shorter line samples)
end
end
