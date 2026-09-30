function plot_fig2(res)
%PLOT_FIG2  Convergence curves of Algorithm 2 (results of fig2_convergence).
%   Colors distinguish the transmit SNRs (labeled next to the curves), and line
%   styles distinguish the initializations (legend).
new_figure();
c = {[0 0.447 0.741], [0.850 0.325 0.098], [0.466 0.674 0.188]};
ls = {'-o', '--s', ':^'};
nIt = 0;
for ip = 1:numel(res.Plist)
    for i = 1:size(res.hist, 2)
        h = res.hist{ip, i};
        plot(0:numel(h)-1, h, ls{i}, 'Color', c{ip}, 'LineWidth', 1.4, 'MarkerSize', 4);
        nIt = max(nIt, numel(h) - 1);
    end
end
for ip = 1:numel(res.Plist)                       % SNR labels next to the curves
    h = res.hist{ip, 1};
    text(0.62*nIt, h(end) + 1.2, sprintf('P_{tot}/\\sigma^2 = %d dB', res.Plist(ip)), ...
         'Color', c{ip}, 'FontSize', 10);
end
hl = zeros(1, 3);                                 % legend: initializations only
for i = 1:3
    hl(i) = plot(NaN, NaN, ls{i}, 'Color', 'k', 'LineWidth', 1.4, 'MarkerSize', 4);
end
legend(hl, {'UPA init.', 'Random init. 1', 'Random init. 2'}, ...
       'Location', 'northoutside', 'Orientation', 'horizontal', 'FontSize', 9);
xlabel('Iteration index');  ylabel('Objective value of (P3) (bps/Hz)');
xlim([0 nIt]);
save_figure('fig2_convergence');
end
