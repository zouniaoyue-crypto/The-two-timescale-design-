function plot_fig1(res)
%PLOT_FIG1  Plots the accuracy results of fig1_accuracy (four figures).
xl = {'P_{tot}/\sigma^2 (dB)', '\kappa = \kappa_e (dB)'};
data = {res.vsP, res.vsK};  xv = {res.Pvec, res.Kvec};
tags = {'a', 'b'; 'c', 'd'};  who = {'LUs', 'Eve'};
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
        ylabel(sprintf('Ergodic sum rate of the %s (bps/Hz)', who{w}));
        legend({'\lambda/2 UPA, Monte Carlo', '\lambda/2 UPA, closed form', ...
                'Random MA positions, Monte Carlo', 'Random MA positions, closed form'}, ...
               'Location', 'northwest');
        save_figure(sprintf('fig1%s_accuracy_%s', tags{sweep, w}, lower(who{w})));
    end
end
end
