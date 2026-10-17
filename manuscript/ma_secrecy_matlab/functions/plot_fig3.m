function plot_fig3(res)
%PLOT_FIG3  Fig. 3: accuracy of the closed-form ergodic rates at the designs of the proposed
%   scheme, (a) versus the transmit SNR and (b) versus the Rician factor. Each panel shows
%   the ergodic sum rate of the LUs (blue, Lemma 1) and the ergodic wiretap sum rate of Eve
%   (vermillion, Proposition 1); tinted markers without lines: Monte Carlo; lines: closed forms.
%   res.vsP / res.vsK columns: [LU MC, LU closed form, Eve MC, Eve closed form, ...].
s = fig_style();  c = fig_palette();
xl = {'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'Rician factor {\it\kappa} (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
files = {'fig3a_accuracy_snr', 'fig3b_accuracy_kappa'};
ylims = {[0 40], [0 25]};  yt = {0:5:40, 0:5:25};
lu  = struct('name', 'LUs, simulation',    'color', c.blue, 'ls', 'none', 'marker', 's',    'lw', 1.1, 'mfc', c.tint(c.blue, 0.25));
luA = struct('name', 'LUs, Lemma 1',        'color', c.blue, 'ls', '-',    'marker', 'none', 'lw', 1.3, 'mfc', 'w');
ev  = struct('name', 'Eve, simulation',    'color', c.verm, 'ls', 'none', 'marker', '^',    'lw', 1.1, 'mfc', c.tint(c.verm, 0.25));
evA = struct('name', 'Eve, Proposition 1', 'color', c.verm, 'ls', '--',   'marker', 'none', 'lw', 1.3, 'mfc', 'w');
for sweep = 1:2
    X = xv{sweep};  Y = data{sweep};
    ax = new_figure();
    plot_curve(ax, X, Y(:,2), luA);  plot_curve(ax, X, Y(:,1), lu);
    plot_curve(ax, X, Y(:,4), evA);  plot_curve(ax, X, Y(:,3), ev);
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
