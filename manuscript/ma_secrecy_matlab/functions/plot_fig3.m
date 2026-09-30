function plot_fig3(res)
%PLOT_FIG3  ESSR versus P_tot/sigma^2 (fig3) and AN power fraction (fig6).
names = {'Proposed MA', 'MA, equal power', 'MA without AN', ...
         'FPA (\lambda/2 UPA)', 'Sparse FPA', 'FPA without AN'};
x = res.values;
plot_sweep(res, x, 'P_{tot}/\sigma^2 (dB)', 'Ergodic secrecy sum rate (bps/Hz)', 'essr', names, 'northwest');
save_figure('fig3_essr_vs_power');
sel = [1 2 4 5];
plot_sweep(res, x, 'P_{tot}/\sigma^2 (dB)', 'AN power fraction (N-M)q/P_{tot}', 'anfrac', names, 'southeast', sel);
save_figure('fig6_an_fraction');
end
