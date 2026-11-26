function T = snap_to_grid(T0, sc, step)
%SNAP_TO_GRID  Moves the positions T0 (N x 2) to distinct points of the grid over
%   C = [-A/2, A/2]^2 with spacing step (in lambda), one MA after the other, each to the
%   nearest free grid point that satisfies the minimum-distance constraint with the MAs
%   already placed. Used for the initializations of the APS benchmark, whose positions
%   are restricted to the grid. Deterministic (no random numbers).
xs = -sc.A/2 : step : sc.A/2;
[X, Y] = meshgrid(xs, xs);
G = [X(:), Y(:)];
N = size(T0, 1);
T = zeros(N, 2);
for n = 1:N
    d2 = (G(:,1) - T0(n,1)).^2 + (G(:,2) - T0(n,2)).^2;
    for k = 1:n-1
        d2((G(:,1) - T(k,1)).^2 + (G(:,2) - T(k,2)).^2 < sc.Dmin^2 - 1e-12) = inf;
    end
    [dmin, i] = min(d2);
    if ~isfinite(dmin), error('snap_to_grid: no feasible grid point for MA %d', n); end
    T(n, :) = G(i, :);
end
end
