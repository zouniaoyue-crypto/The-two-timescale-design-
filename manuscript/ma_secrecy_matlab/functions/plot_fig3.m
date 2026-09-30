function plot_fig3(res)
%PLOT_FIG3  Fig. 3: accuracy of the closed-form ergodic rates, panels (a) versus the
%   transmit SNR and (b) versus the Rician factor. Markers: Monte Carlo; lines: closed
%   forms. Upper group of curves: LUs (Lemma 1); lower group: Eve (Proposition 1).
s = fig_style();
xl = {'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Rician factor {\it\kappa} = {\it\kappa}_{e} (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
files = {'fig3a_accuracy_snr', 'fig3b_accuracy_kappa'};
luLabelAbove = [true false];                          % position of the "LUs" label
topFactor = [1.6 1.8];                                % head room for the legend
col = {[0.12 0.47 0.71], [0.84 0.15 0.16]};           % compact FPA (UPA), random MA
mk  = {'o', 's'};  ls = {'-', '--'};
for sweep = 1:2
    ax = new_figure();
    X = xv{sweep};  Y = data{sweep};
    for k = 1:2                                       % position type
        for w = 1:2                                   % w = 1: LUs, w = 2: Eve
            j = 2*w - 1;
            plot(ax, X, Y(:,k,j+1), 'LineStyle', ls{k}, 'Color', col{k}, 'LineWidth', s.lw);
            plot(ax, X, Y(:,k,j), 'LineStyle', 'none', 'Marker', mk{k}, 'Color', col{k}, ...
                 'MarkerSize', s.ms + 0.5, 'LineWidth', 0.9, 'MarkerFaceColor', 'w');
        end
    end
    % factorized legend: color/marker = antenna configuration, line/marker = method
    h = zeros(1, 4);
    for k = 1:2
        h(k) = plot(ax, NaN, NaN, 'LineStyle', ls{k}, 'Marker', mk{k}, 'Color', col{k}, ...
                    'LineWidth', s.lw, 'MarkerSize', s.ms + 0.5, 'MarkerFaceColor', 'w');
    end
    h(3) = plot(ax, NaN, NaN, 'LineStyle', 'none', 'Marker', 'o', 'Color', [0.2 0.2 0.2], ...
                'MarkerSize', s.ms + 0.5, 'LineWidth', 0.9, 'MarkerFaceColor', 'w');
    h(4) = plot(ax, NaN, NaN, 'LineStyle', '-', 'Marker', 'none', 'Color', [0.2 0.2 0.2], 'LineWidth', s.lw);
    label_axes(ax, xl{sweep}, 'Ergodic sum rate (bps/Hz)');
    xlim(ax, [X(1) X(end)]);
    ytop = max(reshape(Y(:,:,1:2), [], 1));
    yTop = topFactor(sweep)*ytop;  ylim(ax, [0 yTop]);
    % group labels next to the curves (right-aligned at the second-to-last point)
    ix = numel(X) - 1;
    if luLabelAbove(sweep)
        yLU = max(reshape(Y(ix,:,1:2), [], 1)) + 0.05*yTop;  va = 'bottom';
    else
        yLU = min(reshape(Y(ix,:,1:2), [], 1)) - 0.05*yTop;  va = 'top';
    end
    yEve = max(reshape(Y(ix,:,3:4), [], 1)) + 0.05*yTop;
    text(X(ix), yLU, 'LUs (Lemma 1)', 'FontName', s.font, 'FontSize', s.fsLegend, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', va, 'Parent', ax);
    text(X(ix), yEve, 'Eve (Proposition 1)', 'FontName', s.font, 'FontSize', s.fsLegend, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'Parent', ax);
    add_legend(ax, h, {'Compact FPA', 'Random MA', 'Monte Carlo', 'Closed form'}, 'northwest');
    save_figure(files{sweep});
end
end
