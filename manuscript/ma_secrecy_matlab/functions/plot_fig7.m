function plot_fig7(res1, resS0, resS10)
%PLOT_FIG7  Fig. 7: benefit of the long-term power allocation (PA). ESSR of the proposed
%   PA ('MA_full'), equal power (EP) with optimized alpha ('MA_EPA'), and EP with
%   alpha = 0.5 ('MA_fix'), where the positions are optimized by Algorithm 2 for each PA:
%   (a) versus the transmit SNR (0-20 dB) for heterogeneous LUs, [beta_1, beta_2, beta_3] =
%       [0, -10, -20] dB (res1, fig7_power_allocation.m with spread = 20 dB);
%   (b) versus the fading spread varsigma, [beta_1, beta_2, beta_3] = [0, -varsigma/2,
%       -varsigma] dB, at P_tot/sigma^2 = 10 dB (solid, resS10) and 0 dB (dashed, resS0)
%       (extra_pa_spread.m); varsigma = 0 corresponds to identical LUs.
s = fig_style();
keys = {'MA_full', 'MA_EPA', 'MA_fix'};
names = {'Proposed PA', 'EP, optimized {\it\alpha}', 'EP, {\it\alpha} = 0.5'};
sty = cell(1, 3);
for k = 1:3
    sty{k} = scheme_style(keys{k});  sty{k}.ls = '-';  sty{k}.name = names{k};
end
% ---------------- (a) versus SNR, heterogeneous LUs ----------------
ax = new_figure();  h = zeros(1, 3);
sel = res1.values <= 20;                      % low-to-moderate SNR, where the PA matters
for k = 3:-1:1                                 % reverse order: the proposed PA on top
    h(k) = plot_curve(ax, res1.values(sel), res1.essr(sel, k), sty{k});
end
label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [0 20], 'XTick', 0:5:20, 'YLim', [0 12], 'YTick', 0:2:12);
add_legend(ax, h, names, 'northwest');
save_figure('fig7a_pa_snr');
if nargin < 3 || isempty(resS0) || isempty(resS10), return; end
% ---------------- (b) versus the fading spread ----------------
ax = new_figure();
R = {resS10, resS0};  lsp = {'-', '--'};
for r = 1:2
    for k = 3:-1:1
        st = sty{k};  st.ls = lsp{r};
        plot_curve(ax, R{r}.values, R{r}.essr(:, k), st);
    end
end
label_axes(ax, 'Fading spread {\it\varsigma} (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [R{1}.values(1) R{1}.values(end)], 'XTick', R{1}.values, 'YLim', [0 14], 'YTick', 0:2:14);
k10 = struct('name', '{\itP}_{tot}/{\it\sigma}^2 = 10 dB', 'color', [0 0 0], 'ls', '-',  'marker', 'none');
k0  = struct('name', '{\itP}_{tot}/{\it\sigma}^2 = 0 dB',  'color', [0 0 0], 'ls', '--', 'marker', 'none');
m = s.margins;
manual_legend(gcf, [m(1) + 2.92 - 1.62, m(2) + 1.97 - 0.80, 1.58, 0.76], ...
              {{sty{1}}, {sty{2}}, {sty{3}}, {k10}, {k0}}, 1.5, 0.14);
save_figure('fig7b_pa_spread');
end
