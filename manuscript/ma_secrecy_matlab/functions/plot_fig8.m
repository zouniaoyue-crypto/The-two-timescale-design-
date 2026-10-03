function plot_fig8(resA, resB)
%PLOT_FIG8  Fig. 8: ESSR versus the spread of the large-scale fading coefficients of
%   the LUs for different long-term power allocations (PA), at (a) P_tot/sigma^2 =
%   resA.P_dB and (b) resB.P_dB. The antenna positions are optimized for each PA.
%   The curves decrease from the upper left to the lower right, so the legend is
%   placed in the lower-left corner and the y-axis is fitted tightly to the data.
s = fig_style();
keys  = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'Equal power, optimized {\it\alpha}', 'Equal power, {\it\alpha} = 0.5'};
R = {resA, resB};  files = {'fig8a_pa_10dB', 'fig8b_pa_20dB'};
for r = 1:2
    [ax, h] = plot_schemes(R{r}.values, R{r}.essr, keys, names);
    label_axes(ax, 'Spread {\it\varsigma} of the large-scale fading (dB)', 'ESSR (bps/Hz)');
    xlim(ax, [R{r}.values(1) R{r}.values(end)]);
    set(ax, 'XTick', R{r}.values);
    lo = min(R{r}.essr(:));  hi = max(R{r}.essr(:));  rg = hi - lo;
    ylim(ax, [lo - 0.08*rg, hi + 0.12*rg]);
    text(0.97*R{r}.values(end), hi + 0.04*rg, sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', R{r}.P_dB), ...
         'FontName', s.font, 'FontSize', s.fsLegend, 'HorizontalAlignment', 'right', ...
         'VerticalAlignment', 'middle', 'Parent', ax);
    add_legend(ax, h, names, 'southwest');
    save_figure(files{r});
end
end
