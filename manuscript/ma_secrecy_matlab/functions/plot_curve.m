function h = plot_curve(ax, x, y, st, varargin)
%PLOT_CURVE  Draws one curve with the style st returned by scheme_style (hollow
%   markers with white faces). Extra name/value pairs are passed to plot.
s = fig_style();
h = plot(ax, x, y, 'LineStyle', st.ls, 'Marker', st.marker, 'Color', st.color, ...
         'LineWidth', s.lw, 'MarkerSize', s.ms, 'MarkerFaceColor', 'w', varargin{:});
end
