function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m. The legend is shared by both panels and saved
%   separately (plot_legend_strip.m, results/legend_main_schemes), so that the panels
%   need no headroom for it. The inset of (a) enlarges the window [x0 - dx, x0 + dx]
%   around x0 = 20 dB (the default SNR), where the rate-oriented MA, the sparse FPA, and
%   AS nearly overlap. A wider window (e.g., 15-25 dB) is not used, because the ESSRs rise
%   by about 10 bps/Hz over it, so that an inset of this size would not magnify the
%   curves. Panel (b) also shows, as thin horizontal dotted lines, the high-SNR prediction
%   1 - alpha* of the AN power fraction (Section III-D 3) of main.tex, an_highsnr.m) for the
%   designs of the proposed scheme and the FPA at the highest SNR, i.e., their predicted
%   saturation levels. The equal-power schemes of Fig. 6
%   are plotted by plot_fig6.m.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
plot_legend_strip('legend_main_schemes', items);   % one row above both panels (main.tex)
% (a) ESSR
[Y, keysA] = pick_schemes(res, 'essr', keys);
ax = plot_schemes(res.values, Y, keysA);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 35], 'YTick', 0:5:35);
s = fig_style();
add_inset(ax, res.values, Y, keysA, s);
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keysB] = pick_schemes(res, 'anfrac', keys);
ax = plot_schemes(res.values, Y, keysB);
if isfield(res, 'anpred')
    for key = {'MA_full', 'FPA_full'}
        j = find(strcmp(res.schemes, key{1}), 1);
        st = scheme_style(key{1});
        y = res.anpred(end, j);                    % prediction for the designs at the highest SNR
        plot(ax, res.values([1 end]), [y y], 'LineStyle', ':', 'Color', st.color, 'LineWidth', 0.8);
    end
end
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 0.6], 'YTick', 0:0.1:0.6);
save_figure('fig5b_an_fraction');
end

function add_inset(ax, x, Y, keys, s)
% Enlarged view of the middle benchmarks around x0, drawn in the empty area above the
% low-SNR part of the curves; the zoomed window is marked in the main axes.
x0 = 20;  dx = 0.5;
inner = {'MA_rate', 'SPA_full', 'AS'};
lo = inf;  hi = -inf;
for k = 1:numel(inner)
    j = find(strcmp(keys, inner{k}), 1);
    if isempty(j), continue; end
    yk = interp1(x, Y(:, j), [x0 - dx, x0 + dx]);
    lo = min(lo, min(yk));  hi = max(hi, max(yk));
end
if ~isfinite(lo), return; end
pad = 0.12*(hi - lo);  lo = lo - pad;  hi = hi + pad;
rectangle('Parent', ax, 'Position', [x0 - dx, lo, 2*dx, hi - lo], 'EdgeColor', s.edge, ...
          'LineWidth', s.axLw);
p = get(ax, 'Position');                             % inches
axi = axes('Parent', get(ax, 'Parent'), 'Units', 'inches', ...
           'Position', [p(1) + 0.10*p(3), p(2) + 0.50*p(4), 0.28*p(3), 0.25*p(4)]);
style_axes(axi);
set(axi, 'Color', 'w');
for k = numel(keys):-1:1                             % reverse order: the proposed design on top
    plot_curve(axi, x, Y(:, k), scheme_style(keys{k}));
end
set(axi, 'XLim', [x0 - dx, x0 + dx], 'YLim', [lo hi], 'XTick', x0, 'XTickLabel', {}, ...
         'YTick', ceil(lo):floor(hi), 'FontSize', s.fsTick);
text(x0 + 0.04*dx, lo + 0.04*(hi - lo), sprintf('%d dB', x0), 'Parent', axi, 'FontName', s.font, ...
     'FontSize', s.fsLegend, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
end
