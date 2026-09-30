function plot_fig8(res0, res1)
%PLOT_FIG8  Fig. 8: ESSR versus the transmit SNR for different long-term power
%   allocations (PA), for identical LUs (res0, solid lines) and for LUs with a
%   20-dB spread of the large-scale fading (res1, dashed lines).
%   Color/marker: PA scheme; line style: spread.
s = fig_style();
keys = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'Equal power, optimized {\it\alpha}', 'Equal power, {\it\alpha} = 0.5'};
ax = new_figure();
R = {res0, res1};  lsp = {'-', '--'};
for r = 1:2
    for k = 1:3
        st = scheme_style(keys{k});  st.ls = lsp{r};
        plot_curve(ax, R{r}.values, R{r}.essr(:, k), st);
    end
end
h = zeros(1, 5);                                      % factorized legend
for k = 1:3
    st = scheme_style(keys{k});
    h(k) = plot(ax, NaN, NaN, 'LineStyle', 'none', 'Marker', st.marker, 'Color', st.color, ...
                'MarkerSize', s.ms, 'MarkerFaceColor', 'w', 'LineWidth', s.lw);
end
h(4) = plot(ax, NaN, NaN, 'LineStyle', lsp{1}, 'Marker', 'none', 'Color', [0.2 0.2 0.2], 'LineWidth', s.lw);
h(5) = plot(ax, NaN, NaN, 'LineStyle', lsp{2}, 'Marker', 'none', 'Color', [0.2 0.2 0.2], 'LineWidth', s.lw);
label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'ESSR (bps/Hz)');
xlim(ax, [res0.values(1) res0.values(end)]);
ylim(ax, [0 1.4*max([res0.essr(:); res1.essr(:)])]);
add_legend(ax, h, [names, {sprintf('Identical LUs ({\\it\\varsigma} = %d dB)', res0.spread), ...
                           sprintf('Heterogeneous LUs ({\\it\\varsigma} = %d dB)', res1.spread)}], 'northwest');
save_figure('fig8_power_allocation');
end
