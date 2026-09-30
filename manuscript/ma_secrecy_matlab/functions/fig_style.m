function s = fig_style()
%FIG_STYLE  Common style of all figures (IEEE two-column format).
%   Every panel is exported at the width of one IEEE column (3.5 in), so that the
%   fonts appear at their nominal sizes when the panel is included with
%   \includegraphics[width=\columnwidth] (or at 0.49\textwidth in a figure*).
s.width    = 3.5;                 % inches
s.height   = 2.6;                 % inches
s.font     = 'Times New Roman';   % matches the IEEEtran body font
s.fsTick   = 8;                   % tick labels
s.fsLabel  = 9;                   % axis labels
s.fsLegend = 7.5;                 % legend entries
s.lw       = 1.2;                 % line width of the curves
s.ms       = 5;                   % marker size
s.axLw     = 0.6;                 % axes line width
end
