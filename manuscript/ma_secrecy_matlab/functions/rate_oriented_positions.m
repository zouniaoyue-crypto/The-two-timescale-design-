function T = rate_oriented_positions(sc, inits, prm)
%RATE_ORIENTED_POSITIONS  Benchmark "rate-oriented MA": antenna positions of the
%   two-timescale design in [ZhengTCOM2025] (ZF, equal power p_m = P_tot/M), i.e.,
%       max_t  sum_m log2(1 + eta_m(t) P_tot/M)   s.t. (9c), (9d),
%   which ignores Eve. It is solved by the element-wise MM method of Section IV-C:
%   with kappa_e = 0 and q = 0, the Eve-related terms of F(t,p,q) do not depend on t,
%   so that maximizing F over t is equivalent to maximizing the ergodic sum rate.
%   The best of the given initializations is returned (for M = 1 the objective does
%   not depend on t, and the first initialization, i.e., the UPA, is returned).

sc0 = sc;
sc0.kappa_e = 0;                               % Eve is ignored by the rate-oriented design
sc0.sbe = sc.sigma2e / sc.beta_e;
pEq = sc.P/sc.M * ones(sc.M, 1);
best = -inf;
for i = 1:numel(inits)
    Ti = inits{i};
    F = objective_F(sc0, Ti, pEq, 0);
    deltaLast = [];
    for it = 1:prm.aoMaxIter
        [Ti, deltaLast] = position_sweep(sc0, Ti, pEq, 0, prm, deltaLast);
        Fn = objective_F(sc0, Ti, pEq, 0);
        done = Fn - F < prm.aoTol*max(1, abs(Fn));
        F = Fn;
        if done, break; end
    end
    if F > best + 1e-9
        best = F;  T = Ti;
    end
end
end
