function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m; (a) also shows the proposed design without AN
%   ('MA_noAN'), whose ESSR saturates at high SNR under the worst-case Eve.
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
