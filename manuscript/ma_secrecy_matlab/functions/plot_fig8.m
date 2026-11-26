function plot_fig8(resB)
%PLOT_FIG8  Fig. 8: ESSR versus the Rician factor kappa_e of Eve with kappa_m = 10 dB at the
%   default SNR (fig8_rician.m, panel 'b'), for the schemes in main_schemes.m, with the
%   legend (two columns) in the empty lower-left area. The common-Rician-factor sweep
%   kappa_m = kappa_e (fig8_rician.m, panel 'a') is reported in the text of Section V-D
%   (verify_numbers.m) and not plotted.
if nargin < 1 || isempty(resB), return; end
[Y, keys] = pick_schemes(resB, 'essr');
ax = plot_schemes(resB.values, Y, keys);
label_axes(ax, 'Rician factor of Eve {\it\kappa}_e (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resB.values(1) resB.values(end)], 'XTick', resB.values, 'YLim', [12 22], 'YTick', 12:2:22);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, legend_rows(items, 2), 'sw');
save_figure('fig8_essr_kappae');
end
