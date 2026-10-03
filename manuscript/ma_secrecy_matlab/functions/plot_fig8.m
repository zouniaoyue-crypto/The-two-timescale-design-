function plot_fig8(resA, resB)
%PLOT_FIG8  Fig. 8: ESSR versus the spread of the large-scale fading coefficients of
%   the LUs for different long-term power allocations (PA), at (a) P_tot/sigma^2 =
%   resA.P_dB and (b) resB.P_dB (default 0 and 10 dB, prm.fig8SNR). The antenna
%   positions are optimized for each PA.
%   The curves decrease from the upper left to the lower right, so the legend is
%   placed in the upper-right corner and the SNR label in the lower-left corner.
s = fig_style();
keys  = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'Equal power, optimized {\it\alpha}', 'Equal power, {\it\alpha} = 0.5'};
R = {resA, resB};  files = {sprintf('fig8a_pa_%ddB', resA.P_dB), sprintf('fig8b_pa_%ddB', resB.P_dB)};
for r = 1:2
    [ax, h] = plot_schemes(R{r}.values, R{r}.essr, keys, names);
    label_axes(ax, 'Spread {\it\varsigma} of the large-scale fading (dB)', 'ESSR (bps/Hz)');
    xlim(ax, [R{r}.values(1) R{r}.values(end)]);
    set(ax, 'XTick', R{r}.values);
    lo = min(R{r}.essr(:));  hi = max(R{r}.essr(:));  rg = hi - lo;
    ylim(ax, [lo - 0.08*rg, hi + 0.12*rg]);
    text(R{r}.values(1) + 0.03*(R{r}.values(end) - R{r}.values(1)), lo, ...
         sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', R{r}.P_dB), ...
         'FontName', s.font, 'FontSize', s.fsLegend, 'HorizontalAlignment', 'left', ...
         'VerticalAlignment', 'bottom', 'BackgroundColor', 'w', 'Margin', 1, 'Parent', ax);
    set(ax, 'Layer', 'bottom');                        % grid below the label background
    add_legend(ax, h, names, 'northeast');
    save_figure(files{r});
end
end
