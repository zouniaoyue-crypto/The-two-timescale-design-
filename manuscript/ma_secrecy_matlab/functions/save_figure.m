function save_figure(name)
%SAVE_FIGURE  Saves the current figure in results/ as PDF, PNG and EPS (and .fig
%   in MATLAB). The paper size is 5 x 3.75 inches, which scales well to the width
%   of one column of an IEEE two-column paper.
f = fullfile(results_dir(), name);
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 5 3.75], 'PaperSize', [5 3.75]);
print(gcf, [f '.pdf'], '-dpdf');
print(gcf, [f '.png'], '-dpng', '-r200');
print(gcf, [f '.eps'], '-depsc');
if ~exist('OCTAVE_VERSION', 'builtin')
    savefig(gcf, [f '.fig']);
end
end
