function T = print_table_eve(res, snr)
%PRINT_TABLE_EVE  Table I of main.tex: ESSR (bps/Hz) of the main schemes (main_schemes.m)
%   and of the proposed design without AN, at the SNRs in snr (dB), for the worst-case
%   Eve (res.essr, used for optimization) and for an Eve that treats the other LUs'
%   signals as noise (res.essr_tin). T(k, :) = [worst-case at snr, TIN at snr].
if nargin < 2, snr = [10 20 30]; end
[~, ix] = ismember(snr, res.values);
assert(all(ix > 0), 'requested SNRs are not in res.values');
[W, keys] = pick_schemes(res, 'essr', [main_schemes(), {'MA_noAN'}]);
V = pick_schemes(res, 'essr_tin', keys);
T = [W(ix, :).', V(ix, :).'];
fprintf('\nTable I: ESSR (bps/Hz), worst-case Eve | TIN Eve, at %s dB\n', mat2str(snr));
for k = 1:numel(keys)
    fprintf('%-24s %s | %s\n', scheme_name(keys{k}), ...
            sprintf('%7.2f', T(k, 1:numel(snr))), sprintf('%7.2f', T(k, numel(snr)+1:end)));
end
end
