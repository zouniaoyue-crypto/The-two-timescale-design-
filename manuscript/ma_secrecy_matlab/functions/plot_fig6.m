function plot_fig6(res, resN)
%PLOT_FIG6  Fig. 6 (two panels): ESSR versus the transmit SNR for the MAs and the FPA,
%   (a) with the power allocation of Algorithm 1 and with equal power p_m = q = P_tot/N
%       (res, fig5_snr.m; keys of pa_schemes.m), file fig6a_essr_power_eq;
%   (b) with the isotropic AN of Algorithm 1 and without AN, q = 0 (resN, extra_no_an.m;
%       same drops), file fig6b_essr_power_noan.
%   Each panel has a two-column legend (columns: MAs, FPA) in the empty upper-left area; the
%   y-axis extends to 40 bps/Hz (as in Fig. 5(a)), so that the legend clears the curves.
%   Panel (b) is skipped without resN.
xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
draw(res, [], {'MA_full', 'FPA_full', 'MA_eq', 'FPA_eq'}, xl, 'fig6a_essr_power_eq');
if nargin >= 2 && ~isempty(resN)
    draw(res, resN, {'MA_full', 'FPA_full', 'MA_noAN', 'FPA_noAN'}, xl, 'fig6b_essr_power_noan');
end
end

function draw(res, resN, keys, xl, name)
% Takes each scheme from resN if it is stored there, otherwise from res (same SNR grid).
x = res.values;
Y = zeros(numel(x), numel(keys));
for k = 1:numel(keys)
    if ~isempty(resN) && any(strcmp(resN.schemes, keys{k}))
        [ok, i] = ismember(x, resN.values);
        if ~all(ok), error('plot_fig6: SNR grids of fig5_snr and extra_no_an differ'); end
        Y(:, k) = resN.essr(i, strcmp(resN.schemes, keys{k}));
    elseif any(strcmp(res.schemes, keys{k}))
        Y(:, k) = res.essr(:, strcmp(res.schemes, keys{k}));
    else
        error('plot_fig6: scheme %s not found', keys{k});
    end
end
ax = plot_schemes(x, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', [x(1) x(end)], 'XTick', x, 'YLim', [0 40], 'YTick', 0:5:40);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, legend_rows(items, 2), 'nw');
save_figure(name);
end
