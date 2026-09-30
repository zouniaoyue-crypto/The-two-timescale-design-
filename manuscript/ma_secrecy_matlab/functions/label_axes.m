function label_axes(ax, xl, yl)
%LABEL_AXES  Axis labels with the common font (TeX markup, e.g. '{\itP}_{tot}').
s = fig_style();
xlabel(ax, xl, 'FontName', s.font, 'FontSize', s.fsLabel);
ylabel(ax, yl, 'FontName', s.font, 'FontSize', s.fsLabel);
end
