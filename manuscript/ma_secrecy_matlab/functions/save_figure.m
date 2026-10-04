function save_figure(name, fig)
%SAVE_FIGURE  Exports a figure to results/<name>.{pdf,eps,png,fig} (MATLAB) or
%   results/<name>.png (Octave). In MATLAB, the PDF/EPS files are vector graphics with
%   embedded fonts and are used by main.tex (\includegraphics picks the .pdf first).
%   In Octave, only a 600-dpi PNG is written (IEEE accepts line art at >= 600 dpi): its
%   vector export lays out the text on a 96-dpi pixel grid, which shrinks or drops word
%   spaces, and its legend keys do not scale. Run Octave with the qt toolkit, e.g.,
%   xvfb-run -a octave --no-gui --eval replot_all
if nargin < 2, fig = gcf; end
f = fullfile(results_dir(), name);
drawnow;
if exist('OCTAVE_VERSION', 'builtin')
    print(fig, [f '.png'], '-dpng', '-r600');
else
    if ~isempty(which('exportgraphics'))                                 % R2020a+
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
