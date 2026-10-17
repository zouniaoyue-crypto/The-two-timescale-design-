function h = plot_curve(ax, x, y, st, varargin)
%PLOT_CURVE  Draws one curve with the style st returned by scheme_style (line width st.lw
%   and marker face st.mfc if present). Extra name/value pairs are passed to plot.
s = fig_style();
[lw, mfc] = curve_style(st, s);
h = plot(ax, x, y, 'LineStyle', st.ls, 'Marker', st.marker, 'Color', st.color, ...
         'LineWidth', lw, 'MarkerSize', s.ms, 'MarkerFaceColor', mfc, ...
         'MarkerEdgeColor', st.color, varargin{:});
end
