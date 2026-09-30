function sc = gen_scenario(prm, seed)
%GEN_SCENARIO  Draws the LoS directions of the LUs and Eve and collects all
%   statistical CSI in the struct sc (Section II-A of main.tex).
%
%   LU m:  theta_m, phi_m ~ U[-angMax, angMax]
%   Eve :  theta_e = theta_1 + Delta*cos(phit), phi_e = phi_1 + Delta*sin(phit),
%          phit ~ U[0, 2*pi), i.e., Eve is angularly close to LU 1.

rng(seed);
M = prm.M;
th = (2*rand(M,1) - 1) * prm.angMax;
ph = (2*rand(M,1) - 1) * prm.angMax;
phit = 2*pi*rand;
th_e = th(1) + prm.Delta * cos(phit);
ph_e = ph(1) + prm.Delta * sin(phit);
sc = build_scenario(prm, th, ph, th_e, ph_e);
end
