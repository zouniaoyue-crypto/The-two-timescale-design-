function run_d1(tag, variants, drops, outdir)
%RUN_D1  Small-scale S0-vs-S1 experiment: for each drop (production seeds), runs the given
%   variants from the UPA initialization at the default setup and stores the final objective,
%   the Monte Carlo ESSR (10^3 channel samples), iteration counts, and run times.
prm = default_params();
R = struct();
for v = 1:numel(variants), R.(variants{v}) = struct('F', [], 'essr', [], 'aoIt', [], 'mmIt', [], 'solver', [], ...
    'tNoOr', [], 'tOr', [], 'tS2', [], 'viol', [], 'curv', [], 'curvEff', [], 'step', [], 'hist', {{}}); end
for dI = drops
    sc = gen_scenario(prm, prm.seed + dI);
    T0 = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
    for v = 1:numel(variants)
        switch variants{v}
            case 'S0',          opt = struct('stage1', true,  'mode', 's0');
            case 'Stage1only',  opt = struct('stage1', true,  'mode', 'none');
            case 'S1best',      opt = struct('stage1', true,  'mode', 's1best');
            case 'S1zheng',     opt = struct('stage1', true,  'mode', 's1zheng');
            case 'S1zhengLocal',opt = struct('stage1', false, 'mode', 's1zheng');
            case 'S0local',     opt = struct('stage1', false, 'mode', 's0');
        end
        t0 = tic;  [T, p, q, h, st] = ao_optimize_v(sc, T0, prm, opt);  tt = toc(t0);
        [~, ~, essr] = mc_rates(sc, T, p, q, 1000, prm.seed + dI);
        r = R.(variants{v});
        r.F(end+1) = h(end);  r.essr(end+1) = essr;  r.aoIt(end+1) = st.aoIt;  r.mmIt(end+1) = st.mmIt;
        r.solver(end+1) = st.solver;  r.tNoOr(end+1) = tt - st.tOr;  r.tOr(end+1) = st.tOr;  r.tS2(end+1) = st.tS2;
        r.viol(end+1) = st.viol;  r.curv = [r.curv, st.curv];  r.curvEff = [r.curvEff, st.curvEff];  r.step = [r.step, st.step];
        r.hist{end+1} = h;
        R.(variants{v}) = r;
        printf('%s drop %2d %-12s F %.4f essr %.4f AO %2d MM %4d solver %4d time %.2f s\n', tag, dI, variants{v}, h(end), essr, st.aoIt, st.mmIt, st.solver, tt - st.tOr);
        fflush(stdout);
    end
    save('-v7', fullfile(outdir, ['d1_' tag '.mat']), 'R', 'drops', 'variants');
end
end
