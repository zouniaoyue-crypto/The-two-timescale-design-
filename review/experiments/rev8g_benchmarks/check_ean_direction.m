% CHECK_EAN_DIRECTION  rev-8g: is the loss of the FPA with Eve-aware AN at weak LoS of Eve caused by
%   the AN direction or by its power allocation? 40 drops, kappa_e = -10 and 20 dB (run with octave-cli).
addpath('/home/user/The-two-timescale-design-/manuscript/ma_secrecy_matlab'); addpath('/home/user/The-two-timescale-design-/manuscript/ma_secrecy_matlab/functions');
prm = default_params();  D = 40;  out = zeros(D, 4);
for kd = [-10 20]
  prm.kappae_dB = kd;
  for dI = 1:D
    sc = gen_scenario(prm, prm.seed + dI);
    T = upa_positions(sc.N, prm.upaRows, prm.upaCols, 0.5);
    [p, q] = power_opt(sc, T, prm, 'full');                     % isotropic-AN allocation
    scE = sc;  scE.anDirG = exp(1j*2*pi/sc.lambda*(T*sc.ae));
    [~, ~, out(dI, 1)] = mc_rates(sc, T, p, q, prm.S, prm.seed + dI);     % FPA, isotropic AN
    [~, ~, out(dI, 2)] = mc_rates(scE, T, p, q, prm.S, prm.seed + dI);    % same (p, q), directional AN
    scO = sc;  scO.anDir = true;  [p2, q2] = power_opt(scO, T, prm, 'full');
    [~, ~, out(dI, 3)] = mc_rates(scE, T, p2, q2, prm.S, prm.seed + dI);  % FPA_ean (Alg. 1 with psi_dir)
    [~, ~, out(dI, 4)] = mc_rates(sc, T, p2, q2, prm.S, prm.seed + dI);   % psi_dir allocation, isotropic AN
  end
  d = out(:, 2) - out(:, 1);
  fprintf('kappa_e = %d dB: iso %.3f | dir, same (p,q) %.3f (diff %.3f, SE %.3f) | FPA_ean %.3f | iso with FPA_ean (p,q) %.3f\n', ...
          kd, mean(out(:, 1)), mean(out(:, 2)), mean(d), std(d)/sqrt(D), mean(out(:, 3)), mean(out(:, 4)));
end
