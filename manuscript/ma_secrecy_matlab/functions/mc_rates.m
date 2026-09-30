function [Rb, Re, essr, stats] = mc_rates(sc, T, p, q, S, seed)
%MC_RATES  Monte Carlo evaluation of the exact ergodic rates under ZF precoding and
%   null-space AN (eqs. (9)-(10) of main.tex), with S channel realizations.
%   Rb(m)  = E{ log2(1 + p_m / (sigma_m^2 [(H^H H)^{-1}]_mm)) }
%   Re(m)  = E{ log2(1 + p_m |g^H wbar_m|^2 / (q g^H P_H^perp g + sigma_e^2)) }
%   essr   = sum_m [Rb(m) - Re(m)]^+
%   stats.leak(m) = E{|g^H wbar_m|^2},  stats.an = E{g^H P_H^perp g}  (for validation)

if nargin < 6, seed = 1; end
rng(seed);
N = sc.N;  M = sc.M;  k0 = 2*pi/sc.lambda;
p = p(:);
Hbar = exp(1j*k0*(T*sc.au));                  % N x M
gbar = exp(1j*k0*(T*sc.ae));                  % N x 1
aL = sqrt(sc.beta .* sc.kappa ./ (sc.kappa + 1)).';   % 1 x M
aN = sqrt(sc.beta ./ (sc.kappa + 1)).';
Ht = (randn(N, M, S) + 1j*randn(N, M, S))/sqrt(2);
H  = repmat(Hbar .* aL, [1 1 S]) + Ht .* repmat(aN, [N 1 S]);          % N x M x S
ke = sc.kappa_e;
gt = (randn(N, 1, S) + 1j*randn(N, 1, S))/sqrt(2);
g  = sqrt(sc.beta_e)*(sqrt(ke/(ke+1))*repmat(gbar, [1 1 S]) + sqrt(1/(ke+1))*gt);   % N x 1 x S

% Gram matrices G = H^H H (M x M x S) and u = H^H g (M x S)
G = zeros(M, M, S);
u = zeros(M, S);
for i = 1:M
    Hi = conj(H(:, i, :));
    for j = i:M
        G(i, j, :) = sum(Hi .* H(:, j, :), 1);
        if j > i, G(j, i, :) = conj(G(i, j, :)); end
    end
    u(i, :) = reshape(sum(Hi .* g, 1), 1, S);
end
Gi = batch_inv_hpd(G);                            % (H^H H)^{-1}
dg = zeros(M, S);
uG = zeros(M, S);                                  % [u^H (H^H H)^{-1}]_m = g^H H (H^H H)^{-1} e_m
uc = conj(u);
for m = 1:M
    dg(m, :) = real(reshape(Gi(m, m, :), 1, S));
    uG(m, :) = sum(uc .* reshape(Gi(:, m, :), M, S), 1);
end
leak = abs(uG).^2 ./ dg;                                     % |g^H wbar_m|^2
an   = real(reshape(sum(abs(g).^2, 1), 1, S) - sum(uG .* u, 1));   % g^H P_H^perp g
snr  = repmat(p ./ sc.sigma2, 1, S) ./ dg;
sinr = repmat(p, 1, S) .* leak ./ repmat(q*an + sc.sigma2e, M, 1);
Rb = mean(log2(1 + snr), 2);
Re = mean(log2(1 + sinr), 2);
essr = sum(max(Rb - Re, 0));
stats.leak = mean(leak, 2);
stats.an   = mean(an);
end
