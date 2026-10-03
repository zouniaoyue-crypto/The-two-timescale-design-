function [T, best, idx] = as_select(sc, prm)
%AS_SELECT  Benchmark "antenna selection (AS)" with statistical CSI: N of the 2N
%   antennas of a lambda/2-spaced UPA (prm.asRows x prm.asCols, e.g., 4 x 4 for N = 8)
%   are selected by exhaustive search over all nchoosek(2N, N) subsets. The selection
%   metric is the same as for the proposed design, i.e., the approximate ESSR (P3) with
%   the long-term power allocation of Algorithm 1 (secrecy water-filling for each q on
%   a coarse grid of prm.asGrid points, evaluated for all subsets in a vectorized way).
%   The power allocation of the selected subset is then refined by power_opt.m.

N = sc.N;  M = sc.M;  k0 = 2*pi/sc.lambda;
Tc = upa_positions(prm.asRows*prm.asCols, prm.asRows, prm.asCols, 0.5);   % candidates
K  = size(Tc, 1);
idx = nchoosek(1:K, N);                         % S x N subsets
S  = size(idx, 1);
Hc = exp(1j*k0*(Tc*sc.au)) .* repmat(sqrt(sc.kappa.'), K, 1);   % K x M, rows of L
gc = exp(1j*k0*(Tc*sc.ae));                                         % K x 1
% Phi = L^H L + N I and v = L^H gbar for all subsets (M x M x S and M x S)
Phi = zeros(M, M, S);  v = zeros(M, S);
for i = 1:M
    Li = reshape(Hc(idx, i), S, N);             % S x N
    v(i, :) = sum(conj(Li) .* reshape(gc(idx), S, N), 2).';
    for j = i:M
        Lj = reshape(Hc(idx, j), S, N);
        Phi(i, j, :) = reshape(sum(conj(Li) .* Lj, 2), 1, 1, S);
        if j > i, Phi(j, i, :) = conj(Phi(i, j, :)); end
    end
    Phi(i, i, :) = Phi(i, i, :) + N;
end
Om = batch_inv_hpd(Phi);
om = zeros(M, S);  o2 = zeros(M, S);  w = zeros(M, S);
for m = 1:M
    Omm = reshape(Om(m, :, :), M, S);           % m-th row of Omega
    om(m, :) = real(Omm(m, :));
    o2(m, :) = sum(abs(Omm).^2, 1);             % [Omega^2]_{mm} (Omega Hermitian)
    w(m, :)  = sum(Omm .* v, 1);                % [Omega v]_m
end
tr  = sum(om, 1);
vOv = real(sum(conj(v) .* w, 1));
c   = (abs(w).^2 + N*o2) ./ om;                 % c_m, eq. (24)
d   = (N - vOv) .* (N - M) ./ (N - M + N*tr);   % d, eq. (25)
eta = repmat(sc.zeta, 1, S) * (N - M) ./ (N*om);
xi  = sc.kappa_e*c + 1;
psi = sc.kappa_e*d + N - M;
% best approximate ESSR of each subset over a coarse grid of q
best = -inf(1, S);
for q = linspace(0, sc.P/(N - M), prm.asGrid)
    th = xi ./ repmat(q*psi + sc.sbe, M, 1);
    pw = secrecy_wf(eta, th, sc.P - (N - M)*q, prm.nBisect);
    best = max(best, sum(log2(1 + eta.*pw) - log2(1 + th.*pw), 1));
end
[~, s] = max(best);
T = Tc(idx(s, :), :);
end
