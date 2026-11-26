function plot_candidates(resU, resA, resB, resN, res5)
%PLOT_CANDIDATES  Figures of the rev-8 candidate comparisons (main_candidates.tex; not in
%   main.tex), in the style of Figs. 5-8 (scheme_style.m, legends inside the axes):
%     supp_essr_users     ESSR versus the number of LUs M            (resU, extra_num_users.m)
%     supp_essr_aod_error ESSR versus the AoD error of Eve at the BS  (resA, extra_eve_aod_error.m)
%     supp_essr_betae     ESSR versus the large-scale fading of Eve   (resB, extra_eve_beta.m)
%     supp_essr_noan      ESSR versus the SNR with and without AN     (resN, extra_no_an.m, with
%                         the AN-aided counterparts from res5, fig5_snr.m)
%     supp_fig6_noan      Fig. 6 with the two no-AN curves added (alternative to supp_essr_noan)
%   Empty inputs are skipped. Axis ranges and legend positions are set for the stored data.
if nargin >= 1 && ~isempty(resU)
    one(resU, 'Number of LUs {\itM}', resU.values, [0 40], 0:5:40, 2, 'se', 'supp_essr_users');
end
if nargin >= 2 && ~isempty(resA)
    one(resA, 'AoD error of Eve at the BS (rad)', 0:0.02:0.1, [14 24], 14:2:24, 2, 'nw', 'supp_essr_aod_error');
end
if nargin >= 3 && ~isempty(resB)
    one(resB, 'Large-scale fading of Eve {\it\beta}_e (dB)', resB.values, [14 26], 14:2:26, 2, 'nw', 'supp_essr_betae');
end
if nargin >= 5 && ~isempty(resN) && ~isempty(res5)
    xl = 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)';
    keys = {'MA_full', 'MA_noAN', 'FPA_full', 'FPA_noAN'};
    Y = merged(resN, res5, keys);
    ax = plot_schemes(resN.values, Y, keys);
    label_axes(ax, xl, 'ESSR (bps/Hz)');
    set(ax, 'XLim', resN.values([1 end]), 'XTick', resN.values, 'YLim', [0 35], 'YTick', 0:5:35);
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    place_legend(ax, legend_rows(items, 2), 'nw');
    save_figure('supp_essr_noan');
    % alternative: Fig. 6 (power allocation) with the no-AN curves added; rows of the
    % legend: Algorithm 1 / equal power / no AN; columns: MAs / FPA
    keys = {'MA_full', 'FPA_full', 'MA_eq', 'FPA_eq', 'MA_noAN', 'FPA_noAN'};
    Y = merged(resN, res5, keys);
    ax = plot_schemes(resN.values, Y, keys);
    label_axes(ax, xl, 'ESSR (bps/Hz)');
    set(ax, 'XLim', resN.values([1 end]), 'XTick', resN.values, 'YLim', [0 40], 'YTick', 0:5:40);   % room for the 3 x 2 legend
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    place_legend(ax, legend_rows(items, 2), 'nw');
    save_figure('supp_fig6_noan');
end
end

function one(r, xl, xt, yl, yt, nc, where, name)
[Y, keys] = pick_schemes(r, 'essr');
ax = plot_schemes(r.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
set(ax, 'XLim', r.values([1 end]), 'XTick', xt, 'YLim', yl, 'YTick', yt);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, legend_rows(items, nc), where);
save_figure(name);
end

function Y = merged(resN, res5, keys)
% ESSR columns of keys from extra_no_an (no-AN schemes) and fig5_snr (the others) on the
% SNR grid of extra_no_an (same drops)
Y = zeros(numel(resN.values), numel(keys));
for k = 1:numel(keys)
    if any(strcmp(resN.schemes, keys{k})), r = resN; else, r = res5; end
    j = find(strcmp(r.schemes, keys{k}), 1);
    [ok, i] = ismember(resN.values, r.values);
    if ~all(ok) || isempty(j), error('plot_candidates: %s not available on the SNR grid', keys{k}); end
    Y(:, k) = r.essr(i, j);
end
end
