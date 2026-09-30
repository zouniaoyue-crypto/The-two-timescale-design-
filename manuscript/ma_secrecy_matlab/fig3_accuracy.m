function res = fig3_accuracy(prm)
%FIG3_ACCURACY  Fig. 3 of main.tex: accuracy of the closed-form ergodic rates.
%   Ergodic sum rates of the LUs and of Eve under ZF precoding and null-space AN with
%   the power split p_m = alpha P_tot/M, q = (1-alpha) P_tot/(N-M), alpha = 0.5, for
%   (i) the compact lambda/2 UPA and (ii) random feasible MA positions in C,
%   averaged over prm.numDrops random drops.
%     Fig. 3(a): versus P_tot/sigma^2 (kappa = kappa_e = 10 dB)
%     Fig. 3(b): versus kappa = kappa_e (P_tot/sigma^2 = 20 dB)
%   Markers: Monte Carlo; lines: closed forms (LUs: Lemma 1; Eve: Proposition 1).

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
alpha = 0.5;
res.Pvec = 0:5:30;
res.Kvec = -5:5:20;
D = prm.numDrops;
S = max(prm.S, 10000);
% dims: (x-value, position type [UPA, random], quantity [LU-MC, LU-approx, Eve-MC, Eve-approx])
res.vsP = zeros(numel(res.Pvec), 2, 4);
res.vsK = zeros(numel(res.Kvec), 2, 4);
for sweep = 1:2
    if sweep == 1, xs = res.Pvec; else, xs = res.Kvec; end
    for ix = 1:numel(xs)
        pr = prm;
        if sweep == 1, pr.P_dB = xs(ix); else, pr.kappa_dB = xs(ix); pr.kappae_dB = xs(ix); end
        acc = zeros(2, 4);
        for dI = 1:D
            sc = gen_scenario(pr, prm.seed + dI);
            rng(prm.seed + 100*dI);
            Ts = {upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5), random_positions(sc)};
            p = alpha*sc.P/sc.M*ones(sc.M, 1);
            q = (1 - alpha)*sc.P/(sc.N - sc.M);
            for k = 1:2
                [Rb, Re] = mc_rates(sc, Ts{k}, p, q, S, prm.seed + dI);
                [Rba, Rea] = analytic_rates(sc, Ts{k}, p, q);
                acc(k,:) = acc(k,:) + [sum(Rb), sum(Rba), sum(Re), sum(Rea)]/D;
            end
        end
        if sweep == 1, res.vsP(ix,:,:) = acc; else, res.vsK(ix,:,:) = acc; end
        fprintf('fig3: sweep %d, point %d/%d done\n', sweep, ix, numel(xs));
    end
end
save(fullfile(results_dir(), 'fig3_accuracy.mat'), 'res', 'prm', '-v7');
plot_fig3(res);
end
