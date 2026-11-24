function plot_fig6(res)
%PLOT_FIG6  Fig. 6: ESSR versus the transmit SNR for the 2 x 2 power-allocation design
%   (pa_schemes.m): the proposed design and the FPA, each with the power allocation of
%   Algorithm 1 and with equal power p_m = q = P_tot/N (fig5_snr.m). The four-entry legend
%   is placed in the empty upper-left area of the panel.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
keys = pa_schemes();
[Y, keys] = pick_schemes(res, 'essr', keys);
if isempty(keys), return; end
ax = plot_schemes(res.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [res.values(1) res.values(end)], 'XTick', res.values, 'YLim', [0 35], 'YTick', 0:5:35);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, {items(1:2), items(3:4)}, 'nw');
save_figure('fig6_essr_power');
end
