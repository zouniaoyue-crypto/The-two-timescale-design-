function res = sweep_schemes(prm, field, values, schemes)
%SWEEP_SCHEMES  Averages evaluate_schemes over prm.numDrops random drops for each
%   value of the parameter prm.(field). The same drops (seeds) are used for all
%   values and all schemes.
%   res.essr(i, k), res.anfrac(i, k), res.F(i, k): averages for value i and scheme k.

K = numel(schemes);
res.values = values;  res.schemes = schemes;
res.essr = zeros(numel(values), K);
res.anfrac = zeros(numel(values), K);
res.F = zeros(numel(values), K);
for i = 1:numel(values)
    pr = prm;  pr.(field) = values(i);
    t0 = tic;
    for dI = 1:prm.numDrops
        sc = gen_scenario(pr, prm.seed + dI);
        out = evaluate_schemes(sc, pr, schemes, prm.seed + dI);
        for k = 1:K
            r = out.(schemes{k});
            res.essr(i, k)   = res.essr(i, k)   + r.essr/prm.numDrops;
            res.anfrac(i, k) = res.anfrac(i, k) + r.anfrac/prm.numDrops;
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
        end
    end
    fprintf('%s = %g done (%.0f s): ESSR = %s\n', field, values(i), toc(t0), mat2str(res.essr(i,:), 4));
end
end
