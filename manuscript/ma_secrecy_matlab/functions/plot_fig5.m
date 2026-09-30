function plot_fig5(res)
%PLOT_FIG5  ESSR versus the side length A of the movable region.
names = {'Proposed MA', 'FPA (\lambda/2 UPA)', 'Sparse FPA'};
plot_sweep(res, res.values, 'Side length of the movable region A/\lambda', ...
           'Ergodic secrecy sum rate (bps/Hz)', 'essr', names, 'northwest', 1:3, [1 4 5]);
save_figure('fig5_essr_vs_region');
end
