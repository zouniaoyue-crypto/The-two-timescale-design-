function sc = gen_scenario(prm, seed)
%GEN_SCENARIO  Draws the LoS directions of the LUs and Eve and collects all
%   statistical CSI in the struct sc (Section II-A of main.tex).
%
%   LU m:  theta_m, phi_m ~ U[-angMax, angMax]
%   Eve :  theta_e = theta_1 + Delta*cos(vartheta), phi_e = phi_1 + Delta*sin(vartheta),
%          vartheta ~ U[0, 2*pi), i.e., Eve is angularly close to LU 1.

rng(seed);
M = prm.M;
th = (2*rand(M,1) - 1) * prm.angMax;
ph = (2*rand(M,1) - 1) * prm.angMax;
vt = 2*pi*rand;
th_e = th(1) + prm.Delta * cos(vt);
ph_e = ph(1) + prm.Delta * sin(vt);
sc = build_scenario(prm, th, ph, th_e, ph_e);
end
