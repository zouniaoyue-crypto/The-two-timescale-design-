function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2. Colors: transmit SNRs (labeled above
%   the curves); line styles and markers: initializations (legend).
s = fig_style();
ax = new_figure();
col = {[0.12 0.47 0.71], [0.84 0.15 0.16], [0.17 0.63 0.17]};
ls = {'-', '--', ':'};  mk = {'o', 's', '^'};
nIt = 0;  ymin = inf;  ymax = -inf;
for ip = 1:numel(res.Plist)
    for i = 1:size(res.hist, 2)
        hv = res.hist{ip, i};
        nIt = max(nIt, numel(hv) - 1);  ymin = min(ymin, min(hv));  ymax = max(ymax, max(hv));
    end
end
step = max(1, round(nIt/10));                         % markers on every step-th iteration
for ip = 1:numel(res.Plist)
    top = -inf;
    for i = 1:size(res.hist, 2)
        hv = res.hist{ip, i};  it = 0:numel(hv) - 1;
        plot(ax, it, hv, 'LineStyle', ls{i}, 'Color', col{ip}, 'LineWidth', s.lw);
        sel = 1:step:numel(hv);
        plot(ax, it(sel), hv(sel), 'LineStyle', 'none', 'Marker', mk{i}, 'Color', col{ip}, ...
             'MarkerSize', s.ms - 0.5, 'MarkerFaceColor', 'w');
        top = max(top, max(hv));
    end
    text(0.97*nIt, top + 0.03*(ymax - ymin), sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', res.Plist(ip)), ...
         'Color', col{ip}, 'FontName', s.font, 'FontSize', s.fsLegend, ...
         'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'Parent', ax);
end
h = zeros(1, 3);                                      % legend: initializations only
for i = 1:3
    h(i) = plot(ax, NaN, NaN, 'LineStyle', ls{i}, 'Marker', mk{i}, 'Color', [0.2 0.2 0.2], ...
                'LineWidth', s.lw, 'MarkerSize', s.ms - 0.5, 'MarkerFaceColor', 'w');
end
label_axes(ax, 'Iteration index', 'Objective value of (P3) (bps/Hz)');
xlim(ax, [0 nIt]);
ylim(ax, [max(0, ymin - 0.08*(ymax - ymin)), ymax + 0.6*(ymax - ymin)]);
add_legend(ax, h, {'UPA initialization', 'Random initialization 1', 'Random initialization 2'}, 'northwest');
save_figure('fig4_convergence');
end
