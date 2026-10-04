function plot_fig7(res0, res1)
%PLOT_FIG7  Fig. 7: relative ESSR loss of the equal-power benchmarks with respect to the
%   proposed long-term power allocation (PA), 100 (1 - ESSR_benchmark / ESSR_proposed) in
%   percent, versus the transmit SNR, for identical LUs (res0, solid lines) and for LUs
%   with heterogeneous large-scale fading (res1, dashed lines). Blue squares: equal power
%   with optimized alpha; orange triangles: equal power with alpha = 0.5.
%   res.essr(:, k): k = 1 proposed PA ('MA_full'), 2 'MA_EPA', 3 'MA_fix'.
s = fig_style();
loss = @(r, k) 100*(1 - r.essr(:, k)./r.essr(:, 1));
ax = new_figure();
R = {res0, res1};  lsp = {'-', '--'};
col = {[0.00 0.38 0.70], [0.90 0.55 0.00]};  mk = {'s', '^'};
h = zeros(2, 2);
for k = 1:2                                   % benchmark: optimized alpha, alpha = 0.5
    for r = 1:2                               % LUs: identical, heterogeneous
        st = struct('color', col{k}, 'ls', lsp{r}, 'marker', mk{k});
        h(k, r) = plot_curve(ax, R{r}.values, loss(R{r}, k + 1), st);
    end
end
set(ax, 'XLim', [res0.values(1) res0.values(end)], 'XTick', res0.values, 'YLim', [0 60], 'YTick', 0:10:60);
label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Relative ESSR loss (%)');
add_legend(ax, [h(1,1) h(1,2) h(2,1) h(2,2)], ...
           {'Opt. {\it\alpha}, identical LUs', 'Opt. {\it\alpha}, heterogeneous LUs', ...
            '{\it\alpha} = 0.5, identical LUs', '{\it\alpha} = 0.5, heterogeneous LUs'}, 'northeast');
save_figure('fig7_power_allocation');
end
