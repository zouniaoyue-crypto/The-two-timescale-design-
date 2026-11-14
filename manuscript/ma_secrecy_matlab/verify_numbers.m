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

% ---------------- Section V-C ----------------
c = ld('fig4_convergence');  itMax = 0;  mono = true;
for i = 1:numel(c.Nlist)
    for j = 1:numel(c.Plist)
        h = squeeze(c.hist(i, j, :, :));
        mono = mono && all(all(diff(h, 1, 2) >= -1e-9));
        m = mean(h, 1);
        itMax = max(itMax, find(m >= m(1) + 0.99*(m(end) - m(1)), 1) - 1);
    end
end
show('V-C', 'all trajectories monotone (1 = yes)', mono, 'increases monotonically');
show('V-C', 'iterations for the average curves to reach 99% of their increase', itMax, 'converges within about 15');

% ---------------- Section V-D ----------------
pr = val(f5, i20, 'MA_full');
show('V-D', 'gain over the rate-oriented MA at 20 dB (%)', 100*(pr/val(f5, i20, 'MA_rate') - 1), '14.8%');
show('V-D', 'gain over the FPA at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_full') - 1), '31.2%');
show('V-D', 'AN power fraction of the proposed design at 20 dB', f5.anfrac(i20, col(f5, 'MA_full')), '0.27');
show('V-D', 'AN power fraction of the FPA at 20 dB', f5.anfrac(i20, col(f5, 'FPA_full')), '0.47');
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
show('V-E', 'ESSR: proposed, N = 8 minus rate-oriented MA, N = 16', val(n, iN(8), 'MA_full') - val(n, iN(16), 'MA_rate'), '> 0');
for v = n.values
    show('V-E', sprintf('ESSR: sparse FPA minus rate-oriented MA, N = %d', v), ...
         val(n, iN(v), 'SPA_full') - val(n, iN(v), 'MA_rate'), '> 0 iff N >= 14');
end
for v = n.values
    show('V-E', sprintf('gain of the proposed design over FPA / AS, N = %d', v), ...
         val(n, iN(v), 'MA_full') - val(n, iN(v), 'FPA_full'), sprintf('%.4f (AS)', val(n, iN(v), 'MA_full') - val(n, iN(v), 'AS')));
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
