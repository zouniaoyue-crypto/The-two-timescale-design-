function label_axes(ax, xl, yl)
%LABEL_AXES  Axis labels with the common font (TeX markup, e.g. '{\itP}_{tot}').
s = fig_style();
if ~isempty(xl), xlabel(ax, xl, 'FontName', s.font, 'FontSize', s.fsLabel); end
if ~isempty(yl), ylabel(ax, yl, 'FontName', s.font, 'FontSize', s.fsLabel); end
end
