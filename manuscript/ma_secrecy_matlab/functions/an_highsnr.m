function f = an_highsnr(sc, T)
%AN_HIGHSNR  High-SNR prediction of the optimized AN power fraction (N - M) q / P_tot for the
%   positions T (Section III-D 3) of main.tex): f = 1 - alpha*, where alpha* in (0, 1) is the
%   unique maximizer of the sum of the constant terms of eq:highsnr,
%       M log2(alpha) + M log2(1 - alpha) - sum_m log2(1 + alpha (Xi_m - 1)),
%   i.e., the root of M/alpha - M/(1 - alpha) = sum_m (Xi_m - 1)/(1 + alpha (Xi_m - 1)),
%   with Xi_m = (N - M) xi_m / (M psi). The left-hand side minus the right-hand side is
%   strictly decreasing in alpha (the sum is strictly concave), so the root is found by
%   bisection. For Xi_m = Xi, alpha* = 1/(1 + sqrt(Xi)).
[~, xi, psi] = rate_coeffs(sc, T);
N = sc.N;  M = sc.M;
X = (N - M)*xi(:)/(M*psi);
dg = @(a) M/a - M/(1 - a) - sum((X - 1)./(1 + a*(X - 1)));
lo = 0;  hi = 1;
for it = 1:60
    a = (lo + hi)/2;
    if dg(a) > 0, lo = a; else, hi = a; end
end
f = 1 - (lo + hi)/2;
end
