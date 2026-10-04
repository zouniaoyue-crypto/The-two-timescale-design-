function F = objective_F_n(sc, T, n, C, p, q, plusFlag)
%OBJECTIVE_F_N  Objective F of (P3) as a function of the position of MA n only, evaluated
%   at all candidate positions in the columns of C (2 x K), with the other positions in T
%   fixed (Section IV-C of main.tex, eqs. (41)-(44)). Uses the rank-one structure
%       Phi(t) = Gamma_n + l_n l_n^H,   v(t) = r_n + l_n exp(j 2pi/lambda t_n^T a_e),
%       Omega(t) = Gamma_n^{-1} - u u^H / s,   u = Gamma_n^{-1} l_n,  s = 1 + l_n^H u,
%   so that each candidate costs O(M^2) operations (vectorized over the K candidates).
%   Returns a 1 x K vector; equals objective_F(sc, T with T(n,:) = C(:,k).', p, q, plusFlag).

if nargin < 7, plusFlag = false; end
N = sc.N;  M = sc.M;  k0 = 2*pi/sc.lambda;  p = p(:);
idx = [1:n-1, n+1:N];
Lm = exp(1j*k0*(T(idx,:)*sc.au)) .* repmat(sqrt(sc.kappa.'), N-1, 1);   % L without row n
gm = exp(1j*k0*(T(idx,:)*sc.ae));
Gi = inv(Lm'*Lm + N*eye(M));  Gi = (Gi + Gi')/2;      % Gamma_n^{-1}
r  = Lm'*gm;                                           % r_n
K  = size(C, 2);
l  = repmat(sqrt(sc.kappa), 1, K) .* exp(-1j*k0*(sc.au.'*C));   % l_n(t), M x K
e  = exp(1j*k0*(sc.ae.'*C));                           % exp(j 2pi/lambda t^T a_e), 1 x K
u  = Gi*l;                                             % M x K
s  = 1 + real(sum(conj(l).*u, 1));                     % 1 x K
S  = repmat(s, M, 1);
u2 = abs(u).^2;  nu2 = sum(u2, 1);
om = repmat(real(diag(Gi)), 1, K) - u2./S;                              % omega_m
o2 = repmat(real(sum(abs(Gi).^2, 1)).', 1, K) - 2*real((Gi*u).*conj(u))./S ...
     + u2.*repmat(nu2, M, 1)./S.^2;                                      % [Omega^2]_mm
tr = real(trace(Gi)) - nu2./s;                                           % tr(Omega)
Gr = Gi*r;
uv = (u'*r).' + (s - 1).*e;                                              % u^H v
w  = repmat(Gr, 1, K) + u.*repmat(e, M, 1) - u.*repmat(uv./s, M, 1);     % Omega v
vOv = real(r'*Gr) + 2*real(e.*(r'*u)) + (s - 1) - abs(uv).^2./s;         % v^H Omega v
c   = (abs(w).^2 + N*o2)./om;                                            % c_m
d   = (N - vOv).*(N - M)./(N - M + N*tr);                                % d
eta = repmat(sc.zeta*(N - M), 1, K)./(N*om);
xi  = sc.kappa_e*c + 1;
psi = sc.kappa_e*d + N - M;
Rb  = log2(1 + eta.*repmat(p, 1, K));
Re  = log2(1 + xi.*repmat(p, 1, K)./repmat(q*psi + sc.sbe, M, 1));
if plusFlag
    F = sum(max(Rb - Re, 0), 1);
else
    F = sum(Rb - Re, 1);
end
end
