function ax = new_figure(width, height)
%NEW_FIGURE  Opens a figure of the given size (inches, default: one IEEE column) and
%   returns styled axes with fixed margins (s.margins), so that all figures share the
%   same layout and no label is clipped.
s = fig_style();
if nargin < 1 || isempty(width),  width  = s.width;  end
if nargin < 2 || isempty(height), height = s.height; end
f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 width height]);
set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 width height], 'PaperSize', [width height]);
m = s.margins;                                            % [left bottom right top] (in)
ax = axes('Parent', f, 'Units', 'inches', ...
          'Position', [m(1), m(2), width - m(1) - m(3), height - m(2) - m(4)]);
style_axes(ax);
end
