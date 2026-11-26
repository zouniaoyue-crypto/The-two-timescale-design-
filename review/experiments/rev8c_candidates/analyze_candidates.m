function analyze_candidates()
%ANALYZE_CANDIDATES  Numbers of the rev-8c candidate comparisons (supplementary, not in
%   main.tex), computed from the stored results: extra_num_users.mat, extra_eve_aod_error.mat,
%   extra_eve_beta.mat, extra_no_an.mat, and fig5_snr.mat (AN-aided counterparts). Run from
%   manuscript/ma_secrecy_matlab (or with it on the path); output used in
%   review/rev8c_candidates_report.md (review/experiments/rev8c_candidates/analysis.txt).
R = results_dir();
ld = @(f) getfield(load(fullfile(R, [f '.mat'])), 'res');
col = @(res, key) find(strcmp(res.schemes, key), 1);
keys = main_schemes();  names = {'Proposed', 'Rate-MA', 'AS', 'SparseFPA', 'FPA'};
f5 = ld('fig5_snr');  i20 = find(f5.values == 20);
J5 = cellfun(@(k) col(f5, k), keys);

sweep(ld('extra_num_users'), 'M', '%d');
U = ld('extra_num_users');  J = cellfun(@(k) col(U, k), keys);
fprintf('check: M = 3 equals Fig. 5 at 20 dB (max |diff|) %.2e\n', max(abs(U.essr(U.values == 3, J) - f5.essr(i20, J5))));
fprintf('ESSR per LU (proposed):'); fprintf(' %.2f', U.essr(:, J(1))./U.values(:)); fprintf('\n');
fprintf('rate-oriented MA equals FPA at M = 1 (max |diff|): %.2e\n', abs(diff(U.essr(U.values == 1, J([2 5])))));

sweep(ld('extra_eve_aod_error'), 'AoD error (rad)', '%.2f');
A = ld('extra_eve_aod_error');  J = cellfun(@(k) col(A, k), keys);
fprintf('check: error 0 equals Fig. 5 at 20 dB (max |diff|) %.2e\n', max(abs(A.essr(A.values == 0, J) - f5.essr(i20, J5))));
fprintf('loss relative to error 0 (%%):\n');
for k = 1:numel(keys)
    fprintf('  %-10s', names{k}); fprintf(' %7.2f', 100*(A.essr(:, J(k))/A.essr(1, J(k)) - 1)); fprintf('\n');
end

sweep(ld('extra_eve_beta'), 'beta_e (dB)', '%d');
B = ld('extra_eve_beta');  J = cellfun(@(k) col(B, k), keys);
fprintf('check: beta_e = 0 dB equals Fig. 5 at 20 dB (max |diff|) %.2e\n', max(abs(B.essr(B.values == 0, J) - f5.essr(i20, J5))));

N = ld('extra_no_an');
iN = arrayfun(@(v) find(f5.values == v), N.values);
ma  = f5.essr(iN, col(f5, 'MA_full'));   fpa  = f5.essr(iN, col(f5, 'FPA_full'));
ma0 = N.essr(:, col(N, 'MA_noAN'));       fpa0 = N.essr(:, col(N, 'FPA_noAN'));
fprintf('\n=== AN ablation (ESSR, bps/Hz) ===\nSNR (dB)        '); fprintf(' %7d', N.values); fprintf('\n');
fprintf('Proposed       '); fprintf(' %7.2f', ma);   fprintf('\n');
fprintf('Proposed w/o AN'); fprintf(' %7.2f', ma0);  fprintf('\n');
fprintf('FPA            '); fprintf(' %7.2f', fpa);  fprintf('\n');
fprintf('FPA w/o AN     '); fprintf(' %7.2f', fpa0); fprintf('\n');
fprintf('AN gain, MA  (%%)'); fprintf(' %7.1f', 100*(ma./ma0 - 1));   fprintf('\n');
fprintf('AN gain, FPA (%%)'); fprintf(' %7.1f', 100*(fpa./fpa0 - 1)); fprintf('\n');
fprintf('MA gain over FPA, with AN (%%)   '); fprintf(' %7.1f', 100*(ma./fpa - 1));   fprintf('\n');
fprintf('MA gain over FPA, without AN (%%)'); fprintf(' %7.1f', 100*(ma0./fpa0 - 1)); fprintf('\n');
fprintf('MA w/o AN minus FPA with AN      '); fprintf(' %7.2f', ma0 - fpa);         fprintf('\n');
fprintf('high-SNR slope 25->30 dB (bps/Hz per dB): MA %.3f, MA w/o AN %.3f, FPA %.3f, FPA w/o AN %.3f\n', ...
        (ma(end)-ma(end-1))/5, (ma0(end)-ma0(end-1))/5, (fpa(end)-fpa(end-1))/5, (fpa0(end)-fpa0(end-1))/5);
d = squeeze(N.essrDrops(N.values == 20, col(N, 'MA_noAN'), :) - f5.essrDrops(i20, col(f5, 'FPA_full'), :));
fprintf('20 dB: MA w/o AN minus FPA with AN %.3f (paired SE %.3f)\n', mean(d), std(d)/sqrt(numel(d)));
end

function sweep(r, lab, fmt)
keys = main_schemes();  names = {'Proposed', 'Rate-MA', 'AS', 'SparseFPA', 'FPA'};
J = cellfun(@(k) find(strcmp(r.schemes, k), 1), keys);
fprintf('\n=== ESSR (bps/Hz) versus %s ===\n%-14s', lab, lab); fprintf([' ' fmt '    '], r.values); fprintf('\n');
for k = 1:numel(keys)
    fprintf('%-14s', names{k}); fprintf(' %7.2f', r.essr(:, J(k))); fprintf('\n');
end
for k = 2:numel(keys)
    fprintf('gain vs %-6s%%', names{k}(1:min(6, end))); fprintf(' %7.1f', 100*(r.essr(:, J(1))./r.essr(:, J(k)) - 1)); fprintf('\n');
end
fprintf('gain vs FPA (bps/Hz)'); fprintf(' %7.2f', r.essr(:, J(1)) - r.essr(:, J(5))); fprintf('\n');
fprintf('AN fraction  ');
for k = [1 2 5], fprintf(' | %s', names{k}); fprintf(' %.2f', r.anfrac(:, J(k))); end
fprintf('\n');
D = r.essrDrops;  se = zeros(1, numel(r.values));  dm = se;
for i = 1:numel(r.values)
    d = squeeze(D(i, J(1), :) - D(i, J(2), :));  dm(i) = mean(d);  se(i) = std(d)/sqrt(numel(d));
end
fprintf('proposed - rate-MA (paired SE)'); fprintf(' %.2f(%.2f)', [dm; se]); fprintf('\n');
end
