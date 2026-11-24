function plot_fig8(resA, resB)
%PLOT_FIG8  Fig. 8: ESSR versus (a) the common Rician factor kappa_m = kappa_e (resA) and
%   (b) the Rician factor kappa_e of Eve with kappa_m = 10 dB (resB), at the default SNR
%   (fig8_rician.m), for the schemes in main_schemes.m. The legend is shared with Figs. 5
%   and 7 (plot_legend_strip.m, results/legend_main_schemes).
lab = {'Rician factor {\it\kappa} (dB)', 'Rician factor of Eve {\it\kappa}_e (dB)'};   % (a): kappa = kappa_m = kappa_e, as in Fig. 3(b)
name = {'fig8a_essr_kappa', 'fig8b_essr_kappae'};
R = {resA, resB};
for i = 1:2
    r = R{i};
    if isempty(r), continue; end
    [Y, keys] = pick_schemes(r, 'essr');
    ax = plot_schemes(r.values, Y, keys);
    label_axes(ax, lab{i}, 'ESSR (bps/Hz)');
    lo = 2*floor(min(Y(:))/2);  hi = 2*ceil(max(Y(:))/2);
    set(ax, 'XLim', [r.values(1) r.values(end)], 'XTick', r.values, 'YLim', [lo hi], 'YTick', lo:2:hi);
    save_figure(name{i});
end
end
