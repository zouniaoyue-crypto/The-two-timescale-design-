function r = accuracy_point(pr, D, S, seed0)
%ACCURACY_POINT  Accuracy of the closed-form rates at the designs of the proposed scheme
%   (Fig. 3 of main.tex) for one parameter setting pr, averaged over the drops 1, ..., D
%   (the same drops as in Figs. 5-7). For each drop, the proposed design (t, p, q) is
%   obtained by Algorithm 2 ('MA_full' in evaluate_schemes.m), and its rates are computed
%   (i) by Monte Carlo simulation of the exact ZF precoding and null-space AN with S channel
%   realizations and (ii) by the closed forms of Lemma 1 and Proposition 1.
%   r.lu  = [Monte Carlo, closed form] of the ergodic sum rate of the LUs, sum_m Rbar_m
%   r.eve = [Monte Carlo, closed form] of the ergodic wiretap sum rate of Eve, sum_m Rbar_{e,m}
%   r.essr = [Monte Carlo ESSR, approximate ESSR (main.tex label eq:esrapprox)]
if nargin < 4, seed0 = pr.seed; end
pr.S = S;
r.lu = [0 0];  r.eve = [0 0];  r.essr = [0 0];
for dI = 1:D
    sc  = gen_scenario(pr, seed0 + dI);
    out = evaluate_schemes(sc, pr, {'MA_full'}, seed0 + dI);   % designs as in Figs. 5-7
    d   = out.MA_full;
    [Rba, Rea] = analytic_rates(sc, d.T, d.p, d.q);
    r.lu   = r.lu   + [sum(d.Rb), sum(Rba)]/D;
    r.eve  = r.eve  + [sum(d.Re), sum(Rea)]/D;
    r.essr = r.essr + [d.essr, sum(max(Rba - Rea, 0))]/D;
end
end
