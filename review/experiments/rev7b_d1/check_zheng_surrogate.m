function check_zheng_surrogate(drops, nPos)
%CHECK_ZHENG_SURROGATE  Validity of the Zheng-type LU surrogate (zheng_lu.m, zheng_lu_eval.m)
%   used by the S1-Zheng variants, at the default setup, the UPA positions, and the (p, q) of
%   Algorithm 1, for every antenna n of the given drops (production seeds):
%   (i)  equality with the LU rate sum_m log2(1 + p_m eta_m) at the expansion point t_l;
%   (ii) gradient against central finite differences of the LU rate;
%   (iii) minorization at nPos uniformly random positions in C = [-A/2, A/2]^2.
prm = default_params();  rng(1);
eqErr = 0;  grErr = 0;  nViol = 0;  nTot = 0;  minGap = inf;
for dI = drops
    sc = gen_scenario(prm, prm.seed + dI);
    T = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
    [p, q] = power_opt(sc, T, prm, 'full');
    for n = 1:sc.N
        Z = zheng_lu(sc, T, n, p);  tl = T(n,:).';
        [~, rb0] = objF_parts_n(sc, T, n, tl, p, q);
        [v0, g0] = zheng_lu_eval(Z, tl);
        eqErr = max(eqErr, abs(v0 - rb0));
        h = 1e-6;  P4 = [tl + [h;0], tl - [h;0], tl + [0;h], tl - [0;h]];
        [~, rb] = objF_parts_n(sc, T, n, P4, p, q);
        gfd = [rb(1) - rb(2); rb(3) - rb(4)]/(2*h);
        grErr = max(grErr, norm(g0 - gfd)/max(norm(gfd), 1e-12));
        Cr = (rand(2, nPos) - 0.5)*prm.A*sc.lambda;
        [~, rbR] = objF_parts_n(sc, T, n, Cr, p, q);
        for k = 1:nPos
            v = zheng_lu_eval(Z, Cr(:,k));
            gap = rbR(k) - v;  nTot = nTot + 1;  minGap = min(minGap, gap);
            if gap < -1e-9, nViol = nViol + 1; end
        end
    end
end
printf('max |surrogate - LU rate| at t_l: %.2e\n', eqErr);
printf('max relative gradient error vs. finite differences: %.2e\n', grErr);
printf('minorization: %d violations at %d random positions (min gap %.3e bps/Hz)\n', nViol, nTot, minGap);
end
