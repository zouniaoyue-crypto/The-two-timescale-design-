function pred_equal_power(resultsDir)
%PRED_EQUAL_POWER  High-SNR estimate of the equal-power loss (rev-7b report, Sec. 3.2), from
%   the stored AN fractions of Fig. 5 (results/fig5_snr.mat before the rev-7 rerun). By the
%   high-SNR expansion of Sec. III-D 3) with Xi_m = Xi, the constant term per LU is
%   g(alpha) = log2(alpha (1 - alpha)) - log2(1 + alpha (Xi - 1)); Xi follows from the AN
%   fraction 1 - alpha* = sqrt(Xi)/(1 + sqrt(Xi)), and equal power p_m = q = P_tot/N is
%   alpha = M/N. Loss = M (g(alpha*) - g(M/N)).
L = load(fullfile(resultsDir, 'fig5_snr.mat'));  r = L.res;  M = L.prm.M;  N = L.prm.N;
g = @(a, X) log2(a.*(1 - a)) - log2(1 + a.*(X - 1));
for key = {'MA_full', 'FPA_full'}
    k = find(strcmp(r.schemes, key{1}));
    for snr = [20 30]
        f = r.anfrac(r.values == snr, k);  sX = f/(1 - f);  X = sX^2;  a = 1/(1 + sX);
        printf('%-8s %2d dB: AN fraction %.4f -> Xi %.3f, alpha* %.3f, equal-power loss %.2f bps/Hz\n', ...
               key{1}, snr, f, X, a, M*(g(a, X) - g(M/N, X)));
    end
end
end
