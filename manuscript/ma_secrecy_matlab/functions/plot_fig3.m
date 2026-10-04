function plot_fig3(res)
%PLOT_FIG3  Fig. 3: accuracy of the closed-form ergodic rates versus (a) the transmit SNR
%   and (b) the Rician factor. Each panel has two stacked axes with a common x-axis: the
%   ergodic sum rate of the LUs (top, Lemma 1) and the ergodic wiretap sum rate of Eve
%   (bottom, Proposition 1), so that the accuracy of the approximation for Eve is visible
%   on its own scale. Lines: closed forms; markers: Monte Carlo (stated in the caption).
s = fig_style();
xl = {'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Rician factor {\it\kappa} = {\it\kappa}_{e} (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
files = {'fig3a_accuracy_snr', 'fig3b_accuracy_kappa'};
yLU  = {[0 35], [14 22]};     tLU  = {10:10:30, 16:2:22};     % y-limits and ticks (no tick
                                                              % label at the junction)
yEve = {[0 5],  [0 6]};       tEve = {0:1:5,   0:2:6};
lgLoc = {'southeast', 'southwest'};                           % free corner of the LU axes
cfg(1) = struct('name', 'FPA',       'color', [0.30 0.30 0.30], 'ls', '--', 'mk', 'd');
cfg(2) = struct('name', 'Random MA', 'color', [0.00 0.55 0.40], 'ls', '-',  'mk', 's');
W = s.width;  H = 2.75;
Lm = 0.50;  Rm = 0.12;  Bm = 0.40;  Tm = 0.08;  G = 0.08;     % margins (in)
ha = (H - Bm - Tm - G)/2;                                     % height of each axes
for sweep = 1:2
    X = xv{sweep};  Y = data{sweep};
    f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 W H]);
    set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 W H], 'PaperSize', [W H]);
    axU = axes('Parent', f, 'Units', 'inches', 'Position', [Lm, Bm + ha + G, W - Lm - Rm, ha]);
    axE = axes('Parent', f, 'Units', 'inches', 'Position', [Lm, Bm, W - Lm - Rm, ha]);
    style_axes(axU);  style_axes(axE);
    h = zeros(1, 2);
    for k = 1:2                                % k = 1: FPA (compact UPA), k = 2: random MA
        c = cfg(k);
        for w = 1:2                            % w = 1: LUs (top), w = 2: Eve (bottom)
            if w == 1, ax = axU; else, ax = axE; end
            j = 2*w - 1;                       % Y(:,k,j): Monte Carlo, Y(:,k,j+1): closed form
            plot(ax, X, Y(:,k,j+1), 'LineStyle', c.ls, 'Color', c.color, 'LineWidth', s.lw);
            plot(ax, X, Y(:,k,j), 'LineStyle', 'none', 'Marker', c.mk, 'Color', c.color, ...
                 'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
        end
        h(k) = plot(axU, NaN, NaN, 'LineStyle', c.ls, 'Marker', c.mk, 'Color', c.color, ...
                    'LineWidth', s.lw, 'MarkerSize', s.ms, 'MarkerFaceColor', 'w');
    end
    set([axU axE], 'XLim', [X(1) X(end)], 'XTick', X);
    set(axU, 'XTickLabel', {}, 'YLim', yLU{sweep}, 'YTick', tLU{sweep});
    set(axE, 'YLim', yEve{sweep}, 'YTick', tEve{sweep});
    label_axes(axE, xl{sweep}, '');
    axes_note(axU, 0.025, 0.95, 'LUs (Lemma 1)');
    axes_note(axE, 0.025, 0.95, 'Eve (Proposition 1)');
    % common y-label of the two axes
    lax = axes('Parent', f, 'Units', 'inches', 'Position', [0 0 W H], 'Visible', 'off', ...
               'XLim', [0 W], 'YLim', [0 H]);
    text(0.10, Bm + ha + G/2, 'Ergodic sum rate (bps/Hz)', 'Parent', lax, 'Rotation', 90, ...
         'FontName', s.font, 'FontSize', s.fsLabel, 'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'middle');
    add_legend(axU, h, {cfg.name}, lgLoc{sweep});
    save_figure(files{sweep}, f);
end
end
