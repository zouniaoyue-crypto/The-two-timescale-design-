function s = fig_style()
%FIG_STYLE  Common style of all figures (IEEE two-column format).
%   Every panel is exported at the width of one IEEE column (3.5 in) and included with
%   \includegraphics[width=\columnwidth] (or 0.48\textwidth in a figure*), so that the
%   fonts appear at their nominal sizes: 8-pt tick labels, 9-pt axis labels, and 7-pt
%   legends and annotations, in Times (Liberation Serif, which is metric-compatible,
%   is used when Times New Roman is not installed). All font sizes are integers, which
%   keeps the glyph spacing correct in all export formats.
s.width     = 3.5;                 % inches
s.height    = 2.45;                % inches (single panel; Octave's qt toolkit does not
                                   % render figures lower than about 2.4 in correctly)
s.font      = 'Times New Roman';
s.fsTick    = 8;                   % tick labels
s.fsLabel   = 9;                   % axis labels
s.fsLegend  = 7;                   % legends and in-axes annotations
s.lw        = 1.0;                 % line width of the curves
s.ms        = 5;                   % marker size (hollow markers)
s.axLw      = 0.5;                 % axes and legend box line width
s.gridAlpha = 0.18;                % light solid grid
s.edge      = [0.15 0.15 0.15];    % axes and legend box color
s.margins   = [0.46 0.40 0.12 0.08];   % axes margins [left bottom right top] (in)
end
