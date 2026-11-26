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
seMax = 0;
for a = 1:numel(f5.schemes)
    for b = a+1:numel(f5.schemes)
        d = squeeze(f5.essrDrops(i20, a, :) - f5.essrDrops(i20, b, :));
        seMax = max(seMax, std(d)/sqrt(numel(d)));
    end
end
show('V-A', 'largest standard error of a paired ESSR difference at 20 dB, all seven schemes (bps/Hz)', seMax, 'does not exceed 0.22');
w = load(fullfile(R, 'extra_as_swap_check.mat'));  w = w.res;
opt = (1 - w.fSwap./w.fExh) <= 1e-9;          % swap search attains the exhaustive optimum of the metric
show('V-A', 'AS swap search attains the maximum metric, worst N <= 10 (% of drops)', 100*min(mean(opt, 2)), 'at least 92% (footnote)');
show('V-A', 'AS swap search: largest |difference| of the average ESSR, N <= 10 (%)', ...
     100*max(abs(1 - mean(w.essrSwap, 2)./mean(w.essrExh, 2))), 'less than 0.03% (footnote)');

% ---------------- Section V-B 1) (Fig. 3 columns: LU MC, LU CF, Eve MC, Eve CF, ESSR MC, ESSR CF) ----
a = ld('fig3_accuracy');  iP = find(a.Pvec == 20);
show('V-B1', 'max |Eve MC - closed form| versus the SNR (bps/Hz)', max(abs(a.vsP(:, 3) - a.vsP(:, 4))), '0.052');
show('V-B1', 'max |Eve MC - closed form| versus the Rician factor (bps/Hz)', max(abs(a.vsK(:, 3) - a.vsK(:, 4))), '0.013');
show('V-B1', 'approximate ESSR of the proposed design at 20 dB', a.vsP(iP, 6), '18.98');
show('V-B1', 'actual (Monte Carlo) ESSR of the proposed design at 20 dB', a.vsP(iP, 5), '20.75');
withAN = main_schemes();                            % withAN{1} is the proposed design
gap = zeros(1, numel(withAN));
for k = 1:numel(withAN)
    gap(k) = val(f5, i20, withAN{k}) - f5.F(i20, col(f5, withAN{k}));
end
show('V-B1', 'actual minus approximate ESSR at 20 dB, smallest over the schemes of Fig. 5', min(gap), '1.52');
show('V-B1', 'actual minus approximate ESSR at 20 dB, largest over the schemes of Fig. 5', max(gap), '1.76');
show('V-B1', 'spread of this gap over the schemes at 20 dB (bps/Hz)', max(gap) - min(gap), 'less than 0.25');
same = false(numel(f5.values), 1);  first = same;
jj = cellfun(@(k) col(f5, k), withAN);
for i = 1:numel(f5.values)
    [~, ia] = sort(f5.essr(i, jj), 'descend');  [~, ib] = sort(f5.F(i, jj), 'descend');
    same(i) = isequal(ia, ib);  first(i) = ia(1) == 1 && ib(1) == 1;
end
show('V-B1', 'approximate and actual rankings equal at every SNR >= 10 dB (1 = yes)', all(same(f5.values >= 10)), 'preserved for >= 10 dB');
show('V-B1', 'rankings differ at some SNR below 10 dB (1 = yes)', any(~same(f5.values < 10)), 'differ below 10 dB');
show('V-B1', 'proposed design ranked first by both at every SNR (1 = yes)', all(first), 'only the benchmarks change order');

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
show('V-C', 'gain over the FPA at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_full') - 1), '31.1%');
gFPA = @(key) f5.essr(:, col(f5, key)) - f5.essr(:, col(f5, 'FPA_full'));
gMA = gFPA('MA_full');  gRate = gFPA('MA_rate');  gAS = gFPA('AS');  gSPA = gFPA('SPA_full');
show('V-C', 'gain over FPA: AS smaller than rate-oriented MA at all SNRs (1 = yes)', all(gAS < gRate), 'even smaller gain');
show('V-C', 'gain over FPA at 20 dB: proposed', gMA(i20), 'reference');
show('V-C', 'gain over FPA at 20 dB: rate-oriented MA (ratio to the proposed)', gRate(i20)/gMA(i20), 'less than half (less than half)');
show('V-C', 'gain over FPA at 20 dB: AS (ratio to the proposed)', gAS(i20)/gMA(i20), 'even smaller');
show('V-C', 'gain over FPA at 20 dB: sparse FPA (ratio to the proposed)', gSPA(i20)/gMA(i20), 'less than half (less than half)');
show('V-C', 'proposed above all benchmarks of Fig. 5 at every SNR (1 = yes)', ...
     all(f5.essr(:, col(f5, 'MA_full')) > max(f5.essr(:, jj(2:end)), [], 2)), 'highest ESSR');
