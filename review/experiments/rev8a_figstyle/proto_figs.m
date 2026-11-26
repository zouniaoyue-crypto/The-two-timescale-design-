function proto_figs(resDir)
%PROTO_FIGS  Prototype of the rev-8 figure style (review only; the production plot code is
%   unchanged). Redraws Figs. 4-8 from the stored results in resDir with in-panel legends,
%   the validated palette (FPA in charcoal), Fig. 4 without the Monte Carlo curve, Fig. 5(b)
%   with the high-SNR predictions as legend-explained markers, and Fig. 8 as one panel
%   (kappa_e). Output: results_dir() (set MA_RESULTS_DIR to a preview folder).
s = fig_style();
ld = @(f) getfield(load(fullfile(resDir, [f '.mat'])), 'res');
st = styles();
keys5 = {'MA_full', 'MA_rate', 'AS', 'SPA_full', 'FPA_full'};
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
% ---------------- Fig. 4 ----------------
c = ld('fig4_convergence');  it = 0:c.nIt;
ax = new_figure();
red = st.MA_full.color;  dark = st.FPA_full.color;
a8  = struct('color', red, 'ls', '-',  'marker', 'none', 'lw', 1.2, 'name', 'Algorithm 2, {\itN} = 8');
a12 = struct('color', red, 'ls', '--', 'marker', 'none', 'lw', 1.2, 'name', 'Algorithm 2, {\itN} = 12');
mm  = struct('color', dark, 'ls', ':', 'marker', 'none', 'lw', 1.2, 'name', 'MM only, {\itN} = 8');
for iP = 1:2
    plot(ax, it, squeeze(mean(c.hist(1, iP, :, :), 3)), 'LineStyle', a8.ls, 'Color', red, 'LineWidth', a8.lw);
    plot(ax, it, squeeze(mean(c.hist(2, iP, :, :), 3)), 'LineStyle', a12.ls, 'Color', red, 'LineWidth', a12.lw);
end
plot(ax, it, mean(c.histMM, 1), 'LineStyle', mm.ls, 'Color', dark, 'LineWidth', mm.lw);
xlim(ax, [0 30]);  set(ax, 'XTick', 0:5:30, 'YLim', [0 24], 'YTick', 0:4:24);
label_axes(ax, 'Number of iterations', 'Objective value of (P3) (bps/Hz)');
lbl(ax, 29.5, 22.6, '{\itP}_{tot}/{\it\sigma}^2 = 20 dB', s);  lbl(ax, 29.5, 13.0, '10 dB', s);
place_legend(ax, {{a8}, {a12}, {mm}}, 'se');
save_figure('p_fig4_convergence');
% ---------------- Fig. 5(a) ----------------
f5 = ld('fig5_snr');
ax = new_figure();
Y = pick(f5, 'essr', keys5);
draw(ax, f5.values, Y, keys5, st);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [0 30], 'XTick', 0:5:30, 'YLim', [0 35], 'YTick', 0:5:35);
place_legend(ax, cellfun(@(k) {st.(k)}, keys5, 'UniformOutput', false), 'nw');
inset_lr(ax, f5.values, Y, keys5, st, s);
save_figure('p_fig5a_essr_snr');
% ---------------- Fig. 5(b) ----------------
ax = new_figure();
A = pick(f5, 'anfrac', keys5);  P = pick(f5, 'anpred', keys5);
draw(ax, f5.values, A, keys5, st);
pr = struct('color', [0 0 0], 'ls', 'none', 'marker', 'x', 'lw', 1.0, 'name', 'High-SNR prediction, (33)');
plot(ax, 30*ones(1, numel(keys5)), P(end, :), 'LineStyle', 'none', 'Marker', 'x', 'Color', [0 0 0], ...
     'MarkerSize', 7, 'LineWidth', 1.0);
