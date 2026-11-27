function plot_fig8(resU, resB)
%PLOT_FIG8  Fig. 8 (two panels, schemes of main_schemes.m, default SNR):
%   (a) ESSR versus the number of LUs M with N = 8 (resU, extra_num_users.m), two-column
%       legend in the upper-left area, with the y-axis extended to 45 bps/Hz so that the
%       legend clears the curves (in the lower-right area, it would cover the curves at M = 1);
%   (b) ESSR versus the Rician factor kappa_e of Eve with kappa_m = 10 dB (resB,
%       fig8_rician.m, panel 'b'), two-column legend in the empty lower-left area.
%   The common-Rician-factor sweep kappa_m = kappa_e (fig8_rician.m, panel 'a') is reported
%   in the text of Section V-D (verify_numbers.m) and not plotted. Empty inputs are skipped.
if nargin >= 1 && ~isempty(resU)
    [Y, keys] = pick_schemes(resU, 'essr');
    ax = plot_schemes(resU.values, Y, keys);
    label_axes(ax, 'Number of LUs {\itM}', 'ESSR (bps/Hz)');
    set(ax, 'XLim', resU.values([1 end]), 'XTick', resU.values, 'YLim', [0 45], 'YTick', 0:5:45);
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    place_legend(ax, legend_rows(items, 2), 'nw');
    save_figure('fig8a_essr_users');
end
if nargin >= 2 && ~isempty(resB)
    [Y, keys] = pick_schemes(resB, 'essr');
    ax = plot_schemes(resB.values, Y, keys);
    label_axes(ax, 'Rician factor of Eve {\it\kappa}_e (dB)', 'ESSR (bps/Hz)');
    set(ax, 'XLim', resB.values([1 end]), 'XTick', resB.values, 'YLim', [12 22], 'YTick', 12:2:22);
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    place_legend(ax, legend_rows(items, 2), 'sw');
    save_figure('fig8b_essr_kappae');
end
end