re = ld('extra_random_eve_M3');
show('V-C', 'random Eve (M = 3): gain over the rate-oriented MA at 20 dB (%)', ...
     100*(val(re, 1, 'MA_full')/val(re, 1, 'MA_rate') - 1), '10.3%');
show('V-C', 'random Eve (M = 3): gain over the FPA at 20 dB (%)', ...
     100*(val(re, 1, 'MA_full')/val(re, 1, 'FPA_full') - 1), 'not quoted');
show('V-C', 'AN power fraction of the proposed design at 20 dB', f5.anfrac(i20, col(f5, 'MA_full')), '0.27');
show('V-C', 'AN power fraction of the FPA at 20 dB', f5.anfrac(i20, col(f5, 'FPA_full')), '0.47');
an = f5.anfrac(:, jj);
lessAll = an(:, 1) < min(an(:, 2:end), [], 2);
show('V-C', 'proposed AN fraction below all benchmarks at every SNR >= 10 dB (1 = yes)', all(lessAll(f5.values >= 10)), 'for P/sigma^2 >= 10 dB');
show('V-C', 'proposed AN fraction below all benchmarks at 5 dB (1 = yes)', lessAll(f5.values == 5), 'not claimed below 10 dB');
for k = {'MA_rate', 'AS', 'SPA_full'}
    show('V-C', sprintf('AN power fraction of %s at 20 dB', k{1}), f5.anfrac(i20, col(f5, k{1})), 'comparable to the FPA');
end
dPred = zeros(1, numel(withAN));                  % x markers of Fig. 5(b)
for i = 1:numel(withAN)
    k = withAN{i};
    show('V-C', sprintf('%s: AN fraction at 30 dB', k), f5.anfrac(i30, col(f5, k)), 'Fig. 5(b), markers');
    show('V-C', sprintf('%s: high-SNR prediction 1 - alpha* for the designs at 30 dB', k), f5.anpred(i30, col(f5, k)), 'Fig. 5(b), x');
    dPred(i) = f5.anpred(i30, col(f5, k)) - f5.anfrac(i30, col(f5, k));
end
show('V-C', 'largest prediction - AN fraction of Algorithm 1 at 30 dB over the five schemes', max(dPred), 'exceed by at most 0.011');
show('V-C', 'smallest prediction - AN fraction of Algorithm 1 at 30 dB over the five schemes', min(dPred), 'all positive (exceed)');
show('V-C', 'alpha* (= 1 - prediction) of the proposed design at 30 dB', 1 - f5.anpred(i30, col(f5, 'MA_full')), '0.71');
show('V-C', 'alpha* (= 1 - prediction) of the FPA at 30 dB', 1 - f5.anpred(i30, col(f5, 'FPA_full')), '0.51');
lossMA = f5.essr(:, col(f5, 'MA_full')) - f5.essr(:, col(f5, 'MA_eq'));
lossFPA = f5.essr(:, col(f5, 'FPA_full')) - f5.essr(:, col(f5, 'FPA_eq'));
show('V-C', 'Fig. 6: equal-power loss of the MAs, smallest over the SNRs (bps/Hz)', min(lossMA), '1.79');
show('V-C', 'Fig. 6: equal-power loss of the MAs, largest over the SNRs (bps/Hz)', max(lossMA), '1.94');
show('V-C', 'Fig. 6: equal-power loss of the FPA at 0 dB (bps/Hz)', lossFPA(f5.values == 0), '1.83');
show('V-C', 'Fig. 6: equal-power loss of the FPA at 30 dB (bps/Hz)', lossFPA(f5.values == 30), '0.64');
show('V-C', 'Fig. 6: loss of the MAs larger than that of the FPA at every SNR >= 10 dB (1 = yes)', all(lossMA(f5.values >= 10) > lossFPA(f5.values >= 10)), 'loss of the MAs larger at high SNR');
show('V-C', 'Fig. 6: AN power fraction of the equal-power schemes ((N-M)/N)', f5.anfrac(i20, col(f5, 'MA_eq')), '0.625');
show('V-C', 'optimized AN power fraction of the proposed design at 0 dB', f5.anfrac(f5.values == 0, col(f5, 'MA_full')), 'close to zero');
dEq = f5.essr(:, col(f5, 'MA_eq')) - f5.essr(:, col(f5, 'FPA_full'));
show('V-C', 'Fig. 6: MA, equal power above the FPA at every SNR >= 10 dB (1 = yes)', all(dEq(f5.values >= 10) > 0), 'for P/sigma^2 >= 10 dB');
show('V-C', 'Fig. 6: MA, equal power minus FPA at 5 dB (bps/Hz)', dEq(f5.values == 5), 'below at 5 dB');
for v = [10 15]
    iv = find(f5.values == v);
    d = squeeze(f5.essrDrops(iv, col(f5, 'MA_eq'), :) - f5.essrDrops(iv, col(f5, 'MA_rate'), :));
    show('V-C', sprintf('MA, equal power minus rate-oriented MA at %d dB (paired SE %.3f)', v, std(d)/sqrt(numel(d))), mean(d), 'not quoted');
