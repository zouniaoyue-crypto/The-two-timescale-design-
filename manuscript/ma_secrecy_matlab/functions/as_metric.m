function best = as_metric(sc, prm, Tc, idx)
%AS_METRIC  Selection metric of the AS benchmark: approximate ESSR (P3) of every antenna
%   subset in the rows of idx (S x n indices into the candidate positions Tc), maximized
%   over prm.asGrid uniformly spaced AN powers q in [0, P_tot/(n - M)], where the power
%   allocation for each q is given by secrecy water-filling (Proposition 2). The
%   computation is vectorized over the subsets and processed in chunks of at most
%   prm.asChunk subsets (default 2e5) to limit the memory.

S = size(idx, 1);
if isfield(prm, 'asChunk'), C = prm.asChunk; else, C = 2e5; end
best = -inf(1, S);
for s0 = 1:C:S
    r = s0:min(S, s0 + C - 1);
    best(r) = metric_chunk(sc, prm, Tc, idx(r, :));
end
end

function best = metric_chunk(sc, prm, Tc, idx)
n = size(idx, 2);  M = sc.M;  k0 = 2*pi/sc.lambda;
S = size(idx, 1);  K = size(Tc, 1);
Hc = exp(1j*k0*(Tc*sc.au)) .* repmat(sqrt(sc.kappa.'), K, 1);   % K x M, rows of L
gc = exp(1j*k0*(Tc*sc.ae));                                         % K x 1
% Phi = L^H L + n I and v = L^H gbar for all subsets (M x M x S and M x S)
Phi = zeros(M, M, S);  v = zeros(M, S);
for i = 1:M
    Li = reshape(Hc(idx, i), S, n);             % S x n
    v(i, :) = sum(conj(Li) .* reshape(gc(idx), S, n), 2).';
    for j = i:M
        Lj = reshape(Hc(idx, j), S, n);
        Phi(i, j, :) = reshape(sum(conj(Li) .* Lj, 2), 1, 1, S);
        if j > i, Phi(j, i, :) = conj(Phi(i, j, :)); end
    end
    Phi(i, i, :) = Phi(i, i, :) + n;
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
c   = (abs(w).^2 + n*o2) ./ om;                 % c_m, main.tex eq:cm
d   = (n - vOv) .* (n - M) ./ (n - M + n*tr);   % d, main.tex eq:d
eta = repmat(sc.zeta, 1, S) * (n - M) ./ (n*om);
xi  = sc.kappa_e*c + 1;
psi = sc.kappa_e*d + n - M;
% best approximate ESSR of each subset over a coarse grid of q
best = -inf(1, S);
for q = linspace(0, sc.P/(n - M), prm.asGrid)
    th = xi ./ repmat(q*psi + sc.sbe, M, 1);
    pw = secrecy_wf(eta, th, sc.P - (n - M)*q, prm.nBisect);
    best = max(best, sum(log2(1 + eta.*pw) - log2(1 + th.*pw), 1));
end
end
