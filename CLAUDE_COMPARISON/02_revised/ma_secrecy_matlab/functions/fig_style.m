function s = fig_style()
%FIG_STYLE  Common style of all figures (IEEE two-column format).
%   Every panel is exported at the width of one IEEE column (3.5 in) and included with
%   \includegraphics[width=\columnwidth], also as a subfigure of a figure*, so that all
%   panels have the same size and the fonts appear at their nominal sizes: 8-pt tick labels, 9-pt axis labels, and 7-pt
%   legends and annotations, in Times (Liberation Serif, which is metric-compatible,
%   is used when Times New Roman is not installed). All font sizes are integers, which
%   keeps the glyph spacing correct in all export formats.
s.width     = 3.5;                 % inches
s.height    = 2.45;                % inches (single panel; Octave's qt toolkit does not
                                   % render figures lower than about 2.4 in correctly)
s.font      = 'Times New Roman';
% Optional family override for headless renderers; numerical data are unchanged.
plotFont = getenv('MA_PLOT_FONT');
if ~isempty(plotFont), s.font = plotFont; end
s.fsTick    = 8;                   % tick labels
s.fsLabel   = 9;                   % axis labels
s.fsLegend  = 7;                   % legends and in-axes annotations
s.lw        = 1.0;                 % default line width of the curves
s.ms        = 4.5;                 % marker size (hollow markers)
s.axLw      = 0.5;                 % axes and legend box line width
s.gridAlpha = 1;                   % grid drawn in a light gray (s.gridColor)
s.gridColor = [0.89 0.89 0.89];    % faint solid grid
s.legEdge   = [0.78 0.78 0.78];    % legend box color
s.edge      = [0.15 0.15 0.15];    % axes color
s.margins   = [0.46 0.40 0.12 0.08];   % axes margins [left bottom right top] (in)
end
