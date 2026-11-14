function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m; (a) also shows the proposed design without AN
%   ('MA_noAN', labeled in the plot), whose ESSR saturates at high SNR under the
%   worst-case Eve. The inset of (a) enlarges the window [x0 - dx, x0 + dx] around
%   x0 = 20 dB (the default SNR), where the rate-oriented MA, the sparse FPA, and AS
%   nearly overlap. A wider window (e.g., 15-25 dB) is not used, because the ESSRs rise by
%   about 10 bps/Hz over it, so that an inset of this size would not magnify the curves.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
keys = main_schemes();
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
lg = {items([1 4]), items([2 5]), items(3)};       % 2 columns: MA designs | fixed arrays
% (a) ESSR
[Y, keysA] = pick_schemes(res, 'essr', [keys, {'MA_noAN'}]);
[ax, h] = plot_schemes(res.values, Y, keysA); %#ok<ASGLU>
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 40], 'YTick', 0:5:40);
place_legend(ax, lg, 'nw');
s = fig_style();
if any(strcmp(keysA, 'MA_noAN'))                  % direct label below the saturating curve
    text(res.values(end) - 0.4, 11.8, 'Proposed w/o AN', 'Parent', ax, 'FontName', s.font, ...
         'FontSize', s.fsLegend, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
end
add_inset(ax, res.values, Y, keysA, s);
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keysB] = pick_schemes(res, 'anfrac');
ax = plot_schemes(res.values, Y, keysB);
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 0.8], 'YTick', 0:0.1:0.8);
place_legend(ax, lg, 'nw');
save_figure('fig5b_an_fraction');
end

function add_inset(ax, x, Y, keys, s)
% Enlarged view of the middle benchmarks around x0, drawn in the empty area between the
% low-SNR part of the curves and the legend; the zoomed window is marked in the main axes.
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
           'Position', [p(1) + 0.15*p(3), p(2) + 0.40*p(4), 0.28*p(3), 0.25*p(4)]);
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
