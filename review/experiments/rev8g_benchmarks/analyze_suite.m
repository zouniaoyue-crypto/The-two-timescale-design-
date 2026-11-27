function analyze_suite()
%ANALYZE_SUITE  rev-8g: ESSR tables of the final benchmark suite (main_schemes.m:
%   proposed, rate-oriented MA, FPA with Eve-aware AN, FPA) for all sweeps of Section V,
%   gains of the proposed design, paired differences (mean (standard error over the drops)),
%   AN fractions, the oracle check of the AN power of the Eve-aware AN, and the mechanism
%   table. Run from manuscript/ma_secrecy_matlab.
R = results_dir();
ld = @(f) getfield(load(fullfile(R, [f '.mat'])), 'res');
keys = main_schemes();  nm = {'Prop', 'Rate', 'EAN', 'FPA'};
sw = {'fig5_snr', 'P (dB)'; 'fig7_region', 'A'; 'extra_num_antennas', 'N'; 'extra_num_users', 'M'; ...
      'fig8_rician_b', 'kappa_e'; 'fig8_rician_a', 'kappa'};
for s = 1:size(sw, 1)
    r = ld(sw{s, 1});
    J = cellfun(@(k) find(strcmp(r.schemes, k), 1), keys);
    fprintf('\n=== %s (%s) ===\n%-8s', sw{s, 1}, sw{s, 2}, sw{s, 2}); fprintf(' %7g', r.values); fprintf('\n');
    for k = 1:4, fprintf('%-8s', nm{k}); fprintf(' %7.2f', r.essr(:, J(k))); fprintf('\n'); end
    for k = 2:4
        fprintf('g/%-6s', nm{k}); fprintf(' %6.1f%%', 100*(r.essr(:, J(1))./r.essr(:, J(k)) - 1)); fprintf('\n');
    end
    fprintf('EAN/FPA '); fprintf(' %6.1f%%', 100*(r.essr(:, J(3))./r.essr(:, J(4)) - 1)); fprintf('\n');
    for pr = {[1 3], [3 2], [3 4], [1 2]}
        a = pr{1}(1);  b = pr{1}(2);
        d = squeeze(r.essrDrops(:, J(a), :) - r.essrDrops(:, J(b), :));
        if isvector(d), d = d(:).'; end
        fprintf('%s-%s', nm{a}, nm{b}); fprintf(' %6.2f(%.2f)', [mean(d, 2).'; std(d, 0, 2).'/sqrt(size(d, 2))]); fprintf('\n');
    end
    if isfield(r, 'anfrac')
        for k = 1:4, fprintf('AN %-5s', nm{k}); fprintf(' %7.3f', r.anfrac(:, J(k))); fprintf('\n'); end
    end
end
f5 = ld('fig5_snr');  J = cellfun(@(k) find(strcmp(f5.schemes, k), 1), keys);
fprintf('\nfig5 anpred at 30 dB: '); fprintf(' %.3f', f5.anpred(end, J)); fprintf('\n');
fprintf('fig5 anpred - anfrac at 30 dB: '); fprintf(' %.4f', f5.anpred(end, J) - f5.anfrac(end, J)); fprintf('\n');
fprintf('fig5 ESSR - F (approximation gap), rows = SNR:\n'); disp(round(100*(f5.essr(:, J) - f5.F(:, J)))/100);
e = ld('extra_ean_check');
fprintf('\nAN power of Algorithm 1 vs oracle AN power fraction (Monte Carlo, %d drops):\n', size(e.alg1, 1));
for k = 1:2
    d = e.oracle(:, k) - e.alg1(:, k);
    fprintf('%-9s Alg.1 %.3f  oracle %.3f  diff %.3f (%.3f) = %.2f%%, mean oracle fraction %.3f\n', e.labels{k}, ...
            mean(e.alg1(:, k)), mean(e.oracle(:, k)), mean(d), std(d)/sqrt(numel(d)), 100*mean(d)/mean(e.alg1(:, k)), mean(e.frac(:, k)));
end
tm = ld('table_mechanisms');
fprintf('\nmechanisms (20 dB): scheme rho1 etaN xi1 psi Xi1 essr anfrac ReMC ReApprox F\n');
for k = 1:numel(tm.schemes)
    fprintf('%-9s %.3f %.3f %6.2f %6.2f %6.3f %6.2f %.3f', tm.schemes{k}, mean(tm.rho1(:, k)), mean(tm.etaN(:, k)), ...
            mean(tm.xi(:, k, 1)), mean(tm.psi(:, k)), mean(tm.Xi(:, k, 1)), mean(tm.essr(:, k)), mean(tm.anfrac(:, k)));
    if isfield(tm, 'ReMC'), fprintf(' %6.3f %6.3f %6.2f', mean(tm.ReMC(:, k)), mean(tm.ReApprox(:, k)), mean(tm.F(:, k))); end
    fprintf('\n');
end
end
