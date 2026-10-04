function h = axes_note(ax, x, y, str, halign, valign)
%AXES_NOTE  In-axes text in normalized axes coordinates (x, y in [0, 1]) with the legend
%   font, e.g., a curve-group label or the SNR of a panel.
s = fig_style();
if nargin < 5, halign = 'left'; end
if nargin < 6, valign = 'top'; end
h = text(x, y, str, 'Units', 'normalized', 'Parent', ax, 'FontName', s.font, ...
         'FontSize', s.fsLegend, 'HorizontalAlignment', halign, 'VerticalAlignment', valign);
end
