function plot_legend_strip(name, items)
%PLOT_LEGEND_STRIP  One-row legend shared by the two panels of a two-column figure
%   (Figs. 5 and 6 of main.tex), saved as results/<name> and cropped to the legend box.
%   main.tex includes it at its natural size above the panels, so that its text has the
%   same 9-pt size as the panels and the panels need no legend of their own.
%   items: cell array of entry structs (scheme_style.m), drawn from left to right with the
%   line, marker, and color of the plotted curves (manual_legend.m).
%   In MATLAB, the figure has the size of the legend box, so that the vector PDF is the
%   box itself. Octave renders figures lower than about 2.4 in incorrectly, so there the
%   strip is drawn at the top of a figure of the usual height and the PNG is then trimmed
%   to the legend box (ImageMagick).
s = fig_style();
w = zeros(1, numel(items));
for k = 1:numel(items)
    w(k) = text_width(items{k}.name, s.fsLegend);
end
colW = s.legTok + 0.06 + w + s.legGap;              % sample, gap, text, gap to the next entry
width = 0.06 + sum(colW) - s.legGap + 0.06;
height = s.legRow + 0.06;
isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
if isOctave
    figW = width + 0.2;   figH = s.height;   pos = [0.1, figH - 0.1 - height, width, height];
else
    figW = width + 0.02;  figH = height + 0.02;  pos = [0.01, 0.01, width, height];
end
f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 figW figH], ...
           'MenuBar', 'none', 'ToolBar', 'none');
set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 figW figH], 'PaperSize', [figW figH]);
manual_legend(f, pos, {items}, colW);
save_figure(name, f);
if isOctave
    png = fullfile(results_dir(), [name '.png']);
    system(sprintf(['convert "%s" -trim +repage -define png:exclude-chunk=bKGD,cHRM,gAMA,iCCP,sRGB,tIME,tEXt,zTXt,iTXt,date ' ...
                    '-units PixelsPerInch -density 600 "%s" 2>/dev/null'], png, png));
end
end
