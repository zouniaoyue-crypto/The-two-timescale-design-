function res = sweep_schemes(prm, field, values, schemes)
%SWEEP_SCHEMES  Averages evaluate_schemes over prm.numDrops random drops for each
%   value of the parameter prm.(field). The same drops (seeds) are used for all
%   values and all schemes.
%   res.essr(i, k), res.anfrac(i, k), res.F(i, k): averages for value i and scheme k;
%   res.essrDrops(i, k, d): ESSR of drop d (for statistics beyond the average);
%   res.essr_tin(i, k): ESSR for an eavesdropper treating interference as noise.
%   field = 'spread': beta_m (dB) = -value (m-1)/(M-1), i.e., [0, -value/2, -value] for M = 3.
%   field = 'eveAoDErr': error (rad) of the AoD of Eve known at the BS (design_scenario.m);
%   the designs are evaluated for the true AoD.

K = numel(schemes);
res.values = values;  res.schemes = schemes;
res.essr = zeros(numel(values), K);
res.anfrac = zeros(numel(values), K);
res.F = zeros(numel(values), K);
res.essrDrops = zeros(numel(values), K, prm.numDrops);
res.essr_tin = zeros(numel(values), K);
res.designs = cell(numel(values), K, prm.numDrops);
res.leak = zeros(numel(values), K, prm.M);
res.an = zeros(numel(values), K);
res.parameterField = field;
res.evaluationSamples = prm.S;
res.algorithmVersion = 'revision-v1';
for i = 1:numel(values)
    pr = prm;
    if strcmp(field, 'spread')
        pr.beta_dB = -values(i) * (0:prm.M-1) / max(prm.M - 1, 1);
    else
        pr.(field) = values(i);
    end
    t0 = tic;
    for dI = 1:prm.numDrops
        sc  = gen_scenario(pr, prm.seed + dI);                 % true statistical CSI
        scD = design_scenario(pr, sc, prm.seed + dI);          % statistical CSI at the BS
        out = evaluate_schemes(scD, pr, schemes, prm.seed + dI, sc);
        for k = 1:K
            r = out.(schemes{k});
            res.essr(i, k)   = res.essr(i, k)   + r.essr/prm.numDrops;
            res.essrDrops(i, k, dI) = r.essr;
            res.essr_tin(i, k) = res.essr_tin(i, k) + r.essr_tin/prm.numDrops;
            res.anfrac(i, k) = res.anfrac(i, k) + r.anfrac/prm.numDrops;
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
            res.designs{i, k, dI} = struct('T', r.T, 'p', r.p, 'q', r.q, ...
                'hist', r.hist, 'seed', r.seed, 'evaluationSamples', r.evaluationSamples, ...
                'Rb', r.Rb, 'Re', r.Re, 'leak', r.leak, 'an', r.an);
            res.leak(i, k, :) = res.leak(i, k, :) + reshape(r.leak, 1, 1, prm.M)/prm.numDrops;
            res.an(i, k) = res.an(i, k) + r.an/prm.numDrops;
        end
    end
    fprintf('%s = %g done (%.0f s): ESSR = %s\n', field, values(i), toc(t0), mat2str(res.essr(i,:), 4));
end
end
