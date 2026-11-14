function res = extra_as_swap_check(prm, Nvals)
%EXTRA_AS_SWAP_CHECK  Validation of the swap search of the AS benchmark (as_swap.m), which
%   is used for all N in Figs. 5-7 of main.tex, against the exhaustive search for
%   N <= 10 on the same 100 drops as extra_num_antennas.m. For each drop, the selection
%   metric (approximate ESSR, as_metric.m) of both subsets is stored; if the subsets
%   differ, the ESSR of the swap subset is evaluated by Monte Carlo simulation exactly as
%   in evaluate_schemes.m and compared with the stored ESSR of the exhaustive subset
%   (results/extra_num_antennas_N<N>.mat). Saved in results/extra_as_swap_check.mat.

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, Nvals = [4 6 8 10]; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
D = prm.numDrops;  I = numel(Nvals);
res.Nvals = Nvals;
res.fExh = nan(I, D);  res.fSwap = nan(I, D);  res.same = false(I, D);
res.essrExh = nan(I, D);  res.essrSwap = nan(I, D);
for i = 1:I
    N = Nvals(i);
    pr = prm;  pr.N = N;  pr.upaCols = N/2;  pr.asCols = N/2;
    St = load(fullfile(results_dir(), sprintf('extra_num_antennas_N%d.mat', N)));
    k = find(strcmp(St.r.schemes, 'AS'), 1);
    Tc = upa_positions(pr.asRows*pr.asCols, pr.asRows, pr.asCols, 0.5);
    t0 = tic;
    for dI = 1:D
        sc  = gen_scenario(pr, prm.seed + dI);
        scD = design_scenario(pr, sc, prm.seed + dI);
        pe = pr;  pe.asMaxSubsets = inf;                  % force the exhaustive search
        [~, fE, sE] = as_select(scD, pe);
        [sS, fS] = as_swap(scD, pr, Tc, N);
        res.fExh(i, dI) = fE;  res.fSwap(i, dI) = fS;
        res.same(i, dI) = isequal(sort(sE), sort(sS));
        res.essrExh(i, dI) = St.r.essrDrops(1, k, dI);
        if res.same(i, dI)
            res.essrSwap(i, dI) = res.essrExh(i, dI);
        else
            T = Tc(sS, :);
            [p, q] = power_opt(scD, T, pr, 'full');
            [~, ~, res.essrSwap(i, dI)] = mc_rates(sc, T, p, q, pr.S, prm.seed + dI);
        end
    end
    fprintf('N = %d (%.0f s): same subset in %d of %d drops; metric loss mean %.4f%%, max %.4f%%; ESSR exh. %.4f, swap %.4f\n', ...
            N, toc(t0), sum(res.same(i, :)), D, 100*mean(1 - res.fSwap(i, :)./res.fExh(i, :)), ...
            100*max(1 - res.fSwap(i, :)./res.fExh(i, :)), mean(res.essrExh(i, :)), mean(res.essrSwap(i, :)));
end
if isequal(Nvals, [4 6 8 10]), suffix = ''; else, suffix = sprintf('_N%d', Nvals); end   % partial runs
save(fullfile(results_dir(), ['extra_as_swap_check' suffix '.mat']), 'res', 'prm', '-v7');
end
