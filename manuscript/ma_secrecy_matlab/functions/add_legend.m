function lg = add_legend(ax, h, names, loc, ncol)
%ADD_LEGEND  Legend with the common style.
s = fig_style();
if nargin < 4 || isempty(loc), loc = 'best'; end
lg = legend(ax, h, names, 'Location', loc, 'FontName', s.font, 'FontSize', s.fsLegend);
set(lg, 'Box', 'on', 'Color', 'w', 'EdgeColor', [0.3 0.3 0.3]);
if nargin >= 5 && ncol > 1
    try, set(lg, 'NumColumns', ncol); catch, end   %#ok<CTCH>   (MATLAB R2018a+)
end
if ~exist('OCTAVE_VERSION', 'builtin')
    try, lg.ItemTokenSize = [22 9]; catch, end   %#ok<CTCH>   (shorter line samples)
end
end
