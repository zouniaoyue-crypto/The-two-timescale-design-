function plot_fig8(res0, res1)
%PLOT_FIG8  Fig. 8: ESSR loss of the equal-power benchmarks with respect to the proposed
%   long-term power allocation (PA), 100 (1 - ESSR_benchmark / ESSR_proposed) in %,
%   versus the transmit SNR, for identical LUs (res0, solid lines) and for LUs with a
%   heterogeneous large-scale fading (res1, dashed lines). Blue squares: equal power
%   with optimized alpha; gray triangles: equal power with alpha = 0.5.
%   res.essr(:, k): k = 1 proposed PA ('MA_full'), 2 'MA_EPA', 3 'MA_fix'.
loss = @(r, k) 100*(1 - r.essr(:, k)./r.essr(:, 1));
ax = new_figure();
R = {res0, res1};  lsp = {'-', '--'};  keys = {'MA_EPA', 'MA_fix'};
h = zeros(2, 2);
for k = 1:2
    for r = 1:2
        st = scheme_style(keys{k});  st.ls = lsp{r};
        h(k, r) = plot_curve(ax, R{r}.values, loss(R{r}, k + 1), st);
    end
end
xlim(ax, [res0.values(1) res0.values(end)]);
top = max([loss(res0, 2); loss(res0, 3); loss(res1, 2); loss(res1, 3)]);
ylim(ax, [0 10*ceil(1.1*top/10)]);
label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'ESSR loss w.r.t. proposed PA (%)');
add_legend(ax, [h(1,1) h(1,2) h(2,1) h(2,2)], ...
           {'Opt. {\it\alpha}, identical LUs', 'Opt. {\it\alpha}, heterogeneous LUs', ...
            '{\it\alpha} = 0.5, identical LUs', '{\it\alpha} = 0.5, heterogeneous LUs'}, 'northeast');
save_figure('fig8_power_allocation');
end
