function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
% (a) ESSR
[Y, keys] = pick_schemes(res, 'essr');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 35], 'YTick', 0:5:35);
add_legend(ax, h, names, 'northwest');
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keys] = pick_schemes(res, 'anfrac');
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 0.6], 'YTick', 0:0.1:0.6);
add_legend(ax, h, names, 'southeast');               % the curves rise from the lower left
save_figure('fig5b_an_fraction');
end
