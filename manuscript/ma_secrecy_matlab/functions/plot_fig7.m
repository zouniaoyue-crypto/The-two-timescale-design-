function plot_fig7(res)
%PLOT_FIG7  Single-LU case: ESSR (fig7a) and AN power fraction (fig7b) versus Delta.
names = {'Proposed MA', 'FPA (\lambda/2 UPA)', 'Sparse FPA'};
sty = [1 4 5];                                  % same line styles as in fig3
plot_sweep(res, res.values, 'Angular offset \Delta between Eve and the LU (rad)', ...
           'Ergodic secrecy rate (bps/Hz)', 'essr', names, 'northwest', 1:3, sty);
save_figure('fig7a_single_user_essr');
plot_sweep(res, res.values, 'Angular offset \Delta between Eve and the LU (rad)', ...
           'AN power fraction (N-M)q/P_{tot}', 'anfrac', names, 'southwest', 1:3, sty);
ylim([0 1]);                                    % leave room for the legend below the curves
save_figure('fig7b_single_user_an');
end
