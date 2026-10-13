function plot_fig3(res)
%PLOT_FIG3  Fig. 3: accuracy of the closed-form ergodic rates at the designs of the proposed
%   scheme, (a) versus the transmit SNR and (b) versus the Rician factor. Each panel shows
%   the ergodic sum rate of the LUs (blue, Lemma 1) and the ergodic wiretap sum rate of Eve
%   (red, Proposition 1); hollow markers without lines: Monte Carlo; lines: closed forms.
%   res.vsP / res.vsK columns: [LU MC, LU closed form, Eve MC, Eve closed form, ...].
s = fig_style();
blue = [0.00 0.38 0.70];  red = [0.80 0.10 0.12];
xl = {'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Rician factor {\it\kappa} (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
files = {'fig3a_accuracy_snr', 'fig3b_accuracy_kappa'};
ylims = {[0 40], [0 25]};  yt = {0:5:40, 0:5:25};
for sweep = 1:2
    X = xv{sweep};  Y = data{sweep};
    ax = new_figure();
    lu  = struct('name', 'LUs, simulation',      'color', blue, 'ls', 'none', 'marker', 's');
    luA = struct('name', 'LUs, Lemma 1',          'color', blue, 'ls', '-',    'marker', 'none');
    ev  = struct('name', 'Eve, simulation',      'color', red,  'ls', 'none', 'marker', '^');
    evA = struct('name', 'Eve, Proposition 1',   'color', red,  'ls', '--',   'marker', 'none');
    plot(ax, X, Y(:,2), 'LineStyle', luA.ls, 'Color', blue, 'LineWidth', s.lw);
    plot(ax, X, Y(:,1), 'LineStyle', 'none', 'Marker', lu.marker, 'Color', blue, ...
         'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
    plot(ax, X, Y(:,4), 'LineStyle', evA.ls, 'Color', red, 'LineWidth', s.lw);
    plot(ax, X, Y(:,3), 'LineStyle', 'none', 'Marker', ev.marker, 'Color', red, ...
         'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
    set(ax, 'XLim', [X(1) X(end)], 'XTick', X, 'YLim', ylims{sweep}, 'YTick', yt{sweep});
    label_axes(ax, xl{sweep}, 'Ergodic sum rate (bps/Hz)');
    m = s.margins;                                 % legend in the empty area of each panel
    if sweep == 1
        manual_legend(gcf, [m(1) + 0.06, m(2) + 1.30, 1.30, 0.62], {{lu}, {luA}, {ev}, {evA}}, 1.2, 0.14);
    else
        manual_legend(gcf, [m(1) + 0.30, m(2) + 0.62, 2.30, 0.34], {{lu, luA}, {ev, evA}}, 1.12, 0.15);
    end
    save_figure(files{sweep});
end
end
