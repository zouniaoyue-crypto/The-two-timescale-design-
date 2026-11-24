function [T, p, q, hist, st] = ao_optimize_v(sc, T0, prm, opt)
%AO_OPTIMIZE_V  Experiment copy of ao_optimize.m (mode 'full') with instrumentation.
st = struct('tS1', 0, 'tS2', 0, 'tOr', 0, 'tPow', 0, 'mmIt', 0, 'evals', 0, 'solver', 0, ...
            'viol', 0, 'curv', [], 'info', [], 'aoIt', 0, 'step', [], 'curvEff', []);
t0 = tic;  [p, q] = power_opt(sc, T0, prm, 'full');  st.tPow = st.tPow + toc(t0);
T = T0;  hist = objective_F(sc, T, p, q, false);  deltaLast = [];
for it = 1:prm.aoMaxIter
    [T, deltaLast, st] = position_sweep_v(sc, T, p, q, prm, deltaLast, opt, st);
    t0 = tic;  [p2, q2] = power_opt(sc, T, prm, 'full');  st.tPow = st.tPow + toc(t0);
    if objective_F(sc, T, p2, q2, false) >= objective_F(sc, T, p, q, false), p = p2;  q = q2; end
    hist(end+1) = objective_F(sc, T, p, q, false); %#ok<AGROW>
    st.aoIt = it;
    if hist(end) - hist(end-1) < prm.aoTol*max(1, abs(hist(end))), break; end
end
end
