function verify_numbers()
%VERIFY_NUMBERS  Recomputes the numbers quoted in Section V of main.tex from the stored
%   results (results/*.mat, schemes matched by name) and prints each of them next to the
%   value stated in the text. No simulation is run (about 10 s).

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
R   = fullfile(here, 'results');
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
show('V-A', 'FPA normalized LoS correlation rho_1 at Delta = 0.1, min over drops', min(rho), 'exceeds 0.94');
g = ld('extra_grid_check');
show('V-A', 'ESSR change when the grid spacing is halved (%)', 100*g.relChange, '0.01%');
f5 = ld('fig5_snr');  i20 = find(f5.values == 20);
x = squeeze(f5.essrDrops(i20, col(f5, 'MA_full'), :));
show('V-A', 'standard error of the proposed average ESSR at 20 dB (%)', 100*std(x)/sqrt(numel(x))/mean(x), '0.55%');
k5 = main_schemes();  seMax = 0;
for a = 1:numel(k5)
    for b = a+1:numel(k5)
        d = squeeze(f5.essrDrops(i20, col(f5, k5{a}), :) - f5.essrDrops(i20, col(f5, k5{b}), :));
        seMax = max(seMax, std(d)/sqrt(numel(d)));
    end
end
show('V-A', 'largest standard error of a paired ESSR difference at 20 dB (bps/Hz)', seMax, 'does not exceed 0.22');

w = load(fullfile(R, 'extra_as_swap_check.mat'));  w = w.res;
opt = (1 - w.fSwap./w.fExh) <= 1e-9;          % swap search attains the exhaustive optimum of the metric
show('V-A', 'AS swap search attains the maximum metric, worst N <= 10 (% of drops)', 100*min(mean(opt, 2)), 'at least 92% (footnote)');
show('V-A', 'AS swap search: largest |difference| of the average ESSR, N <= 10 (%)', ...
     100*max(abs(1 - mean(w.essrSwap, 2)./mean(w.essrExh, 2))), 'less than 0.03% (footnote)');

% ---------------- Section V-B (columns: LU MC, LU CF, Eve MC, Eve CF, ESSR MC, ESSR CF) ----
a = ld('fig3_accuracy');  iP = find(a.Pvec == 20);
show('V-B', 'max |Eve MC - closed form| versus the SNR (bps/Hz)', max(abs(a.vsP(:, 3) - a.vsP(:, 4))), '0.052');
show('V-B', 'max |Eve MC - closed form| versus the Rician factor (bps/Hz)', max(abs(a.vsK(:, 3) - a.vsK(:, 4))), '0.013');
show('V-B', 'approximate ESSR of the proposed design at 20 dB', a.vsP(iP, 6), '18.98');
show('V-B', 'actual (Monte Carlo) ESSR of the proposed design at 20 dB', a.vsP(iP, 5), '20.75');
withAN = {'MA_full', 'MA_rate', 'AS', 'FPA_full', 'SPA_full'};
gap = zeros(1, numel(withAN));
for k = 1:numel(withAN)
    gap(k) = val(f5, i20, withAN{k}) - f5.F(i20, col(f5, withAN{k}));
end
show('V-B', 'actual minus approximate ESSR at 20 dB, smallest over schemes', min(gap), '1.52');
show('V-B', 'actual minus approximate ESSR at 20 dB, largest over schemes', max(gap), '1.76');
show('V-B', 'spread of this gap over the schemes at 20 dB (bps/Hz)', max(gap) - min(gap), 'less than 0.25');
same = false(numel(f5.values), 1);  first = same;
jj = cellfun(@(k) col(f5, k), withAN);              % withAN{1} is the proposed design
for i = 1:numel(f5.values)
    [~, ia] = sort(f5.essr(i, jj), 'descend');  [~, ib] = sort(f5.F(i, jj), 'descend');
    same(i) = isequal(ia, ib);  first(i) = ia(1) == 1 && ib(1) == 1;
end
show('V-B', 'approximate and actual rankings equal at every SNR >= 10 dB (1 = yes)', all(same(f5.values >= 10)), 'preserved for >= 10 dB');
show('V-B', 'rankings differ at some SNR below 10 dB (1 = yes)', any(~same(f5.values < 10)), 'differ below 10 dB');
show('V-B', 'proposed design ranked first by both at every SNR (1 = yes)', all(first), 'only the benchmarks change order');

% ---------------- Section V-C ----------------
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
show('V-C', 'all trajectories monotone (1 = yes)', mono, 'increases monotonically');
show('V-C', 'iterations for the average curves to reach 99% of their increase', itMax, 'converges within about 15');
show('V-C', 'smallest fraction of the total increase reached after three iterations', frac3, 'more than 95%');

% ---------------- Section V-D ----------------
pr = val(f5, i20, 'MA_full');
show('V-D', 'gain over the rate-oriented MA at 20 dB (%)', 100*(pr/val(f5, i20, 'MA_rate') - 1), '14.8%');
show('V-D', 'gain over the FPA at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_full') - 1), '31.2%');
show('V-D', 'AN power fraction of the proposed design at 20 dB', f5.anfrac(i20, col(f5, 'MA_full')), '0.27');
show('V-D', 'AN power fraction of the FPA at 20 dB', f5.anfrac(i20, col(f5, 'FPA_full')), '0.47');
an = f5.anfrac(:, cellfun(@(k) col(f5, k), withAN));
lessAll = an(:, 1) < min(an(:, 2:end), [], 2);
show('V-D', 'proposed AN fraction below all benchmarks at every SNR >= 10 dB (1 = yes)', all(lessAll(f5.values >= 10)), 'for P/sigma^2 >= 10 dB');
show('V-D', 'proposed AN fraction below all benchmarks at 5 dB (1 = yes)', lessAll(f5.values == 5), 'not claimed below 10 dB');
for k = {'MA_rate', 'AS', 'SPA_full'}
    show('V-D', sprintf('AN power fraction of %s at 20 dB', k{1}), f5.anfrac(i20, col(f5, k{1})), 'comparable to the FPA');
end
gFPA = @(key) f5.essr(:, col(f5, key)) - f5.essr(:, col(f5, 'FPA_full'));
gMA = gFPA('MA_full');  gRate = gFPA('MA_rate');  gAS = gFPA('AS');  gSPA = gFPA('SPA_full');
show('V-D', 'gain over FPA: AS smaller than rate-oriented MA at all SNRs (1 = yes)', all(gAS < gRate), 'even smaller gain');
show('V-D', 'gain over FPA at 20 dB: proposed', gMA(i20), 'reference');
show('V-D', 'gain over FPA at 20 dB: rate-oriented MA', gRate(i20), 'less than half');
show('V-D', 'gain over FPA at 20 dB: AS', gAS(i20), 'even smaller');
show('V-D', 'gain over FPA at 20 dB: sparse FPA', gSPA(i20), 'less than half');

% ---------------- Section V-E (Fig. 6(a)) ----------------
r6 = ld('fig6_region');
for i = 1:numel(r6.values)
    show('V-E', sprintf('ESSR: proposed minus AS, A = %.1f lambda', r6.values(i)), ...
         val(r6, i, 'MA_full') - val(r6, i, 'AS'), 'comparable only for the smallest A');
end

% ---------------- Section V-E ----------------
n = ld('extra_num_antennas');  iN = @(v) find(n.values == v);
show('V-E', 'ESSR: proposed, N = 4 minus FPA, N = 12', val(n, iN(4), 'MA_full') - val(n, iN(12), 'FPA_full'), '> 0');
d = squeeze(n.essrDrops(iN(8), col(n, 'MA_full'), :) - n.essrDrops(iN(16), col(n, 'MA_rate'), :));
show('V-E', sprintf('ESSR: proposed, N = 8 minus rate-oriented MA, N = 16 (paired SE %.3f)', std(d)/sqrt(numel(d))), mean(d), 'slightly outperforms');
for v = n.values
    d = squeeze(n.essrDrops(iN(v), col(n, 'SPA_full'), :) - n.essrDrops(iN(v), col(n, 'MA_rate'), :));
    show('V-E', sprintf('ESSR: sparse FPA minus rate-oriented MA, N = %d (paired SE %.3f)', v, std(d)/sqrt(numel(d))), ...
         mean(d), 'approaches; slightly exceeds for N = 16');
end
for v = n.values
    show('V-E', sprintf('gain of the proposed design over FPA / AS, N = %d', v), ...
         val(n, iN(v), 'MA_full') - val(n, iN(v), 'FPA_full'), sprintf('%.4f (AS)', val(n, iN(v), 'MA_full') - val(n, iN(v), 'AS')));
end

% ---------------- Section V-F (Fig. 7: M = 1; M = 3 in the text) ----------------
u = ld('extra_single_user');  iD = @(r, v) find(abs(r.values - v) < 1e-9);
show('V-F', 'M = 1: max |rate-oriented MA - FPA| over Delta and drops', ...
     max(abs(reshape(u.essrDrops(:, col(u, 'MA_rate'), :) - u.essrDrops(:, col(u, 'FPA_full'), :), [], 1))), 'coincides (machine precision)');
gU = 100*(u.essr(:, col(u, 'MA_full'))./u.essr(:, col(u, 'FPA_full')) - 1);
for v = [0.02 0.2 0.5]
    show('V-F', sprintf('M = 1: gain of the proposed design over the FPA, Delta = %.2f (%%)', v), gU(iD(u, v)), '9% / 79% / 33%');
end
show('V-F', 'M = 1: largest gain attained at Delta (rad)', u.values(find(gU == max(gU), 1)), '0.2 (first increases, then decreases)');
show('V-F', 'M = 1: proposed above all benchmarks at every Delta (1 = yes)', ...
     all(u.essr(:, col(u, 'MA_full')) > max(u.essr(:, [col(u, 'MA_rate') col(u, 'AS') col(u, 'SPA_full') col(u, 'FPA_full')]), [], 2)), 'further gain');
sp = u.essr(:, col(u, 'SPA_full'));
for v = [0.2 0.3 0.4]
    show('V-F', sprintf('M = 1: ergodic secrecy rate of the sparse FPA, Delta = %.1f', v), sp(iD(u, v)), 'not monotonic (dip at 0.3)');
end
pr1 = default_params();  pr1.M = 1;
for v = [0.2 0.25 0.3 0.4]
    pr1.Delta = v;  r1 = zeros(pr1.numDrops, 1);
    for dI = 1:pr1.numDrops
        sc = gen_scenario(pr1, pr1.seed + dI);  k0 = 2*pi/sc.lambda;
        T = upa_positions(pr1.N, pr1.upaRows, pr1.upaCols, sc.A/(pr1.upaCols - 1), sc.A/(pr1.upaRows - 1));
        r1(dI) = abs(exp(1j*k0*(T*sc.au(:, 1)))' * exp(1j*k0*(T*sc.ae))) / pr1.N;
    end
    show('V-F', sprintf('M = 1: sparse FPA, average rho_1 at Delta = %.2f', v), mean(r1), 'grating lobe: rho_1 rises around 0.3');
end
a3 = ld('extra_angle_offset');
gA = 100*(a3.essr(:, col(a3, 'MA_full'))./a3.essr(:, col(a3, 'MA_rate')) - 1);
for v = [0.02 0.1 0.5]
    show('V-F', sprintf('M = 3: gain over the rate-oriented MA, Delta = %.2f (%%)', v), gA(iD(a3, v)), '2.4% / 14.8% / 10.7%');
end

% ---------------- Section V-G (Fig. 8 at 10 dB; 0 and 20 dB in the text) ----------------
s10 = ld('extra_pa_spread_10dB');
g10 = 100*(s10.essr(:, col(s10, 'MA_full'))./s10.essr(:, col(s10, 'MA_EPA')) - 1);
show('V-G', 'gain of the proposed PA over EP, optimized alpha, 10 dB, largest for S <= 10 dB (%)', max(g10(s10.values <= 10)), 'close');
show('V-G', 'gain of the proposed PA over EP, optimized alpha, 10 dB, S = 20 dB (%)', g10(s10.values == 20), '14%');
show('V-G', 'EP with alpha = 0.5 worst for all S at 10 dB (1 = yes)', ...
     all(s10.essr(:, col(s10, 'MA_fix')) < min(s10.essr(:, col(s10, 'MA_full')), s10.essr(:, col(s10, 'MA_EPA')))), 'performs worst');
show('V-G', 'ESSR decreasing in S for all PA schemes at 10 dB (1 = yes)', all(all(diff(s10.essr(:, [col(s10, 'MA_full') col(s10, 'MA_EPA') col(s10, 'MA_fix')]), 1, 1) < 0)), 'decrease with S');
p = ld('fig7_pa_hetero');
for v = [0 10 20]
    ii = find(p.values == v);
    show('V-G', sprintf('gain of the proposed PA over EP, optimized alpha, %d dB, S = 20 dB (%%)', v), ...
         100*(val(p, ii, 'MA_full')/val(p, ii, 'MA_EPA') - 1), '40% / 14% / below 1%');
end
end
