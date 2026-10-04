function plot_fig3(res)
%PLOT_FIG3  Fig. 3: accuracy of the closed-form ergodic rates versus (a) the transmit SNR
%   and (b) the Rician factor. Each panel has two stacked axes with a common x-axis: the
%   ergodic sum rate of the LUs, sum_m Rbar_m (top, Lemma 1), and the ergodic wiretap sum
%   rate of Eve, sum_m Rbar_{e,m} (bottom, Proposition 1), so that the accuracy for Eve is
%   visible on its own scale. Every quantity is drawn with two symbols, which are both
%   listed in the legend above the axes: hollow markers without lines for the Monte Carlo
%   results and lines without markers for the closed forms. Gray: FPA (compact UPA);
%   green: random feasible MA positions.
s = fig_style();
xl = {'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Rician factor {\it\kappa} = {\it\kappa}_{e} (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
files = {'fig3a_accuracy_snr', 'fig3b_accuracy_kappa'};
yLU  = {[0 35], [14 22]};     tLU  = {10:10:30, 16:2:22};     % y-limits and ticks (no tick
yEve = {[0 5],  [0 6]};       tEve = {0:1:5,   0:2:6};        % label at the junction)
cfg(1) = struct('name', 'FPA',       'color', [0.35 0.35 0.35], 'ls', '--', 'mk', 'd');
cfg(2) = struct('name', 'Random MA', 'color', [0.00 0.55 0.40], 'ls', '-',  'mk', 's');
W = s.width;  H = 3.05;
Lm = 0.50;  Rm = 0.12;  Bm = 0.40;  Tm = 0.42;  G = 0.08;     % margins (in); Tm: legend strip
ha = (H - Bm - Tm - G)/2;                                     % height of each axes
for sweep = 1:2
    X = xv{sweep};  Y = data{sweep};
    f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 W H]);
    set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 W H], 'PaperSize', [W H]);
    axU = axes('Parent', f, 'Units', 'inches', 'Position', [Lm, Bm + ha + G, W - Lm - Rm, ha]);
    axE = axes('Parent', f, 'Units', 'inches', 'Position', [Lm, Bm, W - Lm - Rm, ha]);
    style_axes(axU);  style_axes(axE);
    for k = 1:2                                % k = 1: FPA (compact UPA), k = 2: random MA
        c = cfg(k);
        for w = 1:2                            % w = 1: LUs (top), w = 2: Eve (bottom)
            if w == 1, ax = axU; else, ax = axE; end
            j = 2*w - 1;                       % Y(:,k,j): Monte Carlo, Y(:,k,j+1): closed form
            plot(ax, X, Y(:,k,j+1), 'LineStyle', c.ls, 'Color', c.color, 'LineWidth', s.lw);
            plot(ax, X, Y(:,k,j), 'LineStyle', 'none', 'Marker', c.mk, 'Color', c.color, ...
                 'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
        end
    end
    set([axU axE], 'XLim', [X(1) X(end)], 'XTick', X);
    set(axU, 'XTickLabel', {}, 'YLim', yLU{sweep}, 'YTick', tLU{sweep});
    set(axE, 'YLim', yEve{sweep}, 'YTick', tEve{sweep});
    label_axes(axE, xl{sweep}, '');
    axes_note(axU, 0.025, 0.95, 'Legitimate users (Lemma 1)');
    axes_note(axE, 0.025, 0.95, 'Eavesdropper (Proposition 1)');
    % common y-label of the two axes
    lax = axes('Parent', f, 'Units', 'inches', 'Position', [0 0 W H], 'Visible', 'off', ...
               'XLim', [0 W], 'YLim', [0 H]);
    text(0.10, Bm + ha + G/2, 'Ergodic sum rate (bps/Hz)', 'Parent', lax, 'Rotation', 90, ...
         'FontName', s.font, 'FontSize', s.fsLabel, 'HorizontalAlignment', 'center', ...
         'VerticalAlignment', 'middle');
    % legend in the strip above the axes, drawn with the plotted symbols: one column per
    % configuration, first row Monte Carlo (markers), second row closed form (lines)
    it = @(c, kind) struct('name', [c.name ', ' kind], 'color', c.color, ...
                           'ls', ifelse(strcmp(kind, 'Monte Carlo'), 'none', c.ls), ...
                           'marker', ifelse(strcmp(kind, 'Monte Carlo'), c.mk, 'none'));
    items = {{it(cfg(1), 'Monte Carlo'), it(cfg(2), 'Monte Carlo')}, ...
             {it(cfg(1), 'closed form'), it(cfg(2), 'closed form')}};
    manual_legend(f, [Lm, H - Tm + 0.04, W - Lm - Rm, Tm - 0.06], items, 1.32, 0.16);
    save_figure(files{sweep}, f);
end
end

function v = ifelse(c, a, b)
if c, v = a; else, v = b; end
end
