function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR
%   for the schemes in main_schemes.m.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
% (a) ESSR
[Y, keys] = pick_schemes(res, 'essr');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
xlim(ax, [res.values(1) res.values(end)]);
ymax = max(Y(:));  ylim(ax, [0 5*ceil(1.15*ymax/5)]);  % upper-left corner kept free for the legend
add_legend(ax, h, names, 'northwest');
save_figure('fig5a_essr_snr');
% (b) AN power fraction
[Y, keys] = pick_schemes(res, 'anfrac');
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
[ax, h] = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'AN power fraction ({\itN}-{\itM}){\itq}/{\itP}_{tot}');
xlim(ax, [res.values(1) res.values(end)]);
ylim(ax, [0 0.75]);                                 % head room for a two-column legend
add_legend(ax, h, names, 'north', 2);
save_figure('fig5b_an_fraction');
end
