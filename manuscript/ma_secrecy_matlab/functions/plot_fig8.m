function plot_fig8(resS)
%PLOT_FIG8  Fig. 8: benefit of the long-term power allocation (PA). ESSR of the proposed PA
%   ('MA_full'), equal power (EP) with optimized alpha ('MA_EPA'), and EP with alpha = 0.5
%   ('MA_fix'), where the positions are optimized by Algorithm 2 for each PA, versus the
%   large-scale fading spread S of the LUs, [beta_1, beta_2, beta_3] = [0, -S/2, -S] dB,
%   at P_tot/sigma^2 = 10 dB (resS, extra_pa_spread_10dB.mat from extra_pa_spread.m);
%   S = 0 corresponds to identical LUs. The gains at 0 dB (extra_pa_spread_0dB.mat) and
%   20 dB (fig7_power_allocation.m) are quoted in Section V-G without a figure.
keys = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'EP, optimized {\it\alpha}', 'EP, {\it\alpha} = 0.5'};
sty = cell(1, 3);
for k = 1:3
    sty{k} = scheme_style(keys{k});  sty{k}.ls = '-';  sty{k}.name = names{k};
end
ax = new_figure();
for k = 3:-1:1
    j = find(strcmp(resS.schemes, keys{k}), 1);
    assert(~isempty(j), 'Missing power-allocation scheme');
    plot_curve(ax, resS.values, resS.essr(:, j), sty{k});
end
label_axes(ax, 'Large-scale fading spread {\itS} (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [resS.values(1) resS.values(end)], 'XTick', resS.values, 'YLim', [4 12], 'YTick', 4:2:12);
place_legend(ax, {{sty{1}}, {sty{2}}, {sty{3}}}, 'ne');
save_figure('fig8_pa_spread');
end
