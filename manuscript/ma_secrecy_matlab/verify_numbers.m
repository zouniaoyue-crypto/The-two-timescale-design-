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
show('V-A', 'FPA LoS correlation |h1^H g|/N at Delta = 0.1, min over drops', min(rho), 'exceeds 0.94');
g = ld('extra_grid_check');
show('V-A', 'ESSR change when the grid spacing is halved (%)', 100*g.relChange, '0.01%');
f5 = ld('fig5_snr');  i20 = find(f5.values == 20);
x = squeeze(f5.essrDrops(i20, col(f5, 'MA_full'), :));
show('V-A', 'standard error of the proposed average ESSR at 20 dB (%)', 100*std(x)/sqrt(numel(x))/mean(x), '0.55%');

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
show('V-C', 'iterations for the average curves to reach 99% of their increase', itMax, 'within 15');

% ---------------- Section V-D ----------------
pr = val(f5, i20, 'MA_full');
show('V-D', 'gain over the rate-oriented MA at 20 dB (%)', 100*(pr/val(f5, i20, 'MA_rate') - 1), '14.8%');
show('V-D', 'gain over the FPA at 20 dB (%)', 100*(pr/val(f5, i20, 'FPA_full') - 1), '31.2%');
show('V-D', 'AN power fraction of the proposed design at 20 dB', f5.anfrac(i20, col(f5, 'MA_full')), '0.27');
show('V-D', 'AN power fraction of the FPA at 20 dB', f5.anfrac(i20, col(f5, 'FPA_full')), '0.47');

% ---------------- Section V-E ----------------
n = ld('extra_num_antennas');  iN = @(v) find(n.values == v);
show('V-E', 'ESSR: proposed, N = 4 minus FPA, N = 12', val(n, iN(4), 'MA_full') - val(n, iN(12), 'FPA_full'), '> 0');
show('V-E', 'ESSR: proposed, N = 8 minus rate-oriented MA, N = 16', val(n, iN(8), 'MA_full') - val(n, iN(16), 'MA_rate'), '> 0');
for v = n.values
    show('V-E', sprintf('ESSR: sparse FPA minus rate-oriented MA, N = %d', v), ...
         val(n, iN(v), 'SPA_full') - val(n, iN(v), 'MA_rate'), '> 0 iff N >= 14');
end

% ---------------- Section V-G (spread S = 20 dB, no figure) ----------------
p = ld('fig7_pa_hetero');
for v = [0 10 20]
    ii = find(p.values == v);
    show('V-G', sprintf('gain of the proposed PA over EP, optimized alpha, %d dB (%%)', v), ...
         100*(val(p, ii, 'MA_full')/val(p, ii, 'MA_EPA') - 1), '40% / 14% / below 1%');
end

% ---------------- Section V-H ----------------
mx = 0;
for v = [10 20 30]
    ii = find(f5.values == v);
    for k = 1:numel(withAN)
        jj = col(f5, withAN{k});
        mx = max(mx, f5.essr_tin(ii, jj) - f5.essr(ii, jj));
    end
end
show('V-H', 'TIN Eve: largest ESSR increase of the schemes with AN', mx, 'at most 1.53');
show('V-H', 'TIN Eve: ESSR increase of the proposed design at 20 dB', ...
     f5.essr_tin(i20, col(f5, 'MA_full')) - pr, '0.5');
show('V-H', 'TIN Eve: ESSR increase of the rate-oriented MA at 20 dB', ...
     f5.essr_tin(i20, col(f5, 'MA_rate')) - val(f5, i20, 'MA_rate'), '1.5');
i30 = find(f5.values == 30);
show('V-H', 'proposed w/o AN at 30 dB, TIN Eve', f5.essr_tin(i30, col(f5, 'MA_noAN')), '27.1');
show('V-H', 'proposed w/o AN at 30 dB, worst-case Eve', val(f5, i30, 'MA_noAN'), 'about 14');
e = ld('extra_eve_aod_error');  bench = {'MA_rate', 'AS', 'FPA_full', 'SPA_full'};  dec = 0;
for k = 1:numel(bench)
    y = e.essr(:, col(e, bench{k}));
    dec = max(dec, max(1 - y/y(1)));
end
show('V-H', 'AoD error: largest relative ESSR decrease of the benchmarks (%)', 100*dec, 'less than 2%');
y = e.essr(:, col(e, 'MA_full'));
show('V-H', 'AoD error: decrease of the proposed design at 0.05 rad (%)', 100*(1 - y(e.values == 0.05)/y(1)), '3%');
show('V-H', 'AoD error 0.1 rad: proposed design', y(e.values == 0.1), '18.73');
show('V-H', 'AoD error 0.1 rad: best benchmark', ...
     max(cellfun(@(k) val(e, find(e.values == 0.1), k), bench)), 'at most 17.93');
q3 = ld('extra_random_eve_M3');  q1 = ld('extra_random_eve_M1');
show('V-H', 'random Eve, M = 3: gain over the rate-oriented MA (%)', 100*(val(q3, 1, 'MA_full')/val(q3, 1, 'MA_rate') - 1), '10%');
show('V-H', 'random Eve, M = 3: gain over the sparse FPA (%)', 100*(val(q3, 1, 'MA_full')/val(q3, 1, 'SPA_full') - 1), '18%');
show('V-H', 'random Eve, M = 1: AS relative to the proposed design (%)', 100*(val(q1, 1, 'AS')/val(q1, 1, 'MA_full') - 1), 'close');
end
