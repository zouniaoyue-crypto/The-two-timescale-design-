function plot_fig6(res, resN)
%PLOT_FIG6  Fig. 6: ESSR versus the transmit SNR for the MAs and the FPA with the power
%   allocation of Algorithm 1, with equal power p_m = q = P_tot/N (res, fig5_snr.m), and
%   without AN, q = 0 (resN, extra_no_an.m; same drops), i.e., the 3 x 2 design
%   {Algorithm 1, equal power, no AN} x {MAs, FPA}. The two-column legend (rows: Algorithm 1,
%   equal power, no AN; columns: MAs, FPA) is placed in the empty upper-left area; the
%   y-axis extends to 40 bps/Hz to leave room for it. Without resN, the 2 x 2 version
%   (pa_schemes.m) is drawn.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
if nargin < 2 || isempty(resN)
    keys = pa_schemes();                       % {'MA_full', 'MA_eq', 'FPA_full', 'FPA_eq'}
    [Y, keys] = pick_schemes(res, 'essr', keys);
    if isempty(keys), return; end
    keys = keys([1 3 2 4]);  Y = Y(:, [1 3 2 4]);   % rows: Algorithm 1, equal power
    yl = [0 35];
else
    keys = {'MA_full', 'FPA_full', 'MA_eq', 'FPA_eq', 'MA_noAN', 'FPA_noAN'};
    Y = zeros(numel(resN.values), numel(keys));
    [ok, i] = ismember(resN.values, res.values);
    if ~all(ok), error('plot_fig6: SNR grids of fig5_snr and extra_no_an differ'); end
    for k = 1:numel(keys)
        if any(strcmp(resN.schemes, keys{k}))
            Y(:, k) = resN.essr(:, strcmp(resN.schemes, keys{k}));
        else
            Y(:, k) = res.essr(i, strcmp(res.schemes, keys{k}));
        end
    end
    yl = [0 40];
end
x = resN_values(res, resN);
ax = plot_schemes(x, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [x(1) x(end)], 'XTick', x, 'YLim', yl, 'YTick', yl(1):5:yl(2));
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, legend_rows(items, 2), 'nw');
save_figure('fig6_essr_power');
end

function x = resN_values(res, resN)
if nargin < 2 || isempty(resN), x = res.values; else, x = resN.values; end
end
