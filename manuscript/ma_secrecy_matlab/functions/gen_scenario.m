function sc = gen_scenario(prm, seed)
%GEN_SCENARIO  Draws the LoS directions of the LUs and Eve and collects all
%   statistical CSI in the struct sc (Section II-A of main.tex).
%
%   LU m:  theta_m, phi_m ~ U[-angMax, angMax]
%   Eve :  theta_e = theta_1 + Delta*cos(phit), phi_e = phi_1 + Delta*sin(phit),
%          phit ~ U[0, 2*pi), i.e., Eve is at the angular separation Delta from LU 1;
%          for Delta = Inf, theta_e, phi_e ~ U[-angMax, angMax] independently of the LUs.

rng(seed);
M = prm.M;
th = (2*rand(M,1) - 1) * prm.angMax;
ph = (2*rand(M,1) - 1) * prm.angMax;
phit = 2*pi*rand;
if isfinite(prm.Delta)
    th_e = th(1) + prm.Delta * cos(phit);
    ph_e = ph(1) + prm.Delta * sin(phit);
else                                          % Eve independent of the LUs
    th_e = (2*rand - 1) * prm.angMax;
    ph_e = (2*rand - 1) * prm.angMax;
end
sc = build_scenario(prm, th, ph, th_e, ph_e);
end
