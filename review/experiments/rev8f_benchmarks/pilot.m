addpath('/home/user/The-two-timescale-design-/manuscript/ma_secrecy_matlab'); addpath('/home/user/The-two-timescale-design-/manuscript/ma_secrecy_matlab/functions');
addpath('/home/user/The-two-timescale-design-/review/experiments/rev8f_benchmarks/shadow');   % shadows rate_coeffs
prm = default_params();  D = prm.numDrops;
% ---- APS: positions on the lambda/2 grid?
for dI = 1:3
    sc = gen_scenario(prm, prm.seed + dI);
    out = evaluate_schemes(sc, prm, {'APS'}, prm.seed + dI);
    T = out.APS.T;  r = mod(T + sc.A/2, prm.apsStep);
    fprintf('APS drop %d: max distance to the lambda/2 grid %.2e, distinct %d, min spacing %.2f\n', dI, ...
            max(min(r(:), prm.apsStep - r(:))), size(unique(T, 'rows'), 1), sqrt(min(min((T(:,1)-T(:,1).').^2 + (T(:,2)-T(:,2).').^2 + diag(inf(size(T,1),1))))));
end
% ---- FPA with Eve-aware (directional) AN, approximate ESSR F, vs stored F
R = results_dir();
kb = load(fullfile(R, 'fig8_rician_b.mat'));  kb = kb.res;
f5 = load(fullfile(R, 'fig5_snr.mat'));  f5 = f5.res;
cases = {f5, 'P_dB', [10 20 30]; kb, 'kappae_dB', [-10 0 20]};
for c = 1:2
    res = cases{c, 1};  field = cases{c, 2};
    for v = cases{c, 3}
        pr = prm;  pr.(field) = v;
        Fi = 0;  Fd = 0;  af = 0;
        for dI = 1:D
            sc = gen_scenario(pr, prm.seed + dI);
            T = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
            setenv('MA_DIR_AN', '0');  [p, q] = power_opt(sc, T, pr, 'full');  Fi = Fi + objective_F(sc, T, p, q, true)/D;
            setenv('MA_DIR_AN', '1');  [p, q] = power_opt(sc, T, pr, 'full');  Fd = Fd + objective_F(sc, T, p, q, true)/D;
            af = af + (sc.N - sc.M)*q/sc.P/D;
        end
        setenv('MA_DIR_AN', '0');
        i = find(res.values == v);  col = @(k) find(strcmp(res.schemes, k), 1);
        fprintf('%s = %3d: approx. ESSR F: FPA iso %.2f (stored %.2f) | FPA Eve-aware AN %.2f (AN frac %.2f) | rate-MA %.2f | proposed %.2f\n', ...
                field, v, Fi, res.F(i, col('FPA_full')), Fd, af, res.F(i, col('MA_rate')), res.F(i, col('MA_full')));
    end
end
