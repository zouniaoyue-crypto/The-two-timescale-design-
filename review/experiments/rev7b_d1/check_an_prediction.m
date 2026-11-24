prm = default_params();  M = prm.M;  N = prm.N;
out = zeros(10, 10);
for dI = 1:10
  for s = 1:2
    pr = prm;  pr.P_dB = 30;  sc = gen_scenario(pr, prm.seed + dI);
    T0 = upa_positions(N, prm.upaRows, prm.upaCols, 0.5);
    if s == 1, [T, p, q] = ao_optimize(sc, T0, pr, 'full'); else, T = T0; [p, q] = power_opt(sc, T, pr, 'full'); end
    a30 = (N-M)*q/sc.P;
    pr2 = pr; pr2.P_dB = 80; sc2 = gen_scenario(pr2, prm.seed + dI); [~, q2] = power_opt(sc2, T, pr2, 'full'); a80 = (N-M)*q2/sc2.P;
    [eta, xi, psi] = rate_coeffs(sc, T);  X = (N-M)*xi(:)/(M*psi);
    al = linspace(1e-4, 1-1e-4, 20001);  g = M*log(al) + M*log(1-al) - sum(log(1 + al.*(X - 1)), 1);
    [~, i] = max(g);  aeq = 1 - al(i);
    Xm = mean(X);  amean = sqrt(Xm)/(1+sqrt(Xm));
    out(dI, (s-1)*5 + (1:5)) = [a30 a80 aeq amean max(X)/min(X)];
  end
end
m = mean(out, 1);
printf('Proposed: AN30 %.3f AN80 %.3f eqUserPowerPred %.3f meanXiPred %.3f (Xi max/min %.1f)\n', m(1:5));
printf('FPA     : AN30 %.3f AN80 %.3f eqUserPowerPred %.3f meanXiPred %.3f (Xi max/min %.1f)\n', m(6:10));
