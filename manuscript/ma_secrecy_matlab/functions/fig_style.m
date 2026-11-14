function s = fig_style()
%FIG_STYLE  Common style of all figures, following the IEEE Author Center guidelines for
%   journal graphics: every panel is exported at the final size of one IEEE column
%   (3.5 in wide; two-column figures place two such panels side by side within the
%   7.16-in text width) and included with \includegraphics[width=\columnwidth], so that
%   all text appears at its nominal size in the article. All text (tick labels, axis
%   labels, legends, and in-plot labels) is 9 pt (IEEE: "approximately 9-10 point when
%   viewed at full size"), in Times (Liberation Serif, which is metric-compatible, is used
%   when Times New Roman is not installed). Raster output: 600 dpi (IEEE: > 600 dpi for
%   line art); MATLAB additionally exports vector PDF/EPS with embedded fonts.
%   Every series has its own color, marker, and line style, so that the figures remain
%   readable in grayscale.
s.width     = 3.5;                 % inches (one IEEE column)
s.height    = 2.6;                 % inches (aspect ratio 1.35; Octave's qt toolkit does
                                   % not render figures lower than about 2.4 in correctly)
s.font      = 'Times New Roman';
% Optional family override for headless renderers; numerical data are unchanged.
plotFont = getenv('MA_PLOT_FONT');
if ~isempty(plotFont), s.font = plotFont; end
s.fsTick    = 9;                   % tick labels
s.fsLabel   = 9;                   % axis labels
s.fsLegend  = 9;                   % legends and in-plot labels
s.lw        = 1.0;                 % default line width of the curves (pt)
s.ms        = 5;                   % marker size (hollow markers)
s.axLw      = 0.5;                 % axes and legend box line width (pt)
s.gridAlpha = 1;                   % grid drawn in a light gray (s.gridColor)
s.gridColor = [0.89 0.89 0.89];    % faint solid grid
s.legEdge   = [0.78 0.78 0.78];    % legend box color
s.edge      = [0.15 0.15 0.15];    % axes color
s.margins   = [0.48 0.44 0.12 0.08];   % axes margins [left bottom right top] (in)
s.legRow    = 0.17;                % legend row height (in)
s.legTok    = 0.24;                % length of the line samples in legends (in)
s.legGap    = 0.12;                % horizontal gap between legend columns (in)
end
