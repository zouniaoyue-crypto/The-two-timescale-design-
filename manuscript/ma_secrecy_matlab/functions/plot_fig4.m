function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2. Objective value of (P3) versus the number
%   of AO iterations, averaged over the drops, for (N, P_tot/sigma^2) in {8, 12} x {10, 20} dB
%   (UPA initialization), drawn as continuous lines without markers; the x-axis shows the
%   first 30 of the res.nIt iterations, since all the curves converge within about 15
%   iterations (colors: SNR; line styles: N). The dotted gray curve shows Algorithm 2 without the
%   grid search of Stage 1 (pure MM updates) for N = 8, 20 dB. If available (res.essrIt),
%   the Monte Carlo ESSR of the iterates for N = 8, 20 dB is drawn in purple with filled
%   markers, i.e., the actual ESSR along the iterations of the deterministic objective.
s = fig_style();
ax = new_figure();
it = 0:res.nIt;
c = fig_palette();  blue = c.blue;  red = c.red;
sty = {struct('color', blue, 'ls', '-',  'marker', 'none', 'lw', 1.0), ...    % N = 8,  10 dB
       struct('color', blue, 'ls', '--', 'marker', 'none', 'lw', 1.0), ...    % N = 12, 10 dB
       struct('color', red,  'ls', '-',  'marker', 'none', 'lw', 1.0), ...    % N = 8,  20 dB
       struct('color', red,  'ls', '--', 'marker', 'none', 'lw', 1.0)};       % N = 12, 20 dB
items = {};  k = 0;
for iP = 1:numel(res.Plist)
    for iN = 1:numel(res.Nlist)
        k = k + 1;  st = sty{k};
        hm = squeeze(mean(res.hist(iN, iP, :, :), 3)).';
        draw(ax, it, hm, st, s);
        st.name = sprintf('{\\itN} = %d, %d dB', res.Nlist(iN), res.Plist(iP));
        items{end+1} = st; %#ok<AGROW>
    end
end
st = struct('color', c.gray, 'ls', ':', 'marker', 'none', 'lw', 1.2);
draw(ax, it, mean(res.histMM, 1), st, s);
st.name = '{\itN} = 8, 20 dB, MM only';  st.span = true;
rows = {{items{1}, items{3}}, {items{2}, items{4}}, {st, []}};
if isfield(res, 'essrIt') && any(res.essrIt(:))
    mc = struct('color', c.purple, 'ls', '-', 'marker', 'o', 'lw', 0.8, 'mfc', c.purple);
    e = mean(res.essrIt, 1);  k = 1:2:numel(e);       % markers at every second iteration
    plot(ax, it, e, 'LineStyle', '-', 'Color', c.purple, 'LineWidth', 0.8);
    plot(ax, it(k), e(k), 'LineStyle', 'none', 'Marker', 'o', 'Color', c.purple, ...
         'MarkerSize', s.ms, 'MarkerFaceColor', c.purple, 'LineWidth', 0.8);
    mc.name = '{\itN} = 8, 20 dB, Monte Carlo';  mc.span = true;
    rows{end+1} = {mc, []};
end
xlim(ax, [0 30]);  set(ax, 'XTick', 0:5:30);   % converged within about 15 iterations
set(ax, 'YLim', [0 24], 'YTick', 0:4:24);
label_axes(ax, 'Number of iterations', 'ESSR (bps/Hz)');
% legend in the empty band below the 10-dB curves (2 columns), right of the initial rise
place_legend(ax, rows, 'se');
save_figure('fig4_convergence');
end

function draw(ax, x, y, st, s)
lw = s.lw;  if isfield(st, 'lw'), lw = st.lw; end
plot(ax, x, y, 'LineStyle', st.ls, 'Color', st.color, 'LineWidth', lw);
end
