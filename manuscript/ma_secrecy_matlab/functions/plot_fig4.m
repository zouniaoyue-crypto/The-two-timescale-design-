function plot_fig4(res)
%PLOT_FIG4  ESSR versus the angular offset Delta between Eve and LU 1.
plot_sweep(res, res.values, 'Angular offset \Delta between Eve and LU 1 (rad)', ...
           'Ergodic secrecy sum rate (bps/Hz)', 'essr', res.names, 'southeast', 1:4, [1 2 4 5]);
save_figure('fig4_essr_vs_angle');
end
