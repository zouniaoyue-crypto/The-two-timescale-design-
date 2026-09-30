function [T, deltaLast] = position_sweep(sc, T, p, q, prm, deltaLast, plus)
%POSITION_SWEEP  One round of element-wise MM updates of the antenna positions
%   (Section IV-C of main.tex, eqs. (49)-(53)). For each MA n:
%     1) gradient g = grad_{t_n} F at the current point (Appendix B);
%     2) surrogate  F(t^(l)) + g^T (t_n - t_n^(l)) - delta_n/2 ||t_n - t_n^(l)||^2;
%     3) maximizer = projection of t_n^(l) + g/delta_n onto the polygon (P3.2.n);
%     4) backtracking: delta_n <- 2 delta_n until F(new) >= surrogate(new).
%   deltaLast (N x 1) stores the last accepted delta_n; the next search starts
%   from max(delta0, deltaLast/2).
%   plus = true: the objective is sum_m [f_m]^+ (equal-power benchmarks, for which
%   the LUs cannot be switched off); the surrogate is then built from the minorizer
%   sum_{m: f_m > 0} f_m, which is tight at the current point.

N = sc.N;
if nargin < 6 || isempty(deltaLast), deltaLast = prm.delta0*ones(N,1); end
if nargin < 7, plus = false; end
[Fcur, Rb, Re] = objective_F(sc, T, p, q, plus);
for n = 1:N
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
end
end
