function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m; (a) also shows the proposed design without AN
%   ('MA_noAN'), whose ESSR saturates at high SNR under the worst-case Eve.
%   The inset of (a) enlarges the window [x0 - dx, x0 + dx] around x0 = 20 dB (the default
%   SNR), where the rate-oriented MA, the sparse FPA, and AS nearly overlap. A wider window
%   (e.g., 15-25 dB) is not used, because the ESSRs rise by about 10 bps/Hz over it, so that
%   an inset of this size would not magnify the curves.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
% (a) ESSR
[Y, keys] = pick_schemes(res, 'essr', [main_schemes(), {'MA_noAN'}]);
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 35], 'YTick', 0:5:35);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
s = fig_style();  m = s.margins;
if numel(items) == 6                           % two columns above the low-SNR part
    manual_legend(gcf, [m(1) + 0.06, m(2) + 1.97 - 0.50, 2.30, 0.46], ...
                  {items([1 4]), items([2 5]), items([3 6])}, 1.15, 0.14);
else
    add_legend(ax, h, names, 'northwest');
end
add_inset(ax, res.values, Y, keys, items, s);
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keys] = pick_schemes(res, 'anfrac');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 0.8], 'YTick', 0:0.1:0.8);
add_legend(ax, h, names, 'northwest');               % free area above the low-SNR part
save_figure('fig5b_an_fraction');
end

function add_inset(ax, x, Y, keys, items, s)
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
           'Position', [p(1) + 0.12*p(3), p(2) + 0.45*p(4), 0.29*p(3), 0.27*p(4)]);
style_axes(axi);
set(axi, 'Color', 'w');
for k = numel(keys):-1:1                             % reverse order: the proposed design on top
    plot_curve(axi, x, Y(:, k), items{k});
end
yt = (ceil(lo*2):floor(hi*2))/2;                     % ticks every 0.5 bps/Hz
set(axi, 'XLim', [x0 - dx, x0 + dx], 'YLim', [lo hi], 'XTick', x0, 'XTickLabel', {}, ...
         'YTick', yt, 'FontSize', s.fsLegend);
text(x0 + 0.04*dx, lo + 0.04*(hi - lo), sprintf('%d dB', x0), 'Parent', axi, 'FontName', s.font, ...
     'FontSize', s.fsLegend, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
end
