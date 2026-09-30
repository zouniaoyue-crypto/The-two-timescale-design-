function g = geo_quantities(sc, T)
%GEO_QUANTITIES  LoS-dependent quantities of main.tex for antenna positions T (N x 2).
%
%   L     = Hbar K^{1/2}                         (weighted LoS matrix, N x M)
%   Phi   = L^H L + N I_M,   Omega = Phi^{-1}     (eq. (16))
%   v     = L^H gbar                              (Proposition 1)
%   omega_m = [Omega]_{mm}                        (LU decorrelation, Lemma 1, eq. (17))
%   c_m   = (|[Omega v]_m|^2 + N [Omega^2]_{mm}) / omega_m   (leakage, eq. (24))
%   d     = (N - v^H Omega v)(1 - tr(Omega))                  (AN at Eve, eq. (25))

N = sc.N;  M = sc.M;
k0 = 2*pi/sc.lambda;
Hbar = exp(1j*k0*(T*sc.au));                 % N x M, [Hbar]_{n,m} = exp(j 2pi/lambda t_n^T a_m)
gbar = exp(1j*k0*(T*sc.ae));                 % N x 1
L    = Hbar .* sqrt(sc.kappa.');              % N x M
Om   = inv(L'*L + N*eye(M));
Om   = (Om + Om')/2;                          % enforce Hermitian symmetry
v    = L'*gbar;                               % M x 1
w    = Om*v;
g.Om  = Om;
g.om  = real(diag(Om));                       % omega_m
g.o2  = real(sum(abs(Om).^2, 1)).';           % [Omega^2]_{mm}
g.tr  = sum(g.om);                            % tr(Omega)
g.v   = v;
g.w   = w;                                    % Omega v
g.vOv = real(v'*w);                           % v^H Omega v
g.c   = (abs(w).^2 + N*g.o2) ./ g.om;         % c_m(t)
g.d   = (N - g.vOv) * (1 - g.tr);             % d(t)
end
