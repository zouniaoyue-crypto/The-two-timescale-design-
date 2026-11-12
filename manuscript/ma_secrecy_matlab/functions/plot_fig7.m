function plot_fig7(resD3, resD1, resS)
%PLOT_FIG7  Fig. 7: (a) ESSR versus the AoD offset Delta between Eve and LU 1 for
%   M = 3 (resD3, extra_angle_offset.m) and M = 1 (resD1, extra_single_user.m); for M = 1,
%   the rate-oriented MA keeps its UPA initialization and thus coincides with the FPA, so
%   the FPA curve is redrawn on top of it to keep both visible.
%   (b) Benefit of the long-term power allocation (PA): ESSR of the proposed PA
%   ('MA_full'), equal power (EP) with optimized alpha ('MA_EPA'), and EP with alpha = 0.5
%   ('MA_fix'), where the positions are optimized by Algorithm 2 for each PA, versus the
%   large-scale fading spread S of the LUs, [beta_1, beta_2, beta_3] = [0, -S/2, -S] dB,
%   at P_tot/sigma^2 = 10 dB (resS, extra_pa_spread_10dB.mat from extra_pa_spread.m);
%   S = 0 corresponds to identical LUs. The gains at 0 dB (extra_pa_spread_0dB.mat) and
%   20 dB (fig7_power_allocation.m) are quoted in Section V-G without a figure.
s = fig_style();
m = s.margins;
% ---------------- (a) AoD offset, M = 3 and M = 1 ----------------
if ~isempty(resD3) && ~isempty(resD1)
    ax = new_figure();
    keys = main_schemes();
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    for k = numel(keys):-1:1                       % reverse order: the proposed design on top
        st = items{k};
        j = find(strcmp(resD3.schemes, keys{k}), 1);
        plot_curve(ax, resD3.values, resD3.essr(:, j), st);
        j = find(strcmp(resD1.schemes, keys{k}), 1);
        plot_curve(ax, resD1.values, resD1.essr(:, j), st);
    end
    k = find(strcmp(keys, 'FPA_full'), 1);         % M = 1: FPA on top of the identical
    j = find(strcmp(resD1.schemes, 'FPA_full'), 1);    % rate-oriented MA curve
    plot_curve(ax, resD1.values, resD1.essr(:, j), items{k});
    label_axes(ax, 'AoD offset {\it\Delta} (rad)', 'ESSR (bps/Hz)');
    set(ax, 'XLim', [0 0.5], 'XTick', 0:0.1:0.5, 'YLim', [0 25], 'YTick', 0:5:25);
    axes_note(ax, 0.97, 0.97, '{\itM} = 3', 'right', 'top');
    axes_note(ax, 0.97, 0.13, '{\itM} = 1', 'right', 'top');
    manual_legend(gcf, [m(1) + 0.35, m(2) + 0.73, 2.30, 0.46], {items([1 4]), items([2 5]), items(3)}, 1.15, 0.14);
    save_figure('fig7a_essr_offset');
end
if nargin < 3 || isempty(resS), return; end
% ---------------- (b) power allocation versus the large-scale fading spread ----------------
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
manual_legend(gcf, [m(1) + 2.92 - 1.62, m(2) + 1.97 - 0.50, 1.58, 0.46], {{sty{1}}, {sty{2}}, {sty{3}}}, 1.5, 0.14);
save_figure('fig7b_pa_spread');
end
