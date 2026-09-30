function res = power_allocation_sweep(prm, P_dB, spread, schemes)
%POWER_ALLOCATION_SWEEP  Worker of fig8_power_allocation: for the transmit SNR P_dB
%   and each spread value (dB), the large-scale fading coefficients of the LUs are
%   beta_m (dB) = -spread*(m-1)/(M-1), i.e., [0, -spread/2, -spread] for M = 3,
%   and the given schemes are averaged over prm.numDrops random drops.
prm.P_dB = P_dB;
K = numel(schemes);
res.values = spread;
res.essr = zeros(numel(spread), K);
res.anfrac = zeros(numel(spread), K);
res.F = zeros(numel(spread), K);
for i = 1:numel(spread)
    pr = prm;
    pr.beta_dB = -spread(i) * (0:prm.M-1) / max(prm.M - 1, 1);
    t0 = tic;
    for dI = 1:prm.numDrops
        sc = gen_scenario(pr, prm.seed + dI);
        out = evaluate_schemes(sc, pr, schemes, prm.seed + dI);
        for k = 1:K
            r = out.(schemes{k});
            res.essr(i, k)   = res.essr(i, k)   + r.essr/prm.numDrops;
            res.anfrac(i, k) = res.anfrac(i, k) + r.anfrac/prm.numDrops;
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
        end
    end
    fprintf('fig8: P = %g dB, spread = %g dB done (%.0f s): ESSR = %s\n', P_dB, spread(i), toc(t0), ...
            mat2str(res.essr(i,:), 4));
end
end
