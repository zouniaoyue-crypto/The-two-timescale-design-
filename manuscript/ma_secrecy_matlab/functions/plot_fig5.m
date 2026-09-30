function plot_fig5(res)
%PLOT_FIG5  Fig. 5: (a) ESSR and (b) optimized AN power fraction versus the transmit SNR.
s = fig_style();
keys = res.schemes;
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
names = cellfun(@scheme_name, keys, 'UniformOutput', false);
% (a) ESSR
[ax, h] = plot_schemes(res.values, res.essr, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
xlim(ax, [res.values(1) res.values(end)]);
yl = ylim(ax);  ylim(ax, [0 yl(2)]);
add_legend(ax, h, names, 'northwest');
save_figure('fig5a_essr_snr');
% (b) AN power fraction (schemes with AN only)
sel = find(~strcmp(keys, 'MA_noAN'));
[ax, h] = plot_schemes(res.values, res.anfrac(:, sel), keys(sel));
label_axes(ax, xl, 'AN power fraction ({\itN}-{\itM}){\itq}/{\itP}_{tot}');
xlim(ax, [res.values(1) res.values(end)]);
ylim(ax, [0 0.6]);
add_legend(ax, h, names(sel), 'southeast');
save_figure('fig5b_an_fraction');
end
