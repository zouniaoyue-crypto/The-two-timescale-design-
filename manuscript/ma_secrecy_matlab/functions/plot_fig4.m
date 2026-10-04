function plot_fig4(res, P_dB)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2 for one realization of the AoDs at
%   P_tot/sigma^2 = P_dB (default 20 dB) and three initializations (the 10 and 30 dB
%   runs stored in res are quoted in the text). Markers every 10 iterations, staggered
%   by 3 iterations between the curves to avoid overlaps.
if nargin < 2, P_dB = 20; end
s = fig_style();
ip = find(res.Plist == P_dB, 1);
ax = new_figure();
col = {[0.80 0.10 0.12], [0.00 0.38 0.70], [0.90 0.55 0.00]};
ls  = {'-', '--', '-.'};  mk = {'o', 's', '^'};  off = [0 3 6];
names = {'UPA initialization', 'Random initialization 1', 'Random initialization 2'};
h = zeros(1, 3);  lo = inf;  hi = -inf;  nIt = 0;
for i = 1:size(res.hist, 2)
    hv = res.hist{ip, i};  it = 0:numel(hv) - 1;  nIt = max(nIt, it(end));
    plot(ax, it, hv, 'LineStyle', ls{i}, 'Color', col{i}, 'LineWidth', s.lw);
    sel = 1 + off(i):10:numel(hv);
    plot(ax, it(sel), hv(sel), 'LineStyle', 'none', 'Marker', mk{i}, 'Color', col{i}, ...
         'MarkerSize', s.ms, 'LineWidth', s.lw, 'MarkerFaceColor', 'w');
    h(i) = plot(ax, NaN, NaN, 'LineStyle', ls{i}, 'Marker', mk{i}, 'Color', col{i}, ...
                'LineWidth', s.lw, 'MarkerSize', s.ms, 'MarkerFaceColor', 'w');
    lo = min(lo, min(hv));  hi = max(hi, max(hv));
end
xlim(ax, [0 nIt]);  set(ax, 'XTick', 0:10:nIt);
ylim(ax, [floor(2*lo)/2, ceil(2*hi)/2 + 0.5]);
set(ax, 'YTick', ceil(lo):1:floor(hi + 0.5));
label_axes(ax, 'Iteration index', 'Objective value (bps/Hz)');
add_legend(ax, h, names, 'southeast');
save_figure('fig4_convergence');
end
