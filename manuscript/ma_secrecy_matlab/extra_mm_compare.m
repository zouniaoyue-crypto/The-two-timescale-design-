function res = extra_mm_compare(prm, drops)
%EXTRA_MM_COMPARE  Stage 2 of Algorithm 2 versus the surrogate of [ZhengTCOM2025]
%   (Section V-B of main.tex, text). For each drop (default: 1:prm.numDrops, production
%   seeds), Algorithm 2 is run from the UPA initialization at the default setup with the
%   same Stage 1 and two Stage-2 variants (mmcmp_sweep.m):
%     'S0'     : the MM of main.tex (quadratic minorizer, backtracking, closed-form
%                projection), identical to position_sweep.m;
%     'S1zheng': the LU terms bounded by [ZhengTCOM2025, Lemma 1] with its closed-form
%                curvature and the Eve terms by a second-order Taylor bound with their
%                largest curvature over C (computed numerically, which favors this
%                variant); the concave subproblem is solved numerically (sqp/fmincon).
%   Stored per drop: objective value F, Monte Carlo ESSR (prm.S samples), AO and MM
%   iterations, solver calls, run times (without the curvature oracle), the accepted
%   curvatures delta_n of S0, and the curvature of the surrogate at the expansion points.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(drops), drops = 1:prm.numDrops; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
vars = {'S0', 'S1zheng'};  modes = {'s0', 's1zheng'};
for v = 1:2
    res.(vars{v}) = struct('F', [], 'essr', [], 'aoIt', [], 'mmIt', [], 'solver', [], 'time', [], ...
                           'curv', [], 'curvEff', []);
end
res.drops = drops;
for dI = drops
    sc = gen_scenario(prm, prm.seed + dI);
    T0 = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
    for v = 1:2
        t0 = tic;
        [T, p, q, h, st] = mmcmp_ao(sc, T0, prm, struct('stage1', true, 'mode', modes{v}));
        tt = toc(t0) - st.tOr;
        [~, ~, essr] = mc_rates(sc, T, p, q, prm.S, prm.seed + dI);
        r = res.(vars{v});
        r.F(end+1) = h(end);  r.essr(end+1) = essr;  r.aoIt(end+1) = st.aoIt;  r.mmIt(end+1) = st.mmIt;
        r.solver(end+1) = st.solver;  r.time(end+1) = tt;
        if v == 1, r.curv = [r.curv, st.curv]; else, r.curvEff = [r.curvEff, st.curvEff]; end
        res.(vars{v}) = r;
    end
    fprintf('extra_mm_compare: drop %d, F = %.4f / %.4f, MM iterations %d / %d\n', dI, ...
            res.S0.F(end), res.S1zheng.F(end), res.S0.mmIt(end), res.S1zheng.mmIt(end));
end
save(fullfile(results_dir(), 'extra_mm_compare.mat'), 'res', 'prm', '-v7');
d = res.S1zheng.F - res.S0.F;
fprintf('extra_mm_compare: F difference %.3f%% (SE %.3f%%), MM iterations x%.2f, run time x%.1f\n', ...
        100*mean(d)/mean(res.S0.F), 100*std(d)/sqrt(numel(d))/mean(res.S0.F), ...
        mean(res.S1zheng.mmIt)/mean(res.S0.mmIt), mean(res.S1zheng.time)/mean(res.S0.time));
end
