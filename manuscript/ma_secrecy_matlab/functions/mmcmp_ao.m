function [T, p, q, hist, st] = mmcmp_ao(sc, T0, prm, opt)
%MMCMP_AO  Copy of ao_optimize.m (mode 'full') with instrumentation and the Stage-2 variants
%   of mmcmp_sweep.m (extra_mm_compare.m).
st = struct('tS1', 0, 'tS2', 0, 'tOr', 0, 'tPow', 0, 'mmIt', 0, 'evals', 0, 'solver', 0, ...
            'viol', 0, 'curv', [], 'info', [], 'aoIt', 0, 'step', [], 'curvEff', []);
t0 = tic;  [p, q] = power_opt(sc, T0, prm, 'full');  st.tPow = st.tPow + toc(t0);
T = T0;  hist = objective_F(sc, T, p, q, false);  deltaLast = [];
for it = 1:prm.aoMaxIter
    [T, deltaLast, st] = mmcmp_sweep(sc, T, p, q, prm, deltaLast, opt, st);
    t0 = tic;  [p2, q2] = power_opt(sc, T, prm, 'full');  st.tPow = st.tPow + toc(t0);
    if objective_F(sc, T, p2, q2, false) >= objective_F(sc, T, p, q, false), p = p2;  q = q2; end
    hist(end+1) = objective_F(sc, T, p, q, false); %#ok<AGROW>
    st.aoIt = it;
    if hist(end) - hist(end-1) < prm.aoTol*max(1, abs(hist(end))), break; end
end
end
