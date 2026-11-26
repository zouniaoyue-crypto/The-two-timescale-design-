function plot_candidates(resU, resA, resB, resN, res5, where)
%PLOT_CANDIDATES  Supplementary figures of the rev-8 candidate comparisons (not in main.tex),
%   in the style of Figs. 5-8 (scheme_style.m, legends inside the axes):
%     supp_essr_users     ESSR versus the number of LUs M            (resU, extra_num_users.m)
%     supp_essr_aod_error ESSR versus the AoD error of Eve at the BS  (resA, extra_eve_aod_error.m)
%     supp_essr_betae     ESSR versus the large-scale fading of Eve   (resB, extra_eve_beta.m)
%     supp_essr_noan      ESSR versus the SNR with and without AN     (resN, extra_no_an.m, with
%                         the AN-aided counterparts from res5, fig5_snr.m)
%   Empty inputs are skipped. where (optional): struct with the legend positions (fields
%   users, aod, betae, noan; see place_legend.m).
if nargin < 6 || isempty(where), where = struct(); end
loc = struct('users', 'nw', 'aod', 'sw', 'betae', 'sw', 'noan', 'nw');
for f = fieldnames(where).', loc.(f{1}) = where.(f{1}); end
if ~isempty(resU)
    one(resU, 'Number of LUs {\itM}', resU.values, loc.users, 'supp_essr_users');
end
if ~isempty(resA)
    one(resA, 'AoD error of Eve at the BS (rad)', 0:0.02:0.1, loc.aod, 'supp_essr_aod_error');
end
if ~isempty(resB)
    one(resB, 'Large-scale fading of Eve {\it\beta}_e (dB)', resB.values, loc.betae, 'supp_essr_betae');
end
if ~isempty(resN) && ~isempty(res5)
    keys = {'MA_full', 'MA_noAN', 'FPA_full', 'FPA_noAN'};
    Y = zeros(numel(resN.values), numel(keys));
    for k = 1:numel(keys)
        if any(strcmp(resN.schemes, keys{k})), r = resN; else, r = res5; end
        j = find(strcmp(r.schemes, keys{k}), 1);
        [ok, i] = ismember(resN.values, r.values);
        if ~all(ok), error('plot_candidates: SNR grids of extra_no_an and fig5_snr differ'); end
        Y(:, k) = r.essr(i, j);
    end
    ax = plot_schemes(resN.values, Y, keys);
    label_axes(ax, 'Transmit SNR {\itP}_{tot}/{\it\sigma}^2 (dB)', 'ESSR (bps/Hz)');
    lim(ax, resN.values, resN.values, Y);
    items = cellfun(@scheme_style, keys, 'UniformOutput', false);
    place_legend(ax, legend_rows(items, 2), loc.noan);
    save_figure('supp_essr_noan');
end
end

function one(r, xl, xt, where, name)
[Y, keys] = pick_schemes(r, 'essr');
ax = plot_schemes(r.values, Y, keys);
label_axes(ax, xl, 'ESSR (bps/Hz)');
lim(ax, r.values, xt, Y);
items = cellfun(@scheme_style, keys, 'UniformOutput', false);
place_legend(ax, legend_rows(items, 2), where);
save_figure(name);
end

function lim(ax, x, xt, Y)
lo = 2*floor(min(Y(:))/2);  hi = 2*ceil(max(Y(:))/2);
st = 2;  if hi - lo > 16, st = 4; end
lo = st*floor(lo/st);  hi = st*ceil(hi/st) + st;       % headroom for the legend
set(ax, 'XLim', [x(1) x(end)], 'XTick', xt, 'YLim', [lo hi], 'YTick', lo:st:hi);
end
