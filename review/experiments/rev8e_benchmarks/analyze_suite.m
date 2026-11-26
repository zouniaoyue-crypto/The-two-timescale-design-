function analyze_suite()
%ANALYZE_SUITE  rev-8e: ESSR tables of the new benchmark suite (main_schemes.m) for all
%   sweeps of Section V, gains of the proposed design, paired differences of the new
%   benchmarks, and AN fractions. Run from manuscript/ma_secrecy_matlab.
R = results_dir();
ld = @(f) getfield(load(fullfile(R, [f '.mat'])), 'res');
keys = main_schemes();  nm = {'Prop', 'Rate', 'Null', 'APS', 'FPA'};
sw = {'fig5_snr', 'P (dB)'; 'fig7_region', 'A'; 'extra_num_antennas', 'N'; 'extra_num_users', 'M'; ...
      'fig8_rician_b', 'kappa_e'; 'fig8_rician_a', 'kappa'};
for s = 1:size(sw, 1)
    r = ld(sw{s, 1});
    J = cellfun(@(k) find(strcmp(r.schemes, k), 1), keys);
    fprintf('\n=== %s (%s) ===\n%-8s', sw{s, 1}, sw{s, 2}, sw{s, 2}); fprintf(' %7g', r.values); fprintf('\n');
    for k = 1:5, fprintf('%-8s', nm{k}); fprintf(' %7.2f', r.essr(:, J(k))); fprintf('\n'); end
    for k = 2:5
        fprintf('g/%-6s', nm{k}); fprintf(' %6.1f%%', 100*(r.essr(:, J(1))./r.essr(:, J(k)) - 1)); fprintf('\n');
    end
    for pr = {[1 4], [3 2], [3 1]}
        a = pr{1}(1);  b = pr{1}(2);
        d = squeeze(r.essrDrops(:, J(a), :) - r.essrDrops(:, J(b), :));
        if isvector(d), d = d(:).'; end
        fprintf('%s-%s', nm{a}, nm{b}); fprintf(' %6.2f(%.2f)', [mean(d, 2).'; std(d, 0, 2).'/sqrt(size(d, 2))]); fprintf('\n');
    end
    if isfield(r, 'anfrac') && all(isfinite(r.anfrac(:, J(1))))
        fprintf('ANfrac  '); for k = 1:5, fprintf(' %s', nm{k}); fprintf(' %.3f', r.anfrac(end, J(k))); end; fprintf(' (last value)\n');
    end
end
f5 = ld('fig5_snr');  J = cellfun(@(k) find(strcmp(f5.schemes, k), 1), keys);
fprintf('\nfig5 AN fraction rows = SNR:\n'); disp(round(1000*f5.anfrac(:, J))/1000);
fprintf('fig5 anpred at 30 dB: '); fprintf(' %.3f', f5.anpred(end, J)); fprintf('\n');
fprintf('fig5 anpred - anfrac at 30 dB: '); fprintf(' %.4f', f5.anpred(end, J) - f5.anfrac(end, J)); fprintf('\n');
tm = ld('table_mechanisms');
fprintf('\nmechanisms (20 dB): scheme rho1 etaN xi1 psi Xi1 essr\n');
for k = 1:numel(tm.schemes)
    fprintf('%-9s %.3f %.3f %6.2f %6.2f %6.3f %6.2f\n', tm.schemes{k}, mean(tm.rho1(:, k)), mean(tm.etaN(:, k)), ...
            mean(tm.xi(:, k, 1)), mean(tm.psi(:, k)), mean(tm.Xi(:, k, 1)), mean(tm.essr(:, k)));
end
end
