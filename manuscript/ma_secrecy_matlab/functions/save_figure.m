function save_figure(name, fig)
%SAVE_FIGURE  Exports a figure to results/<name>.{pdf,eps,png} (MATLAB) or
%   results/<name>.png (Octave). In MATLAB, the PDF/EPS files are vector graphics
%   with embedded fonts and are used by main.tex; the .fig file is also saved.
%   Octave's vector export misplaces glyphs at small font sizes, hence only a
%   600-dpi PNG is written there (run Octave with the qt toolkit, e.g., under xvfb).
if nargin < 2, fig = gcf; end
f = fullfile(results_dir(), name);
drawnow;
if exist('OCTAVE_VERSION', 'builtin')
    print(fig, [f '.png'], '-dpng', '-r600');
else
    if exist('exportgraphics', 'file')                                   % R2020a+
        exportgraphics(fig, [f '.pdf'], 'ContentType', 'vector');
        exportgraphics(fig, [f '.png'], 'Resolution', 600);
    else
        print(fig, [f '.pdf'], '-dpdf', '-painters');
        print(fig, [f '.png'], '-dpng', '-r600');
    end
    print(fig, [f '.eps'], '-depsc', '-painters');
    savefig(fig, [f '.fig']);
end
end
