function plot_fig5(res, limKeys)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m, each panel with its own legend inside the axes.
%   The inset of (a), in the empty lower-right area, enlarges the window [x0 - dx, x0 + dx]
%   around x0 = 20 dB (the default SNR), where the rate-oriented MA and the FPA with
%   Eve-aware AN lie about 0.7 bps/Hz apart. A wider window (e.g., 15-25 dB) is not used,
%   because the ESSRs rise by about 10 bps/Hz over it, so that an inset of this size would
%   not magnify the curves. Panel (b) also shows the high-SNR predictions 1 - alpha* of the AN power fraction
%   (eq. (33) of main.tex, an_highsnr.m) for the designs at the highest SNR, i.e., the
%   predicted saturation levels, as thin black dotted horizontal lines over the high-SNR
%   part of the axis (15-30 dB; black is reserved for analytical results), with one legend
%   entry. By default, the predictions are drawn for the proposed design and the FPA (limKeys),
%   which bracket the other schemes; the predictions of all the schemes are quoted in the text
%   (verify_numbers.m). The equal-power schemes of Fig. 6 are plotted by plot_fig6.m.
if nargin < 2 || isempty(limKeys), limKeys = {'MA_full', 'FPA_full'}; end
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
keys = main_schemes();
s = fig_style();
% (a) ESSR
[Y, keysA] = pick_schemes(res, 'essr', keys);
ax = plot_schemes(res.values, Y, keysA);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 40], 'YTick', 0:5:40);
place_legend(ax, legend_rows(cellfun(@scheme_style, keysA, 'UniformOutput', false), 2), 'nw');
add_inset(ax, res.values, Y, keysA, s);
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keysB] = pick_schemes(res, 'anfrac', keys);
ax = plot_schemes(res.values, Y, keysB);
st = cellfun(@scheme_style, keysB, 'UniformOutput', false);
rows = [legend_rows(st, 2), {{[], []}}];
if isfield(res, 'anpred')
    [P, keysP] = pick_schemes(res, 'anpred', limKeys);   % predictions for the designs at 30 dB
    xr = [max(15, res.values(1)), res.values(end)];      % high-SNR part of the axis
    c = fig_palette();
    pr = struct('name', 'High-SNR prediction, (33)', 'color', c.black, 'ls', ':', ...
                'marker', 'none', 'lw', 1.0);
    for k = 1:numel(keysP)
        plot(ax, xr, P(end, k)*[1 1], 'LineStyle', pr.ls, 'Color', pr.color, 'LineWidth', pr.lw);
    end
    rows{end}{1} = pr;
end
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 0.8], 'YTick', 0:0.1:0.8);
place_legend(ax, rows, 'nw');
save_figure('fig5b_an_fraction');
end

function add_inset(ax, x, Y, keys, s)
% Enlarged view of the rate-oriented MA and the FPA with Eve-aware AN around x0, drawn in the empty area below the
% high-SNR part of the curves; the zoomed window is marked in the main axes. The y-range
% has extra headroom, so that the label of x0 in the upper-right corner clears the curves.
x0 = 20;  dx = 0.5;
inner = {'MA_rate', 'FPA_ean'};
lo = inf;  hi = -inf;
for k = 1:numel(inner)
    j = find(strcmp(keys, inner{k}), 1);
    if isempty(j), continue; end
    yk = interp1(x, Y(:, j), [x0 - dx, x0 + dx]);
    lo = min(lo, min(yk));  hi = max(hi, max(yk));
end
if ~isfinite(lo), return; end
rg = hi - lo;  lo = lo - 0.12*rg;  hi = hi + 0.12*rg;
rectangle('Parent', ax, 'Position', [x0 - dx, lo, 2*dx, hi - lo], 'EdgeColor', s.edge, ...
          'LineWidth', s.axLw);
hiI = hi + 0.45*rg;                                  % headroom of the inset for its label
p = get(ax, 'Position');                             % inches
axi = axes('Parent', get(ax, 'Parent'), 'Units', 'inches', ...
           'Position', [p(1) + 0.62*p(3), p(2) + 0.06*p(4), 0.30*p(3), 0.25*p(4)]);
style_axes(axi);
set(axi, 'Color', 'w');
for k = numel(keys):-1:1                             % reverse order: the proposed design on top
    plot_curve(axi, x, Y(:, k), scheme_style(keys{k}));
end
set(axi, 'XLim', [x0 - dx, x0 + dx], 'YLim', [lo hiI], 'XTick', x0, 'XTickLabel', {}, ...
         'YTick', ceil(lo):floor(hiI), 'FontSize', s.fsTick);
text(x0 + 0.94*dx, hiI - 0.08*(hiI - lo), sprintf('%d dB', x0), 'Parent', axi, 'FontName', s.font, ...
     'FontSize', s.fsLegend, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
end