label_axes(ax, xl, 'AN power fraction');
set(ax, 'XLim', [0 30], 'XTick', 0:5:30, 'YLim', [0 0.8], 'YTick', 0:0.1:0.8);
place_legend(ax, {{st.MA_full, st.MA_rate}, {st.AS, st.SPA_full}, {st.FPA_full, pr}}, 'nw');
save_figure('p_fig5b_an_fraction');
% ---------------- Fig. 6 ----------------
k6 = {'MA_full', 'MA_eq', 'FPA_full', 'FPA_eq'};
ax = new_figure();
draw(ax, f5.values, pick(f5, 'essr', k6), k6, st);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [0 30], 'XTick', 0:5:30, 'YLim', [0 35], 'YTick', 0:5:35);
place_legend(ax, {{st.MA_full, st.MA_eq}, {st.FPA_full, st.FPA_eq}}, 'nw');
save_figure('p_fig6_essr_power');
% ---------------- Fig. 7(a) ----------------
r7 = ld('fig7_region');
ax = new_figure();
draw(ax, r7.values, pick(r7, 'essr', keys5), keys5, st);
label_axes(ax, 'Side length of the movable region {\itA}/{\it\lambda}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [1.5 6], 'XTick', r7.values, 'YLim', [14 26], 'YTick', 14:2:26);
place_legend(ax, {{st.MA_full, st.MA_rate}, {st.AS, st.SPA_full}, {st.FPA_full, []}}, 'nw');
save_figure('p_fig7a_essr_region');
% ---------------- Fig. 7(b) ----------------
n = ld('extra_num_antennas');
ax = new_figure();
draw(ax, n.values, pick(n, 'essr', keys5), keys5, st);
label_axes(ax, 'Number of MAs {\itN}', 'ESSR (bps/Hz)');
set(ax, 'XLim', [4 16], 'XTick', n.values, 'YLim', [10 24], 'YTick', 10:2:24);
place_legend(ax, cellfun(@(k) {st.(k)}, keys5, 'UniformOutput', false), 'se');
save_figure('p_fig7b_essr_antennas');
% ---------------- Fig. 8 (one panel, kappa_e) ----------------
kb = ld('fig8_rician_b');
ax = new_figure();
draw(ax, kb.values, pick(kb, 'essr', keys5), keys5, st);
label_axes(ax, 'Rician factor of Eve {\it\kappa}_e (dB)', 'ESSR (bps/Hz)');
set(ax, 'XLim', [-10 20], 'XTick', kb.values, 'YLim', [12 22], 'YTick', 12:2:22);
place_legend(ax, {{st.MA_full, st.MA_rate}, {st.AS, st.SPA_full}, {st.FPA_full, []}}, 'sw');
save_figure('p_fig8_essr_kappae');
end

function st = styles()
red = hexc('B03A2E');  blue = hexc('2E6DB4');  teal = hexc('2A9D8F');  ochre = hexc('C7852B');  char = hexc('3D3D3D');
mk = @(name, c, ls, m, lw, mfc) struct('name', name, 'color', c, 'ls', ls, 'marker', m, 'lw', lw, 'mfc', mfc);
st.MA_full  = mk('Proposed',          red,   '-',  'o', 1.4, 'w');
st.MA_rate  = mk('Rate-oriented MA',  blue,  '-',  's', 1.0, 'w');
st.AS       = mk('AS',                teal,  '-.', '^', 1.0, 'w');
st.SPA_full = mk('Sparse FPA',        ochre, '--', 'v', 1.0, 'w');
st.FPA_full = mk('FPA',               char,  '--', 'd', 1.0, 'w');
st.MA_eq    = mk('MA, equal power',   red,   ':',  'o', 1.0, red);
st.FPA_eq   = mk('FPA, equal power',  char,  ':',  'd', 1.0, char);
end

function Y = pick(res, field, keys)
Y = zeros(numel(res.values), numel(keys));
for k = 1:numel(keys), Y(:, k) = res.(field)(:, find(strcmp(res.schemes, keys{k}), 1)); end
end

function draw(ax, x, Y, keys, st)
for k = numel(keys):-1:1, plot_curve(ax, x, Y(:, k), st.(keys{k})); end
end

function lbl(ax, x, y, str, s)
text(x, y, str, 'Parent', ax, 'FontName', s.font, 'FontSize', s.fsLegend, ...
     'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
end

function inset_lr(ax, x, Y, keys, st, s)
x0 = 20;  dx = 0.5;  inner = {'MA_rate', 'SPA_full', 'AS'};
lo = inf;  hi = -inf;
for k = 1:numel(inner)
    j = find(strcmp(keys, inner{k}), 1);
    yk = interp1(x, Y(:, j), [x0 - dx, x0 + dx]);  lo = min(lo, min(yk));  hi = max(hi, max(yk));
end
pad = 0.12*(hi - lo);  lo = lo - pad;  hi = hi + pad;
rectangle('Parent', ax, 'Position', [x0 - dx, lo, 2*dx, hi - lo], 'EdgeColor', s.edge, 'LineWidth', s.axLw);
p = get(ax, 'Position');
axi = axes('Parent', get(ax, 'Parent'), 'Units', 'inches', ...
           'Position', [p(1) + 0.62*p(3), p(2) + 0.06*p(4), 0.30*p(3), 0.25*p(4)]);
style_axes(axi);  set(axi, 'Color', 'w');
for k = numel(keys):-1:1, plot_curve(axi, x, Y(:, k), st.(keys{k})); end
set(axi, 'XLim', [x0 - dx, x0 + dx], 'YLim', [lo hi], 'XTick', x0, 'XTickLabel', {}, ...
         'YTick', ceil(lo):floor(hi), 'FontSize', s.fsTick);
text(x0 + 0.04*dx, lo + 0.04*(hi - lo), sprintf('%d dB', x0), 'Parent', axi, 'FontName', s.font, ...
     'FontSize', s.fsLegend, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
end

function c = hexc(h)
c = [hex2dec(h(1:2)) hex2dec(h(3:4)) hex2dec(h(5:6))]/255;
end
