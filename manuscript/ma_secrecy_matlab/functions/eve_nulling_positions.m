function T = eve_nulling_positions(sc, inits, prm)
%EVE_NULLING_POSITIONS  Benchmark "Eve-nulling MA": antenna positions that minimize the
%   LoS correlations between Eve and the LUs,
%       J(t) = ||Hbar^H(t) gbar(t)||^2 = sum_m |hbar_m^H(t) gbar(t)|^2,
%   i.e., they target v(t) = 0 in Section III-D of main.tex (LoS component of Eve
%   orthogonal to those of all LUs), which minimizes the leakage and maximizes the AN
%   received by Eve for a given LU correlation, but they ignore the decorrelation of the
%   LUs. Element-wise search over the feasible points of the grid of Stage 1 (spacing
%   prm.gridStep), repeated until no MA moves (at most prm.aoMaxIter rounds); the best
%   (smallest J) of the given initializations is returned. The power allocation is then
%   optimized by Algorithm 1 (evaluate_schemes.m).
k0 = 2*pi/sc.lambda;
Dv = sc.ae - sc.au;                                   % 2 x M, a_e - a_m
xs = -sc.A/2 : prm.gridStep : sc.A/2;
[X, Y] = meshgrid(xs, xs);
G = [X(:).'; Y(:).'];                                 % grid over C, 2 x K
EG = exp(1j*k0*(G.'*Dv));                             % K x M
best = inf;  T = inits{1};
for i = 1:numel(inits)
    Ti = inits{i};  N = size(Ti, 1);
    E = exp(1j*k0*(Ti*Dv));                           % N x M
    for it = 1:prm.aoMaxIter
        moved = false;
        for n = 1:N
            s = sum(E, 1) - E(n, :);                  % 1 x M: the other MAs
            idx = [1:n-1, n+1:N];
            D2 = (repmat(G(1,:), N-1, 1) - repmat(Ti(idx,1), 1, size(G,2))).^2 + ...
                 (repmat(G(2,:), N-1, 1) - repmat(Ti(idx,2), 1, size(G,2))).^2;
            Jc = sum(abs(repmat(s, size(G,2), 1) + EG).^2, 2).';
            Jc(~all(D2 >= sc.Dmin^2, 1)) = inf;
            Jcur = sum(abs(s + E(n, :)).^2);
            [Jmin, k] = min(Jc);
            if Jmin < Jcur - 1e-9*max(1, Jcur)
                Ti(n, :) = G(:, k).';  E(n, :) = EG(k, :);  moved = true;
            end
        end
        if ~moved, break; end
    end
    J = sum(abs(sum(E, 1)).^2);
    if J < best - 1e-9
        best = J;  T = Ti;
    end
end
end
