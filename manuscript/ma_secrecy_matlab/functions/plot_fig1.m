function plot_fig1(res)
%PLOT_FIG1  Plots the accuracy results of fig1_accuracy (four figures).
xl = {'P_{tot}/\sigma^2 (dB)', '\kappa = \kappa_e (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
tags = {'a', 'b'; 'c', 'd'};  who = {'LUs', 'Eve'};
ylab = {'Ergodic sum rate of LUs (bps/Hz)', 'Ergodic wiretap sum rate (bps/Hz)'};
loc = {'southeast', 'southeast'; 'southwest', 'southeast'};   % legend positions (free areas)
col = {[0 0.447 0.741], [0.850 0.325 0.098]};
for sweep = 1:2
    for w = 1:2                                   % w = 1: LUs, w = 2: Eve
        new_figure();
        X = xv{sweep};  Y = data{sweep};  j = 2*w - 1;
        plot(X, Y(:,1,j),   'o',  'Color', col{1}, 'MarkerSize', 8, 'LineWidth', 1.5);
        plot(X, Y(:,1,j+1), '-',  'Color', col{1}, 'LineWidth', 1.8);
        plot(X, Y(:,2,j),   's',  'Color', col{2}, 'MarkerSize', 8, 'LineWidth', 1.5);
        plot(X, Y(:,2,j+1), '--', 'Color', col{2}, 'LineWidth', 1.8);
        xlabel(xl{sweep});
        ylabel(ylab{w});
        yl = ylim;                                % extend the y-axis downward so that the
        ylim([max(0, yl(1) - 0.35*(yl(2) - yl(1))), yl(2)]);   % legend does not cover the curves
        legend({'UPA, Monte Carlo', 'UPA, closed form', ...
                'Random MA, Monte Carlo', 'Random MA, closed form'}, ...
               'Location', loc{sweep, w}, 'FontSize', 9);
        save_figure(sprintf('fig1%s_accuracy_%s', tags{sweep, w}, lower(who{w})));
    end
end
end
