function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2. Objective value of (P3) versus the number
%   of AO iterations, averaged over the drops, for (N, P_tot/sigma^2) in {8, 12} x {10, 20} dB
%   (UPA initialization), drawn as continuous lines without markers; the x-axis shows the
%   first 30 of the res.nIt iterations, since all the curves converge within about 15
%   iterations. All the curves of Algorithm 2 are drawn in the color of the proposed design;
%   the line style identifies N (solid: N = 8; dashed: N = 12) and direct text labels
%   identify the SNR. The dotted charcoal curve shows Algorithm 2 without the grid search
%   of Stage 1 (pure MM updates) for N = 8, 20 dB.
s = fig_style();
ax = new_figure();
it = 0:res.nIt;
c = fig_palette();
lsN = {'-', '--'};                                % N = 8, N = 12
items = cell(1, numel(res.Nlist));
for iN = 1:numel(res.Nlist)
    items{iN} = struct('color', c.red, 'ls', lsN{iN}, 'marker', 'none', 'lw', 1.2, ...
                       'name', sprintf('Algorithm 2, {\\itN} = %d', res.Nlist(iN)));
    for iP = 1:numel(res.Plist)
        hm = squeeze(mean(res.hist(iN, iP, :, :), 3)).';
        draw(ax, it, hm, items{iN}, s);
    end
end
mm = struct('color', c.gray, 'ls', ':', 'marker', 'none', 'lw', 1.2, 'name', 'MM only, {\itN} = 8');
draw(ax, it, mean(res.histMM, 1), mm, s);
xlim(ax, [0 30]);  set(ax, 'XTick', 0:5:30);   % converged within about 15 iterations
set(ax, 'YLim', [0 24], 'YTick', 0:4:24);
label_axes(ax, 'Number of iterations', 'Objective value of (P3) (bps/Hz)');
% direct SNR labels above the converged values of the two groups of curves
lbl(ax, 29.5, 22.6, sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', max(res.Plist)), s);
lbl(ax, 29.5, 13.0, sprintf('%d dB', min(res.Plist)), s);
% legend in the empty band below the 10-dB curves, right of the initial rise
place_legend(ax, {{items{1}}, {items{2}}, {mm}}, 'se');
save_figure('fig4_convergence');
end

function draw(ax, x, y, st, s)
lw = s.lw;  if isfield(st, 'lw'), lw = st.lw; end
plot(ax, x, y, 'LineStyle', st.ls, 'Color', st.color, 'LineWidth', lw);
end

function lbl(ax, x, y, str, s)
text(x, y, str, 'Parent', ax, 'FontName', s.font, 'FontSize', s.fsLegend, ...
     'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
end
