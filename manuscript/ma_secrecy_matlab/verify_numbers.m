function verify_numbers()
%VERIFY_NUMBERS  Recomputes the numbers quoted in Section V of main.tex from the stored
%   results (results/*.mat, schemes matched by name) and prints each of them next to the
%   value stated in the text. No simulation is run (about 10 s).

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
R   = results_dir();
ld  = @(f) getfield(load(fullfile(R, [f '.mat'])), 'res');
col = @(res, key) find(strcmp(res.schemes, key), 1);
val = @(res, row, key) res.essr(row, col(res, key));
show = @(sec, what, x, txt) fprintf('%-5s %-62s %10.4f   text: %s\n', sec, what, x, txt);

% ---------------- Section V-A ----------------
prm = default_params();
T = upa_positions(prm.N, prm.upaRows, prm.upaCols, 0.5);      % compact FPA
rho = zeros(prm.numDrops, 1);
for dI = 1:prm.numDrops
    sc = gen_scenario(prm, prm.seed + dI);
    k0 = 2*pi/sc.lambda;
    rho(dI) = abs(exp(1j*k0*(T*sc.au(:, 1)))' * exp(1j*k0*(T*sc.ae))) / prm.N;
end
show('V-A', 'FPA normalized LoS correlation rho_1 (default offset 0.1 rad), min over drops', min(rho), 'exceeds 0.94');
g = ld('extra_grid_check');
show('V-A', 'ESSR change when the grid spacing is halved (%)', 100*g.relChange, '0.04%');
f5 = ld('fig5_snr');  i20 = find(f5.values == 20);  i30 = find(f5.values == 30);
x = squeeze(f5.essrDrops(i20, col(f5, 'MA_full'), :));
show('V-A', 'standard error of the proposed average ESSR at 20 dB (%)', 100*std(x)/sqrt(numel(x))/mean(x), '0.55%');
na = ld('extra_no_an');  i20n = find(na.values == 20);
D = [squeeze(f5.essrDrops(i20, cellfun(@(k) col(f5, k), [main_schemes(), {'MA_eq', 'FPA_eq'}]), :)); ...
     squeeze(na.essrDrops(i20n, cellfun(@(k) col(na, k), {'MA_noAN', 'FPA_noAN'}), :))];   % schemes of Figs. 5 and 6
seMax = 0;
for a = 1:size(D, 1)
    for b = a+1:size(D, 1)
        d = D(a, :) - D(b, :);
        seMax = max(seMax, std(d)/sqrt(numel(d)));
    end
end
show('V-A', sprintf('largest standard error of a paired ESSR difference at 20 dB, %d schemes of Figs. 5-6 (bps/Hz)', size(D, 1)), seMax, 'does not exceed 0.22');

% ---------------- Section V-B 1) (Fig. 3 columns: LU MC, LU CF, Eve MC, Eve CF, ESSR MC, ESSR CF) ----
a = ld('fig3_accuracy');  iP = find(a.Pvec == 20);
show('V-B1', 'max |Eve MC - closed form| versus the SNR (bps/Hz)', max(abs(a.vsP(:, 3) - a.vsP(:, 4))), '0.052');
show('V-B1', 'max |Eve MC - closed form| versus the Rician factor (bps/Hz)', max(abs(a.vsK(:, 3) - a.vsK(:, 4))), '0.013');
show('V-B1', 'approximate ESSR of the proposed design at 20 dB', a.vsP(iP, 6), '18.98');
show('V-B1', 'actual (Monte Carlo) ESSR of the proposed design at 20 dB', a.vsP(iP, 5), '20.75');
gLU = a.vsK(:, 1) - a.vsK(:, 2);                     % LU sum rate: Monte Carlo minus (eq:Rm), Fig. 3(b)
show('V-B1', 'LU sum-rate gap of (eq:Rm) increasing in kappa in Fig. 3(b) (1 = yes)', all(diff(gLU) > 0), 'grows with the Rician factor');
show('V-B1', sprintf('LU sum-rate gap of (eq:Rm) at kappa = %d dB in Fig. 3(b) (bps/Hz)', a.Kvec(end)), gLU(end), '1.99');
show('V-B1', 'limit M log2(N/(N-M)) of this gap (LoS-dominant, high SNR; Section III-B)', prm.M*log2(prm.N/(prm.N - prm.M)), '2.03');
withAN = main_schemes();                            % {proposed, rate-oriented MA, FPA with Eve-aware AN, FPA}
iso = {'MA_full', 'MA_rate', 'FPA_full'};            % schemes with isotropic AN
gap = zeros(1, numel(iso));
for k = 1:numel(iso)
    gap(k) = val(f5, i20, iso{k}) - f5.F(i20, col(f5, iso{k}));
end
show('V-B1', 'actual minus approximate ESSR at 20 dB, smallest over the schemes with isotropic AN', min(gap), '1.57');
show('V-B1', 'actual minus approximate ESSR at 20 dB, largest over the schemes with isotropic AN', max(gap), '1.76');
show('V-B1', 'actual minus approximate ESSR at 20 dB, FPA with Eve-aware AN', val(f5, i20, 'FPA_ean') - f5.F(i20, col(f5, 'FPA_ean')), '1.11');
tm = ld('table_mechanisms');  ke = find(strcmp(tm.schemes, 'FPA_ean'), 1);
show('V-B1', 'FPA with Eve-aware AN at 20 dB: sum of the wiretap rates by (eq:Re) (bps/Hz)', mean(tm.ReApprox(:, ke)), '2.18');
show('V-B1', 'FPA with Eve-aware AN at 20 dB: sum of the wiretap rates, Monte Carlo (bps/Hz)', mean(tm.ReMC(:, ke)), '2.63');
for kk = {'MA_full', 'MA_rate', 'FPA_full'}
    k = find(strcmp(tm.schemes, kk{1}), 1);
    show('V-B1', sprintf('%s at 20 dB: wiretap sum rate by (eq:Re) minus Monte Carlo (bps/Hz)', kk{1}), ...
         mean(tm.ReApprox(:, k)) - mean(tm.ReMC(:, k)), 'not quoted (isotropic AN)');
end
ec = ld('extra_ean_check');
for k = 1:2
    d = ec.oracle(:, k) - ec.alg1(:, k);
    show('V-B1', sprintf('%s: ESSR gain of the best AN power fraction (Monte Carlo search) (%%, SE %.3f%%)', ec.labels{k}, ...
         100*std(d)/sqrt(numel(d))/mean(ec.alg1(:, k))), 100*mean(d)/mean(ec.alg1(:, k)), 'Eve-aware AN: 0.09%');
end
jj = cellfun(@(k) col(f5, k), withAN);
for i = 1:numel(f5.values)
    [~, ia] = sort(f5.essr(i, jj), 'descend');  [~, ib] = sort(f5.F(i, jj), 'descend');
    if ~isequal(ia, ib)
        dif = find(ia ~= ib);
        show('V-B1', sprintf('%d dB: rankings differ for %s / %s; their actual ESSR difference (bps/Hz)', f5.values(i), ...
             withAN{ia(dif(1))}, withAN{ia(dif(end))}), abs(diff(f5.essr(i, jj(ia(dif([1 end])))))), 'differ by 0.01');
    else
        show('V-B1', sprintf('%d dB: approximate and actual rankings coincide (1 = yes)', f5.values(i)), 1, 'coincide');
    end
end

% ---------------- Section V-B 2) ----------------
c = ld('fig4_convergence');  itMax = 0;  mono = true;  frac3 = 1;
for i = 1:numel(c.Nlist)
    for j = 1:numel(c.Plist)
        h = squeeze(c.hist(i, j, :, :));
        mono = mono && all(all(diff(h, 1, 2) >= -1e-9));
        m = mean(h, 1);
        itMax = max(itMax, find(m >= m(1) + 0.99*(m(end) - m(1)), 1) - 1);
        frac3 = min(frac3, (m(4) - m(1))/(m(end) - m(1)));   % m(1): initial value
    end
end
show('V-B2', 'all trajectories monotone (1 = yes)', mono, 'increases monotonically');
show('V-B2', 'iterations for the average curves to reach 99% of their increase', itMax, 'converges within about 15');
show('V-B2', 'smallest fraction of the total increase reached after three iterations', frac3, 'more than 95%');
mm = ld('extra_mm_compare');  dF = mm.S1zheng.F - mm.S0.F;
show('V-B2', sprintf('surrogate of [6] minus Stage 2: average objective (%%, %d drops, paired SE %.3f%%)', numel(dF), ...
     100*std(dF)/sqrt(numel(dF))/mean(mm.S0.F)), 100*mean(dF)/mean(mm.S0.F), 'within 0.1%');
show('V-B2', 'surrogate of [6]: ratio of the numbers of MM iterations', mean(mm.S1zheng.mmIt)/mean(mm.S0.mmIt), '2.6 times');
show('V-B2', 'surrogate of [6]: median curvature / median accepted delta_n', median(mm.S1zheng.curvEff)/median(mm.S0.curv), 'about 12 times');
show('V-B2', 'surrogate of [6]: ratio of the run times', mean(mm.S1zheng.time)/mean(mm.S0.time), 'not quoted');

% ---------------- Section V-C (Figs. 5 and 6) ----------------
pr = val(f5, i20, 'MA_full');
show('V-C', 'gain over the rate-oriented MA at 20 dB (%)', 100*(pr/val(f5, i20, 'MA_rate') - 1), '14.8%');
show('V-C', 'gain over the FPA with Eve-aware AN at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_ean') - 1), '19.1%');
show('V-C', 'gain over the FPA at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_full') - 1), '31.1%');
gFPA = @(key) f5.essr(:, col(f5, key)) - f5.essr(:, col(f5, 'FPA_full'));
gMA = gFPA('MA_full');  gRate = gFPA('MA_rate');
show('V-C', 'gain over FPA at 20 dB: proposed', gMA(i20), 'reference');
show('V-C', 'gain over FPA at 20 dB: rate-oriented MA (ratio to the proposed)', gRate(i20)/gMA(i20), 'less than half');
show('V-C', 'FPA with Eve-aware AN over the FPA at 20 dB (%)', 100*(val(f5, i20, 'FPA_ean')/val(f5, i20, 'FPA_full') - 1), '10.1%');
for v = f5.values
    iv = f5.values == v;
    d = squeeze(f5.essrDrops(iv, col(f5, 'MA_rate'), :) - f5.essrDrops(iv, col(f5, 'FPA_ean'), :));
    show('V-C', sprintf('rate-oriented MA minus FPA with Eve-aware AN at %d dB (paired SE %.3f)', v, std(d)/sqrt(numel(d))), mean(d), ...
         'below both MA designs');
end
show('V-C', 'proposed above all benchmarks of Fig. 5 at every SNR (1 = yes)', ...
     all(f5.essr(:, jj(1)) > max(f5.essr(:, jj(2:end)), [], 2)), 'highest ESSR');
re = ld('extra_random_eve_M3');
show('V-C', 'random Eve (M = 3): gain over the rate-oriented MA at 20 dB (%)', ...
     100*(val(re, 1, 'MA_full')/val(re, 1, 'MA_rate') - 1), '10.3%');
show('V-C', 'random Eve (M = 3): gain over the FPA at 20 dB (%)', ...
     100*(val(re, 1, 'MA_full')/val(re, 1, 'FPA_full') - 1), 'not quoted');
ae = ld('extra_eve_aod_error');                      % designs with an erroneous AoD of Eve (20 dB)
iE0 = find(ae.values == 0);  iE5 = find(abs(ae.values - 0.05) < 1e-9);  iE10 = find(abs(ae.values - 0.1) < 1e-9);
show('V-C', 'AoD error 0: proposed ESSR minus Fig. 5 at 20 dB (bps/Hz)', ...
     val(ae, iE0, 'MA_full') - val(f5, i20, 'MA_full'), 'consistency check (0)');
show('V-C', 'AoD error 0.05 rad: ESSR loss of the proposed design (%)', ...
     100*(1 - val(ae, iE5, 'MA_full')/val(ae, iE0, 'MA_full')), '2.95%');
show('V-C', 'AoD error 0.05 rad: gain over the rate-oriented MA (%)', ...
     100*(val(ae, iE5, 'MA_full')/val(ae, iE5, 'MA_rate') - 1), '11.7%');
d = squeeze(ae.essrDrops(iE10, col(ae, 'MA_full'), :) - ae.essrDrops(iE10, col(ae, 'MA_rate'), :));
show('V-C', sprintf('AoD error 0.1 rad: gain over the rate-oriented MA (%%) (paired SE %.3f of %.3f bps/Hz)', ...
     std(d)/sqrt(numel(d)), mean(d)), 100*(val(ae, iE10, 'MA_full')/val(ae, iE10, 'MA_rate') - 1), '4.4%');
show('V-C', 'AN power fraction of the proposed design at 20 dB', f5.anfrac(i20, col(f5, 'MA_full')), '0.27');
show('V-C', 'AN power fraction of the FPA at 20 dB', f5.anfrac(i20, col(f5, 'FPA_full')), '0.47');
show('V-C', 'AN power fraction of the FPA with Eve-aware AN at 20 dB', f5.anfrac(i20, col(f5, 'FPA_ean')), '0.35');
an = f5.anfrac(:, jj);
lessAll = an(:, 1) < min(an(:, 2:end), [], 2);
show('V-C', 'proposed AN fraction below all benchmarks at every SNR >= 10 dB (1 = yes)', all(lessAll(f5.values >= 10)), 'for P/sigma^2 >= 10 dB');
show('V-C', 'proposed AN fraction below all benchmarks at 5 dB (1 = yes)', lessAll(f5.values == 5), 'not claimed below 10 dB');
eanLess = an(:, 3) < an(:, 4);
show('V-C', 'Eve-aware AN fraction below that of the FPA at every SNR >= 15 dB (1 = yes)', all(eanLess(f5.values >= 15)), 'for P/sigma^2 >= 15 dB');
show('V-C', 'Eve-aware AN fraction minus that of the FPA at 10 dB', an(f5.values == 10, 3) - an(f5.values == 10, 4), 'not claimed at 10 dB');
dPred = zeros(1, numel(withAN));                  % high-SNR limits of Fig. 5(b) (dotted lines)
for i = 1:numel(withAN)
    k = withAN{i};
    show('V-C', sprintf('%s: AN fraction at 30 dB', k), f5.anfrac(i30, col(f5, k)), 'Fig. 5(b), curves');
    show('V-C', sprintf('%s: high-SNR limit 1 - alpha* for the designs at 30 dB', k), f5.anpred(i30, col(f5, k)), 'Fig. 5(b), dotted lines (proposed, FPA); text: all four');
    dPred(i) = f5.anpred(i30, col(f5, k)) - f5.anfrac(i30, col(f5, k));
end
show('V-C', 'largest limit - AN fraction of Algorithm 1 at 30 dB over the four schemes', max(dPred), 'exceed by at most 0.013');
show('V-C', 'smallest limit - AN fraction of Algorithm 1 at 30 dB over the four schemes', min(dPred), 'all positive (exceed)');
show('V-C', 'alpha* (= 1 - prediction) of the proposed design at 30 dB', 1 - f5.anpred(i30, col(f5, 'MA_full')), '0.71');
show('V-C', 'alpha* (= 1 - prediction) of the FPA at 30 dB', 1 - f5.anpred(i30, col(f5, 'FPA_full')), '0.51');
lossMA = f5.essr(:, col(f5, 'MA_full')) - f5.essr(:, col(f5, 'MA_eq'));
lossFPA = f5.essr(:, col(f5, 'FPA_full')) - f5.essr(:, col(f5, 'FPA_eq'));
show('V-C', 'Fig. 6(a): equal-power loss of the MAs, smallest over the SNRs (bps/Hz)', min(lossMA), '1.79');
show('V-C', 'Fig. 6(a): equal-power loss of the MAs, largest over the SNRs (bps/Hz)', max(lossMA), '1.94');
show('V-C', 'Fig. 6(a): equal-power loss of the FPA at 0 dB (bps/Hz)', lossFPA(f5.values == 0), '1.83');
show('V-C', 'Fig. 6(a): equal-power loss of the FPA at 30 dB (bps/Hz)', lossFPA(f5.values == 30), '0.64');
show('V-C', 'Fig. 6(a): loss of the MAs larger than that of the FPA at every SNR >= 10 dB (1 = yes)', all(lossMA(f5.values >= 10) > lossFPA(f5.values >= 10)), 'loss of the MAs larger at high SNR');
show('V-C', 'Fig. 6(a): AN power fraction of the equal-power schemes ((N-M)/N)', f5.anfrac(i20, col(f5, 'MA_eq')), '0.625');
show('V-C', 'optimized AN power fraction of the proposed design at 0 dB', f5.anfrac(f5.values == 0, col(f5, 'MA_full')), 'close to zero');
dEq = f5.essr(:, col(f5, 'MA_eq')) - f5.essr(:, col(f5, 'FPA_full'));
show('V-C', 'Fig. 6(a): MA with equal power above the FPA at every SNR >= 10 dB (1 = yes)', all(dEq(f5.values >= 10) > 0), 'for P/sigma^2 >= 10 dB');
show('V-C', 'Fig. 6(a): MA with equal power minus FPA at 5 dB (bps/Hz)', dEq(f5.values == 5), 'below at 5 dB');
for v = [10 15]
    iv = find(f5.values == v);
    d = squeeze(f5.essrDrops(iv, col(f5, 'MA_eq'), :) - f5.essrDrops(iv, col(f5, 'MA_rate'), :));
    show('V-C', sprintf('MA with equal power minus rate-oriented MA at %d dB (paired SE %.3f)', v, std(d)/sqrt(numel(d))), mean(d), 'not quoted');
end

% ---------------- Section V-C: Fig. 6(b) without AN (extra_no_an.mat, same drops) ----------------
iN = arrayfun(@(v) find(f5.values == v), na.values);
ma  = f5.essr(iN, col(f5, 'MA_full'));  fp  = f5.essr(iN, col(f5, 'FPA_full'));
ma0 = na.essr(:, col(na, 'MA_noAN'));    fp0 = na.essr(:, col(na, 'FPA_noAN'));
lo5 = na.values <= 5;  hi5 = na.values >= 5;
show('V-C', 'Fig. 6(b): largest |with AN - without AN| for P/sigma^2 <= 5 dB, MAs and FPA (bps/Hz)', ...
     max(abs([ma(lo5) - ma0(lo5); fp(lo5) - fp0(lo5)])), 'nearly coincide');
show('V-C', 'Fig. 6(b): gain of the AN for the proposed design at 20 dB (%)', 100*(ma(na.values == 20)/ma0(na.values == 20) - 1), '58.9%');
show('V-C', 'Fig. 6(b): gain of the AN for the proposed design at 30 dB (%)', 100*(ma(na.values == 30)/ma0(na.values == 30) - 1), '121.1%');
g0 = 100*(ma0./fp0 - 1);
show('V-C', 'Fig. 6(b): MAs over FPA without AN, smallest for P/sigma^2 >= 5 dB (%)', min(g0(hi5)), '30.5%');
show('V-C', 'Fig. 6(b): MAs over FPA without AN, largest for P/sigma^2 >= 5 dB (%)', max(g0(hi5)), '31.2%');
show('V-C', 'Fig. 6(b): ESSR slope without AN, 25 -> 30 dB, proposed (bps/Hz per dB)', (ma0(end) - ma0(end-1))/5, 'saturate');

% ---------------- Section V-C: mechanisms of the designs (table_mechanisms.mat, same drops) ----------------
jt = cellfun(@(k) find(strcmp(tm.schemes, k), 1), withAN);
show('V-C', 'mechanisms: consistency, max |ESSR per drop - Fig. 5 at 20 dB| (bps/Hz)', ...
     max(max(abs(tm.essr(:, jt) - squeeze(f5.essrDrops(i20, jj, :)).'))), '0 (identical designs)');
for kk = {'FPA_full', 'MA_rate', 'MA_full', 'FPA_ean'}
    k = find(strcmp(tm.schemes, kk{1}), 1);
    show('V-C', sprintf('mechanisms %s: mean rho_1', kk{1}), mean(tm.rho1(:, k)), '0.98 / 0.83 / 0.52 / (FPA)');
    show('V-C', sprintf('mechanisms %s: mean xi_1', kk{1}), mean(tm.xi(:, k, 1)), '54.5 / 53.4 / 24.7 / 54.5');
    show('V-C', sprintf('mechanisms %s: mean psi (Eve-aware AN: (N-M)(kappa_e d + 1))', kk{1}), mean(tm.psi(:, k)), '13.3 / 25.6 / 58.3 / 46.4');
    show('V-C', sprintf('mechanisms %s: mean Xi_1', kk{1}), mean(tm.Xi(:, k, 1)), 'not quoted');
    show('V-C', sprintf('mechanisms %s: mean eta_m / upper bound (21) (%%)', kk{1}), 100*mean(tm.etaN(:, k)), 'not quoted');
end

% ---------------- Section V-D 1) (Fig. 7) ----------------
pdiff = @(r, row, x, y) squeeze(r.essrDrops(row, col(r, x), :) - r.essrDrops(row, col(r, y), :));
r7 = ld('fig7_region');  iA = @(v) find(abs(r7.values - v) < 1e-9);
show('V-D1', 'FPA with Eve-aware AN: max - min of the ESSR over A (bps/Hz)', ...
     max(r7.essr(:, col(r7, 'FPA_ean'))) - min(r7.essr(:, col(r7, 'FPA_ean'))), 'does not depend on A');
for v = r7.values
    d = pdiff(r7, iA(v), 'FPA_ean', 'MA_rate');
    show('V-D1', sprintf('Eve-aware AN minus rate-oriented MA, A = %.1f lambda (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), '> 0 for small regions');
end
d = pdiff(r7, iA(1.5), 'FPA_ean', 'MA_full');
show('V-D1', sprintf('Eve-aware AN minus proposed, A = 1.5 lambda (paired SE %.3f) (bps/Hz)', std(d)/sqrt(numel(d))), mean(d), 'slightly exceeds');
show('V-D1', 'Eve-aware AN over the proposed design, A = 1.5 lambda (%)', ...
     100*(val(r7, iA(1.5), 'FPA_ean')/val(r7, iA(1.5), 'MA_full') - 1), '0.9%');
show('V-D1', 'gain of the proposed design over the Eve-aware AN, A = 6 lambda (%)', ...
     100*(val(r7, iA(6), 'MA_full')/val(r7, iA(6), 'FPA_ean') - 1), '26.2%');
show('V-D1', 'gain of the proposed design over the FPA, A = 1.5 / 6 lambda (%)', ...
     100*(val(r7, 1, 'MA_full')/val(r7, 1, 'FPA_full') - 1), sprintf('grows (%.1f%% at 6)', 100*(val(r7, numel(r7.values), 'MA_full')/val(r7, numel(r7.values), 'FPA_full') - 1)));
n = ld('extra_num_antennas');  iN = @(v) find(n.values == v);
show('V-D1', 'ESSR: proposed, N = 4 minus FPA, N = 12', val(n, iN(4), 'MA_full') - val(n, iN(12), 'FPA_full'), '> 0');
show('V-D1', 'ESSR: proposed, N = 4 minus FPA with Eve-aware AN, N = 8', val(n, iN(4), 'MA_full') - val(n, iN(8), 'FPA_ean'), '> 0 (not quoted)');
d = squeeze(n.essrDrops(iN(8), col(n, 'MA_full'), :) - n.essrDrops(iN(16), col(n, 'MA_rate'), :));
show('V-D1', sprintf('ESSR: proposed, N = 8 minus rate-oriented MA, N = 16 (paired SE %.3f)', std(d)/sqrt(numel(d))), mean(d), 'slightly outperforms');
gF = 100*(n.essr(:, col(n, 'MA_full'))./n.essr(:, col(n, 'FPA_full')) - 1);
show('V-D1', 'gain over the FPA decreasing in N (1 = yes)', all(diff(gF) < 0), 'decreases with N');
show('V-D1', 'N = 4: |FPA with Eve-aware AN - FPA| (bps/Hz)', abs(val(n, iN(4), 'FPA_ean') - val(n, iN(4), 'FPA_full')), 'coincide (N - M = 1)');
gE = n.essr(:, col(n, 'FPA_ean')) - n.essr(:, col(n, 'FPA_full'));
show('V-D1', 'gain of the Eve-aware AN over the FPA increasing in N (1 = yes)', all(diff(gE) > 0), 'grows with N');
for v = n.values
    d = pdiff(n, iN(v), 'FPA_ean', 'MA_rate');
    show('V-D1', sprintf('Eve-aware AN minus rate-oriented MA, N = %d (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), '> 0 for N >= 10');
end
gE = 100*(n.essr(:, col(n, 'MA_full'))./n.essr(:, col(n, 'FPA_ean')) - 1);
show('V-D1', 'gain of the proposed design over the Eve-aware AN, N = 4 (%)', gE(iN(4)), '70.9%');
show('V-D1', 'gain of the proposed design over the Eve-aware AN, N = 16 (%)', gE(iN(16)), '1.5%');
show('V-D1', 'gain over the Eve-aware AN decreasing in N (1 = yes)', all(diff(gE) < 0), 'decreases');
d = pdiff(n, iN(16), 'MA_full', 'FPA_ean');
show('V-D1', sprintf('proposed minus Eve-aware AN, N = 16 (paired SE %.3f) (bps/Hz)', std(d)/sqrt(numel(d))), mean(d), 'not quoted');

% ---------------- Section V-D 2) (Fig. 8(a): number of LUs, extra_num_users.mat) ----------------
u = ld('extra_num_users');  iM = @(v) find(u.values == v);
uv = @(key) u.essr(:, col(u, key));
show('V-D2', 'Fig. 8(a): M = 1, rate-oriented MA minus FPA (bps/Hz)', u.essr(iM(1), col(u, 'MA_rate')) - u.essr(iM(1), col(u, 'FPA_full')), 'same ESSR');
show('V-D2', 'Fig. 8(a): M = 1, gain of the proposed design over the FPA (%)', 100*(u.essr(iM(1), col(u, 'MA_full'))/u.essr(iM(1), col(u, 'FPA_full')) - 1), '77.2%');
show('V-D2', 'Fig. 8(a): M = 1, AN power fraction of the FPA (%)', 100*u.anfrac(iM(1), col(u, 'FPA_full')), '84%');
show('V-D2', 'Fig. 8(a): M = 1, AN power fraction of the proposed design (%)', 100*u.anfrac(iM(1), col(u, 'MA_full')), '50%');
gEF = 100*(uv('FPA_ean')./uv('FPA_full') - 1);
show('V-D2', 'Fig. 8(a): M = 1, Eve-aware AN over the FPA (%)', gEF(iM(1)), '35.6%');
show('V-D2', 'Fig. 8(a): M = 6, Eve-aware AN over the FPA (%)', gEF(iM(6)), '2.6%');
show('V-D2', 'Fig. 8(a): Eve-aware AN over the FPA decreasing in M (1 = yes)', all(diff(gEF) < 0), 'vanishes as M grows');
gPE = 100*(uv('MA_full')./uv('FPA_ean') - 1);
show('V-D2', 'Fig. 8(a): M = 1, gain of the proposed design over the Eve-aware AN (%)', gPE(iM(1)), '30.7%');
show('V-D2', 'Fig. 8(a): M = 6, gain of the proposed design over the Eve-aware AN (%)', gPE(iM(6)), '60.1%');
for v = u.values
    d = squeeze(u.essrDrops(iM(v), col(u, 'FPA_ean'), :) - u.essrDrops(iM(v), col(u, 'MA_rate'), :));
    show('V-D2', sprintf('Fig. 8(a): Eve-aware AN minus rate-oriented MA, M = %d (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), '> 0 for M = 1 (not quoted)');
end
gr = uv('MA_full') - uv('MA_rate');
show('V-D2', 'Fig. 8(a): gain over the rate-oriented MA, smallest over M (bps/Hz)', min(gr), '2.47');
show('V-D2', 'Fig. 8(a): gain over the rate-oriented MA, largest over M (bps/Hz)', max(gr), '3.39');
gF = 100*(uv('MA_full')./uv('FPA_full') - 1);
show('V-D2', 'Fig. 8(a): gains over FPA increasing for M >= 3 (1 = yes)', all(diff(gF(u.values >= 3)) > 0), 'grows for M >= 3');
show('V-D2', 'Fig. 8(a): gain over the FPA at M = 6 (%)', gF(end), '64.4%');
for kk = {'FPA_full', 'FPA_ean'}
    d56 = squeeze(u.essrDrops(iM(6), col(u, kk{1}), :));  d55 = squeeze(u.essrDrops(iM(5), col(u, kk{1}), :));
    show('V-D2', sprintf('Fig. 8(a): %s, ESSR(M = 6) - ESSR(M = 5) (SE %.3f indep., %.3f paired)', kk{1}, ...
         sqrt(var(d56)/numel(d56) + var(d55)/numel(d55)), std(d56 - d55)/sqrt(numel(d56))), mean(d56) - mean(d55), 'saturate for M >= 5');
end

% ---------------- Section V-D 3) (Fig. 8(b): kappa_e sweep; common kappa in the text) ----------------
ka = ld('fig8_rician_a');  kb = ld('fig8_rician_b');
kv = @(r, key) r.essr(:, col(r, key));
jb = cellfun(@(k) col(kb, k), withAN);
lo = ka.values == min(ka.values);  hi = ka.values == max(ka.values);
ji = cellfun(@(k) col(ka, k), iso);
show('V-D3', 'common kappa (text): largest ESSR difference between the MA designs and the FPA at kappa = -10 dB (bps/Hz)', max(ka.essr(lo, ji)) - min(ka.essr(lo, ji)), 'less than 0.04');
show('V-D3', 'common kappa (text): Eve-aware AN over the FPA at kappa = -10 dB (%)', 100*(ka.essr(lo, col(ka, 'FPA_ean'))/ka.essr(lo, col(ka, 'FPA_full')) - 1), '-2.8%');
show('V-D3', 'common kappa (text): proposed increasing in kappa (1 = yes)', all(diff(kv(ka, 'MA_full')) > 0), 'increases');
show('V-D3', 'common kappa (text): FPA decreasing in kappa (1 = yes)', all(diff(kv(ka, 'FPA_full')) < 0), 'decreases');
show('V-D3', 'common kappa (text): gain over the rate-oriented MA at kappa = 20 dB (%)', 100*(ka.essr(hi, col(ka, 'MA_full'))/ka.essr(hi, col(ka, 'MA_rate')) - 1), '19.3%');
show('V-D3', 'common kappa (text): gain over the Eve-aware AN at kappa = 20 dB (%)', 100*(ka.essr(hi, col(ka, 'MA_full'))/ka.essr(hi, col(ka, 'FPA_ean')) - 1), '31.5%');
show('V-D3', 'common kappa (text): gain over the FPA at kappa = 20 dB (%)', 100*(ka.essr(hi, col(ka, 'MA_full'))/ka.essr(hi, col(ka, 'FPA_full')) - 1), '49.4%');
lo = kb.values == min(kb.values);  hi = kb.values == max(kb.values);
show('V-D3', 'Fig. 8(b): gain over the rate-oriented MA at kappa_e = -10 dB (%)', 100*(kb.essr(lo, jb(1))/kb.essr(lo, jb(2)) - 1), '1.0%');
show('V-D3', 'Fig. 8(b): gain over the rate-oriented MA at kappa_e = 20 dB (%)', 100*(kb.essr(hi, jb(1))/kb.essr(hi, jb(2)) - 1), '17.0%');
show('V-D3', 'Fig. 8(b): gain over the FPA at kappa_e = 20 dB (%)', 100*(kb.essr(hi, jb(1))/kb.essr(hi, jb(4)) - 1), 'not quoted');
show('V-D3', 'Fig. 8(b): proposed increasing in kappa_e (1 = yes)', all(diff(kb.essr(:, jb(1))) > 0), 'increases');
show('V-D3', 'Fig. 8(b): rate-oriented MA and FPA decreasing in kappa_e (1 = yes)', all(all(diff(kb.essr(:, jb([2 4])), 1, 1) < 0)), 'decrease');
for v = kb.values
    iv = kb.values == v;
    d = squeeze(kb.essrDrops(iv, jb(3), :) - kb.essrDrops(iv, jb(4), :));
    show('V-D3', sprintf('Fig. 8(b): Eve-aware AN minus FPA, kappa_e = %d dB (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), '< 0 for kappa_e <= 0 dB');
end
show('V-D3', 'Fig. 8(b): Eve-aware AN over the FPA at kappa_e = -10 dB (%)', 100*(kb.essr(lo, jb(3))/kb.essr(lo, jb(4)) - 1), '-5.2%');
gE = 100*(kb.essr(:, jb(1))./kb.essr(:, jb(3)) - 1);
show('V-D3', 'Fig. 8(b): gain of the proposed design over the Eve-aware AN, smallest over kappa_e (%)', min(gE), '16.6%');
show('V-D3', 'Fig. 8(b): gain of the proposed design over the Eve-aware AN, largest over kappa_e (%)', max(gE), '20.4%');
show('V-D3', 'Fig. 8(b): ESSR at kappa_e = 10 dB equals Fig. 5 at 20 dB (max |difference|, bps/Hz)', ...
     max(abs(kb.essr(kb.values == 10, jb) - f5.essr(i20, jj))), 'consistency check');
end
