function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2 for one realization of the AoDs.
%   One panel per transmit SNR (highest SNR on top), stacked with a common iteration
%   axis. Each panel has its own y-axis, so that the convergence of every run is
%   visible although the objective values at different SNRs differ by about 10 bps/Hz.
%   Colors, line styles, and markers distinguish the initializations; the legend is
%   drawn as one compact row above the panels, and the markers are staggered.
s = fig_style();
W = s.width;  H = 3.0;                                  % three stacked panels, one column
L = 0.50;  R = 0.15;  B = 0.40;  T = 0.25;  G = 0.07;  % margins and gap between panels (in)
nP = numel(res.Plist);
ph = (H - B - T - (nP - 1)*G)/nP;                       % panel height (in)
f = figure('Color', 'w', 'Units', 'inches', 'Position', [1 1 W H]);
set(f, 'PaperUnits', 'inches', 'PaperPosition', [0 0 W H], 'PaperSize', [W H]);
col = {[0.84 0.15 0.16], [0.12 0.47 0.71], [0.17 0.63 0.17]};
ls  = {'-', '--', '-.'};  mk = {'o', 's', '^'};  off = [0 3 6];
names = {'UPA init.', 'Random init. 1', 'Random init. 2'};
nIt = 0;
for k = 1:numel(res.hist), nIt = max(nIt, numel(res.hist{k}) - 1); end
ax = zeros(1, nP);
for r = 1:nP
    ip = nP + 1 - r;                                    % r = 1: top panel, highest SNR
    ax(r) = axes('Parent', f, 'Units', 'inches', 'Position', [L, B + (nP - r)*(ph + G), W - L - R, ph]);
    hold(ax(r), 'on');  box(ax(r), 'on');  grid(ax(r), 'on');
    set(ax(r), 'FontName', s.font, 'FontSize', s.fsTick, 'LineWidth', s.axLw, 'TickDir', 'in', ...
               'GridLineStyle', ':', 'Layer', 'bottom');   % grid below the label background
    try, set(ax(r), 'GridAlpha', 0.45, 'TickLength', [0.012 0.012]); catch, end   %#ok<CTCH>
    lo = inf;  hi = -inf;
    for i = 1:size(res.hist, 2)
        hv = res.hist{ip, i};  it = 0:numel(hv) - 1;
        plot(ax(r), it, hv, 'LineStyle', ls{i}, 'Color', col{i}, 'LineWidth', s.lw);
        sel = 1 + off(i):10:numel(hv);                  % markers every 10 iterations, staggered
        plot(ax(r), it(sel), hv(sel), 'LineStyle', 'none', 'Marker', mk{i}, 'Color', col{i}, ...
             'MarkerSize', s.ms - 0.5, 'MarkerFaceColor', 'w');
        lo = min(lo, min(hv));  hi = max(hi, max(hv));
    end
    rg = hi - lo;  y0 = lo - 0.14*rg;  y1 = hi + 0.12*rg;
    ylim(ax(r), [y0 y1]);
    set(ax(r), 'YTick', ceil(y0):1:floor(y1));
    xlim(ax(r), [0 nIt]);  set(ax(r), 'XTick', 0:10:nIt);
    if r < nP, set(ax(r), 'XTickLabel', {}); end
    text(0.985*nIt, y0 + 0.08*(y1 - y0), sprintf('{\\itP}_{tot}/{\\it\\sigma}^2 = %d dB', res.Plist(ip)), ...
         'FontName', s.font, 'FontSize', s.fsLegend, 'HorizontalAlignment', 'right', ...
         'VerticalAlignment', 'bottom', 'BackgroundColor', 'w', 'Margin', 1, 'Parent', ax(r));
end
xlabel(ax(nP), 'Iteration index', 'FontName', s.font, 'FontSize', s.fsLabel);
ylabel(ax(ceil(nP/2)), 'Objective value of (P3) (bps/Hz)', 'FontName', s.font, 'FontSize', s.fsLabel);
% legend: one row above the panels (drawn manually for short line samples)
wl = W - L - R;  hl = T - 0.07;
lax = axes('Parent', f, 'Units', 'inches', 'Position', [L, H - T + 0.035, wl, hl]);
hold(lax, 'on');
set(lax, 'XLim', [0 wl], 'YLim', [0 hl], 'Visible', 'off');
sw = 0.22;  tg = 0.05;  eg = 0.12;  yc = hl/2;          % sample width and gaps (in)
% text widths estimated from the number of characters (about 0.045 in per character
% for 7.5-pt Times), since the 'Extent' of text objects is not reliable in Octave
tw = 0.045*cellfun(@numel, names);
th = zeros(1, 3);
for i = 1:3
    th(i) = text(0, yc, names{i}, 'FontName', s.font, 'FontSize', s.fsLegend, ...
                 'VerticalAlignment', 'middle', 'Parent', lax);
end
x = (wl - (3*(sw + tg) + sum(tw) + 2*eg))/2;
for i = 1:3
    plot(lax, [x, x + sw], [yc yc], 'LineStyle', ls{i}, 'Color', col{i}, 'LineWidth', s.lw);
    plot(lax, x + sw/2, yc, 'LineStyle', 'none', 'Marker', mk{i}, 'Color', col{i}, ...
         'MarkerSize', s.ms - 0.5, 'MarkerFaceColor', 'w');
    set(th(i), 'Position', [x + sw + tg, yc, 0]);
    x = x + sw + tg + tw(i) + eg;
end
plot(lax, [0 wl wl 0 0], [0 0 hl hl 0], 'Color', [0.3 0.3 0.3], 'LineWidth', 0.5);   % frame
save_figure('fig4_convergence', f);
end
