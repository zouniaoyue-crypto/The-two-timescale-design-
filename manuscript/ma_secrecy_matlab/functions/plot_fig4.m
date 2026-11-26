function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2. Objective value of (P3) versus the number
%   of AO iterations, averaged over the drops, for (N, P_tot/sigma^2) in {8, 12} x {10, 20} dB
%   (UPA initialization), drawn as continuous lines without markers; the x-axis shows the
%   first 30 of the res.nIt iterations, since all the curves converge within about 15
%   iterations. The color identifies the SNR (steel blue: 10 dB; brick red: 20 dB), and
%   each SNR group is labeled directly beside its curves in its own color
%   ("P_tot/sigma^2 = ... dB"), so that the legend lists only the line styles, drawn in a
%   neutral color: solid for N = 8, dashed for N = 12, and dotted for Algorithm 2 without
%   the grid search of Stage 1 (pure MM updates; N = 8, 20 dB, hence red).
s = fig_style();
ax = new_figure();
it = 0:res.nIt;
c = fig_palette();
colP = {c.blue, c.red};                          % 10 dB, 20 dB (res.Plist ascending)
lsN = {'-', '--'};                               % N = 8, N = 12
for iP = 1:numel(res.Plist)
    for iN = 1:numel(res.Nlist)
        hm = squeeze(mean(res.hist(iN, iP, :, :), 3)).';
        plot(ax, it, hm, 'LineStyle', lsN{iN}, 'Color', colP{iP}, 'LineWidth', 1.2);
    end
end
plot(ax, it, mean(res.histMM, 1), 'LineStyle', ':', 'Color', colP{res.Plist == 20}, 'LineWidth', 1.2);
xlim(ax, [0 30]);  set(ax, 'XTick', 0:5:30);   % converged within about 15 iterations
set(ax, 'YLim', [0 24], 'YTick', 0:4:24);
label_axes(ax, 'Number of iterations', 'Objective value of (P3) (bps/Hz)');
% SNR labels in the color of their curves, right-aligned above each group
for iP = 1:numel(res.Plist)
    top = max(squeeze(mean(res.hist(:, iP, :, end), 3)));          % highest converged value
    text(29.5, top + 1.5, sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', res.Plist(iP)), 'Parent', ax, ...
         'FontName', s.font, 'FontSize', s.fsLegend, 'Color', colP{iP}, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
end
% legend: line styles only (neutral color), two columns in the empty lower-right band
k = c.gray;
a8  = struct('color', k, 'ls', '-',  'marker', 'none', 'lw', 1.2, 'name', 'Algorithm 2, {\itN} = 8');
a12 = struct('color', k, 'ls', '--', 'marker', 'none', 'lw', 1.2, 'name', 'Algorithm 2, {\itN} = 12');
mm  = struct('color', k, 'ls', ':',  'marker', 'none', 'lw', 1.2, 'name', 'MM only, {\itN} = 8');
place_legend(ax, {{a8, a12}, {mm, []}}, 'se');
save_figure('fig4_convergence');
end
