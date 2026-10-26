function plot_fig7(resD3, resD1, resS0, resS10)
%PLOT_FIG7  Fig. 7: (a) ESSR versus the coordinate-angle offset Delta between Eve and LU 1 for
%   M = 3 (resD3, extra_angle_offset.m) and M = 1 (resD1, extra_single_user.m); for M = 1,
%   the rate-oriented MA coincides with the FPA and is therefore not drawn.
%   (b) Benefit of the long-term power allocation (PA): ESSR of the proposed PA
%   ('MA_full'), equal power (EP) with optimized alpha ('MA_EPA'), and EP with alpha = 0.5
%   ('MA_fix'), where the positions are optimized by Algorithm 2 for each PA, versus the
%   fading spread varsigma, [beta_1, beta_2, beta_3] = [0, -varsigma/2, -varsigma] dB, at
%   P_tot/sigma^2 = 10 dB (solid, resS10) and 0 dB (dashed, resS0) (extra_pa_spread.m);
%   varsigma = 0 corresponds to identical LUs. The PA versus the SNR
%   (fig7_power_allocation.m) is quoted in Section V-G without a figure.
s = fig_style();
m = s.margins;
% ---------------- (a) coordinate-angle offset, M = 3 and M = 1 ----------------
if ~isempty(resD3) && ~isempty(resD1)
    ax = new_figure();
    keys = main_schemes();
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    for k = numel(keys):-1:1                       % reverse order: the proposed design on top
        st = items{k};
        j = find(strcmp(resD3.schemes, keys{k}), 1);
        plot_curve(ax, resD3.values, resD3.essr(:, j), st);
        if ~strcmp(keys{k}, 'MA_rate')                      % coincides with the FPA for M = 1
            j = find(strcmp(resD1.schemes, keys{k}), 1);
            plot_curve(ax, resD1.values, resD1.essr(:, j), st);
        end
    end
    label_axes(ax, 'Coordinate-angle offset {\it\Delta} (rad)', 'ESSR (bps/Hz)');
    set(ax, 'XLim', [0 0.5], 'XTick', 0:0.1:0.5, 'YLim', [0 25], 'YTick', 0:5:25);
    axes_note(ax, 0.97, 0.97, '{\itM} = 3', 'right', 'top');
    axes_note(ax, 0.97, 0.13, '{\itM} = 1', 'right', 'top');
    manual_legend(gcf, [m(1) + 0.35, m(2) + 0.73, 2.30, 0.46], {items([1 4]), items([2 5]), items(3)}, 1.15, 0.14);
    save_figure('fig7a_essr_offset');
end
if nargin < 4 || isempty(resS0) || isempty(resS10), return; end
% ---------------- (b) power allocation versus the fading spread ----------------
keys = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'EP, optimized {\it\alpha}', 'EP, {\it\alpha} = 0.5'};
sty = cell(1, 3);
for k = 1:3
    sty{k} = scheme_style(keys{k});  sty{k}.ls = '-';  sty{k}.name = names{k};
end
ax = new_figure();
R = {resS10, resS0};  lsp = {'-', '--'};
for r = 1:2
    for k = 3:-1:1
        st = sty{k};  st.ls = lsp{r};
        j = find(strcmp(R{r}.schemes, keys{k}), 1);
        assert(~isempty(j), 'Missing power-allocation scheme');
        plot_curve(ax, R{r}.values, R{r}.essr(:, j), st);
    end
end
label_axes(ax, 'Fading spread {\it\varsigma} (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [R{1}.values(1) R{1}.values(end)], 'XTick', R{1}.values, 'YLim', [0 14], 'YTick', 0:2:14);
k10 = struct('name', '{\itP}_{tot}/{\it\sigma}^2 = 10 dB', 'color', [0.3 0.3 0.3], 'ls', '-',  'marker', 'none', 'lw', 1.0);
k0  = struct('name', '{\itP}_{tot}/{\it\sigma}^2 = 0 dB',  'color', [0.3 0.3 0.3], 'ls', '--', 'marker', 'none', 'lw', 1.0);
manual_legend(gcf, [m(1) + 2.92 - 1.62, m(2) + 1.97 - 0.80, 1.58, 0.76], ...
              {{sty{1}}, {sty{2}}, {sty{3}}, {k10}, {k0}}, 1.5, 0.14);
save_figure('fig7b_pa_spread');
end
