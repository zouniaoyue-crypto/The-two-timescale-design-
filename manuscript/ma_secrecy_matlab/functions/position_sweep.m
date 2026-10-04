function [T, deltaLast] = position_sweep(sc, T, p, q, prm, deltaLast, plus)
%POSITION_SWEEP  One round of element-wise updates of the antenna positions
%   (Section IV-C of main.tex). For each MA n, with the other positions fixed:
%   Stage 1 (global search): F is evaluated by objective_F_n at all points of a uniform
%     grid over C with spacing prm.gridStep (in lambda) that satisfy the minimum-distance
%     constraints exactly; MA n moves to the best point if it improves F. This locates
%     the best basin of the multimodal function F(t_n).
%   Stage 2 (MM refinement), repeated at most prm.mmMaxIter times or until the relative
%     increase of F is below prm.mmTol:
%     1) gradient g = grad_{t_n} F at the current point (Appendix B);
%     2) surrogate  F(t^(l)) + g^T (t_n - t_n^(l)) - delta_n/2 ||t_n - t_n^(l)||^2;
%     3) maximizer = projection of t_n^(l) + g/delta_n onto the polygon (P3.2.n);
%     4) backtracking: delta_n <- 2 delta_n until F(new) >= surrogate(new).
%   deltaLast (N x 1) stores the last accepted delta_n; the next search starts
%   from max(delta0, deltaLast/2). Both stages never decrease F.
%   plus = true: the objective is sum_m [f_m]^+ (equal-power benchmarks, for which
%   the LUs cannot be switched off); the surrogate is then built from the minorizer
%   sum_{m: f_m > 0} f_m, which is tight at the current point.

N = sc.N;
if nargin < 6 || isempty(deltaLast), deltaLast = prm.delta0*ones(N,1); end
if nargin < 7, plus = false; end
xs = -sc.A/2 : prm.gridStep : sc.A/2;
[X, Y] = meshgrid(xs, xs);
G = [X(:).'; Y(:).'];                                  % grid over C, 2 x K
for n = 1:N
    % ---- stage 1: global search over the feasible grid points ----
    if prm.gridStep > 0
        idx = [1:n-1, n+1:N];
        D2 = (repmat(G(1,:), N-1, 1) - repmat(T(idx,1), 1, size(G,2))).^2 + ...
             (repmat(G(2,:), N-1, 1) - repmat(T(idx,2), 1, size(G,2))).^2;
        C  = [G(:, all(D2 >= sc.Dmin^2, 1)), T(n,:).'];  % last column: current position
        Fc = objective_F_n(sc, T, n, C, p, q, plus);
        [~, k] = max(Fc);
        if Fc(k) > Fc(end), T(n,:) = C(:,k).'; end
    end
    % ---- stage 2: MM refinement ----
    [Fcur, Rb, Re] = objective_F(sc, T, p, q, plus);
    for it = 1:prm.mmMaxIter
        F0 = Fcur;
        act = [];
        if plus, act = (Rb - Re) > 0; end
        g = grad_F_n(sc, T, p, q, n, act);
        [Acon, bcon] = lin_constraints(sc, T, n);
        tn = T(n,:).';
        delta = max(prm.delta0, deltaLast(n)/2);
        accepted = false;
        for k = 1:60
            tnew = proj_polygon(tn + g/delta, Acon, bcon);
            Tn = T;  Tn(n,:) = tnew.';
            [Fnew, Rbn, Ren] = objective_F(sc, Tn, p, q, plus);
            sur = Fcur + g.'*(tnew - tn) - delta/2*sum((tnew - tn).^2);
            if Fnew >= sur - 1e-12
                accepted = true;  break;
            end
            delta = 2*delta;
        end
        if accepted && Fnew >= Fcur
            T = Tn;  Fcur = Fnew;  Rb = Rbn;  Re = Ren;  deltaLast(n) = delta;
        end
        if Fcur - F0 < prm.mmTol*max(1, abs(Fcur)), break; end
    end
end
end
