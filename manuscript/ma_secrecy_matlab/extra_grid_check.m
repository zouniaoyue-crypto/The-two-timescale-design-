function res = extra_grid_check(prm, numDrops)
%EXTRA_GRID_CHECK  Grid-resolution check of Stage 1 of Algorithm 2 (Section V-A of
%   main.tex): the proposed design is obtained with the default grid spacing
%   (prm.gridStep = 0.1, i.e., lambda/10) and with half of it on the same AoD drops as in
%   sweep_schemes.m, and the Monte Carlo ESSR (exact ZF/null-space-AN rates, prm.S samples)
%   and the approximate objective F of the two designs are compared.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, numDrops = min(20, prm.numDrops); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.steps = [prm.gridStep, prm.gridStep / 2];
res.F = zeros(numDrops, 2);  res.essr = res.F;  res.time = res.F;
for dI = 1:numDrops
    sc = gen_scenario(prm, prm.seed + dI);
    for s = 1:2
        pr = prm;  pr.gridStep = res.steps(s);
        t0 = tic;
        out = evaluate_schemes(sc, pr, {'MA_full'}, prm.seed + dI, sc);
        res.time(dI, s) = toc(t0);
        res.F(dI, s) = out.MA_full.F;  res.essr(dI, s) = out.MA_full.essr;
    end
    fprintf('drop %2d: ESSR %.4f / %.4f bps/Hz\n', dI, res.essr(dI, 1), res.essr(dI, 2));
end
res.relChange = mean(res.essr(:, 2)) / mean(res.essr(:, 1)) - 1;
fprintf('average ESSR %.4f / %.4f bps/Hz (spacing %.3f / %.3f lambda), relative change %.3f%%\n', ...
        mean(res.essr(:, 1)), mean(res.essr(:, 2)), res.steps, 100 * res.relChange);
save(fullfile(results_dir(), 'extra_grid_check.mat'), 'res', 'prm', '-v7');
end
