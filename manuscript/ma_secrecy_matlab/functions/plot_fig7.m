function plot_fig7(res0, res1)
%PLOT_FIG7  Fig. 7: relative ESSR loss of the equal-power benchmarks with respect to the
%   proposed long-term power allocation (PA), 100 (1 - ESSR_benchmark / ESSR_proposed) in
%   percent, versus the transmit SNR, for LUs with heterogeneous large-scale fading (res1,
%   solid lines) and for identical LUs (res0, dashed lines). Purple diamonds: equal power
%   (EP) with optimized alpha; black triangles: EP with alpha = 0.5. The colors differ from
%   those of the schemes in Figs. 5 and 6, since the curves show different benchmarks.
%   res.essr(:, k): k = 1 proposed PA ('MA_full'), 2 'MA_EPA', 3 'MA_fix'.
s = fig_style();
loss = @(r, k) 100*(1 - r.essr(:, k)./r.essr(:, 1));
ax = new_figure();
R = {res1, res0};  lsp = {'-', '--'};                % heterogeneous (solid), identical (dashed)
st1 = scheme_style('MA_EPA');  st2 = scheme_style('MA_fix');
col = {st1.color, st2.color};  mk = {st1.marker, st2.marker};
h = zeros(2, 2);
for k = 1:2                                   % benchmark: optimized alpha, alpha = 0.5
    for r = 1:2                               % LUs: heterogeneous, identical
        st = struct('color', col{k}, 'ls', lsp{r}, 'marker', mk{k});
        h(k, r) = plot_curve(ax, R{r}.values, loss(R{r}, k + 1), st);
    end
end
set(ax, 'XLim', [res0.values(1) res0.values(end)], 'XTick', res0.values, ...
         'YLim', [-10 60], 'YTick', -10:10:60);       % the loss can be slightly negative
label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Relative ESSR loss (%)');
add_legend(ax, [h(1,1) h(1,2) h(2,1) h(2,2)], ...
           {'EP, opt. {\it\alpha}, heterogeneous LUs', 'EP, opt. {\it\alpha}, identical LUs', ...
            'EP, {\it\alpha} = 0.5, heterogeneous LUs', 'EP, {\it\alpha} = 0.5, identical LUs'}, 'northeast');
save_figure('fig7_power_allocation');
end