end

% ---------------- Section V-D 1) (Fig. 7) ----------------
r7 = ld('fig7_region');
for i = 1:numel(r7.values)
    show('V-D1', sprintf('ESSR: proposed minus AS, A = %.1f lambda', r7.values(i)), ...
         val(r7, i, 'MA_full') - val(r7, i, 'AS'), 'comparable only for the smallest A');
end
n = ld('extra_num_antennas');  iN = @(v) find(n.values == v);
show('V-D1', 'ESSR: proposed, N = 4 minus FPA, N = 12', val(n, iN(4), 'MA_full') - val(n, iN(12), 'FPA_full'), '> 0');
d = squeeze(n.essrDrops(iN(8), col(n, 'MA_full'), :) - n.essrDrops(iN(16), col(n, 'MA_rate'), :));
show('V-D1', sprintf('ESSR: proposed, N = 8 minus rate-oriented MA, N = 16 (paired SE %.3f)', std(d)/sqrt(numel(d))), mean(d), 'slightly outperforms');
for v = n.values
    d = squeeze(n.essrDrops(iN(v), col(n, 'SPA_full'), :) - n.essrDrops(iN(v), col(n, 'MA_rate'), :));
    show('V-D1', sprintf('ESSR: sparse FPA minus rate-oriented MA, N = %d (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), 'approaches; slightly exceeds for N = 16');
end
for v = n.values
    show('V-D1', sprintf('gain of the proposed design over FPA / AS, N = %d', v), ...
         val(n, iN(v), 'MA_full') - val(n, iN(v), 'FPA_full'), sprintf('%.4f (AS)', val(n, iN(v), 'MA_full') - val(n, iN(v), 'AS')));
end

% ---------------- Section V-D 2) (Fig. 8: kappa_e sweep; common kappa in the text) ----------------
ka = ld('fig8_rician_a');  kb = ld('fig8_rician_b');
ja = cellfun(@(k) col(ka, k), withAN);  jb = cellfun(@(k) col(kb, k), withAN);
lo = ka.values == min(ka.values);  hi = ka.values == max(ka.values);
show('V-D2', 'common kappa (text): largest ESSR difference between the schemes at kappa = -10 dB (bps/Hz)', max(ka.essr(lo, ja)) - min(ka.essr(lo, ja)), 'less than 0.04');
show('V-D2', 'common kappa (text): proposed increasing in kappa (1 = yes)', all(diff(ka.essr(:, ja(1))) > 0), 'increases');
show('V-D2', 'common kappa (text): FPA decreasing in kappa (1 = yes)', all(diff(ka.essr(:, ja(5))) < 0), 'decreases');
show('V-D2', 'common kappa (text): gain over the rate-oriented MA at kappa = 20 dB (%)', 100*(ka.essr(hi, ja(1))/ka.essr(hi, ja(2)) - 1), '19.3%');
show('V-D2', 'common kappa (text): gain over the FPA at kappa = 20 dB (%)', 100*(ka.essr(hi, ja(1))/ka.essr(hi, ja(5)) - 1), '49.4%');
lo = kb.values == min(kb.values);  hi = kb.values == max(kb.values);
show('V-D2', 'Fig. 8: gain over the rate-oriented MA at kappa_e = -10 dB (%)', 100*(kb.essr(lo, jb(1))/kb.essr(lo, jb(2)) - 1), '1.0%');
show('V-D2', 'Fig. 8: gain over the rate-oriented MA at kappa_e = 20 dB (%)', 100*(kb.essr(hi, jb(1))/kb.essr(hi, jb(2)) - 1), '17.0%');
show('V-D2', 'Fig. 8: gain over the FPA at kappa_e = 20 dB (%)', 100*(kb.essr(hi, jb(1))/kb.essr(hi, jb(5)) - 1), 'not quoted');
show('V-D2', 'Fig. 8: proposed increasing in kappa_e (1 = yes)', all(diff(kb.essr(:, jb(1))) > 0), 'increases');
show('V-D2', 'Fig. 8: every benchmark decreasing in kappa_e (1 = yes)', all(all(diff(kb.essr(:, jb(2:end)), 1, 1) < 0)), 'all the benchmarks decrease');
show('V-D2', 'Fig. 8: ESSR at kappa_e = 10 dB equals Fig. 5 at 20 dB (max |difference|, bps/Hz)', ...
     max(abs(kb.essr(kb.values == 10, jb) - f5.essr(i20, jj))), 'consistency check');
end
