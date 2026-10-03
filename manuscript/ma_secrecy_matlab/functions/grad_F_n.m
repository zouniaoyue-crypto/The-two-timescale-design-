function grad = grad_F_n(sc, T, p, q, n, act)
%GRAD_F_N  Analytical gradient of F(t,p,q) w.r.t. t_n = [x_n; y_n]
%   (eqs. (41)-(48) and Appendix B, eqs. (58)-(64), of main.tex).
%
%   l_n     = K^{1/2} [exp(-j 2pi/lambda t_n^T a_1); ...; exp(-j 2pi/lambda t_n^T a_M)]
%   dl_n/du = -j 2pi/lambda D_u l_n,                 u in {x_n, y_n}
%   dv/du   =  j 2pi/lambda (a_{e,u} I - D_u) l_n exp(j 2pi/lambda t_n^T a_e)
%   dOm/du  = -Om (dl_n l_n^H + l_n dl_n^H) Om
%   act (optional, M x 1 logical): only the terms of the LUs with act(m) = true are
%   differentiated (gradient of the minorizer sum_{m in act} f_m of sum_m [f_m]^+).

N = sc.N;  M = sc.M;  ke = sc.kappa_e;  k0 = 2*pi/sc.lambda;
p = p(:);
if nargin < 6 || isempty(act), act = true(M, 1); end
w8 = double(act(:));
g   = geo_quantities(sc, T);
eta = sc.zeta * (N - M) ./ (N * g.om);
Om  = g.Om;  om = g.om;  tr = g.tr;  w = g.w;  v = g.v;  c = g.c;  vOv = g.vOv;
chi = p .* (ke*c + 1);                    % chi_m = xi_m p_m
Ups = q*(ke*g.d + N - M) + sc.sbe;        % Upsilon = q psi + sbar_e^2

tn  = T(n,:).';
ln  = sqrt(sc.kappa) .* exp(-1j*k0*(sc.au.'*tn));   % M x 1
eph = exp(1j*k0*(tn.'*sc.ae));
Oln = Om*ln;
grad = zeros(2,1);
for k = 1:2
    Du   = sc.au(k,:).';                            % [a_{1,u}; ...; a_{M,u}]
    dln  = -1j*k0*(Du .* ln);
    dv   = 1j*k0*((sc.ae(k) - Du) .* ln) * eph;
    Odln = Om*dln;
    dOm  = -(Odln*Oln' + Oln*Odln');
    dom  = real(diag(dOm));                          % d omega_m
    do2  = 2*real(diag(Om*dOm));                     % d [Omega^2]_mm
    dtr  = real(trace(dOm));                         % d tr(Omega)
    deta = -eta .* dom ./ om;                        % d eta_m
    dw   = dOm*v + Om*dv;                            % d (Omega v)
    dc   = (2*real(conj(w).*dw) + N*do2 - c.*dom) ./ om;
    dvOv = 2*real(w'*dv) + real(v'*dOm*v);
    dd   = -g.gam*(dvOv + N*(N - vOv)*dtr/(N - M + N*tr));
    grad(k) = sum(w8.*(p.*deta./(1 + eta.*p) - ke*p.*dc./(chi + Ups) ...
                       + ke*q*chi*dd./(Ups*(chi + Ups)))) / log(2);
end
end
