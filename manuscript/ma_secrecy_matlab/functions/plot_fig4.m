function plot_fig4(res)
%PLOT_FIG4  Fig. 4: convergence of Algorithm 2. Objective value of (P3) versus the number
%   of AO iterations, averaged over the drops, for (N, P_tot/sigma^2) in {8, 12} x {10, 20} dB
%   (UPA initialization), drawn as continuous lines through all iterations without markers
%   (colors: SNR; line styles: N). The dotted gray curve shows Algorithm 2 without the
%   global search of Stage 1 (pure MM updates) for N = 8, 20 dB.
s = fig_style();
ax = new_figure();
it = 0:res.nIt;
c = fig_palette();  blue = c.blue;  red = c.verm;
sty = {struct('color', blue, 'ls', '-',  'marker', 'none', 'lw', 1.3), ...    % N = 8,  10 dB
       struct('color', blue, 'ls', '--', 'marker', 'none', 'lw', 1.3), ...    % N = 12, 10 dB
       struct('color', red,  'ls', '-',  'marker', 'none', 'lw', 1.3), ...    % N = 8,  20 dB
       struct('color', red,  'ls', '--', 'marker', 'none', 'lw', 1.3)};       % N = 12, 20 dB
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
st = struct('color', c.gray, 'ls', ':', 'marker', 'none', 'lw', 1.5);
draw(ax, it, mean(res.histMM, 1), st, s);
st.name = '{\itN} = 8, 20 dB, MM only';
xlim(ax, [0 res.nIt]);  set(ax, 'XTick', 0:10:res.nIt);
set(ax, 'YLim', [0 24], 'YTick', 0:4:24);
label_axes(ax, 'Number of iterations', 'Objective value of (P3) (bps/Hz)');
% legend in the empty band below the 10-dB curves (2 columns)
m = s.margins;
manual_legend(gcf, [m(1) + 0.55, m(2) + 0.06, 2.30, 0.50], ...
              {{items{1}, items{3}}, {items{2}, items{4}}, {st, []}}, 1.10, 0.145);
save_figure('fig4_convergence');
end

function draw(ax, x, y, st, s)
lw = 1.3;  if isfield(st, 'lw'), lw = st.lw; end
plot(ax, x, y, 'LineStyle', st.ls, 'Color', st.color, 'LineWidth', lw);
end
