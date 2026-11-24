function Z = zheng_lu(sc, T, n, p)
%ZHENG_LU  Zheng et al. (arXiv:2410.05912, Sec. IV-C, Lemma 1 and (59)-(63)) applied to the
%   LU terms log2(1 + p_m eta_m(t_n)) of our objective, with the other positions fixed.
%   eta_m = C_m l^H Y l / l^H X_m l,  C_m = zeta_m (N-M)/N, l = l_n(t_n), ||l||^2 = kappa_sum.
%   Lemma 1:  l^H Y l / l^H X_m l >= chi_m + Re{w_m^H l(t)}       (tight at t_l)
%   (59)-(63): Re{w_m^H l(t)} >= h_m(t_l) + gh_m^T (t - t_l) - xi_m/2 ||t - t_l||^2,
%              xi_m = k^2 lambda_max(Xi_m)  (closed-form curvature of the cosine sum).
N = sc.N;  M = sc.M;  k0 = 2*pi/sc.lambda;  p = p(:);
idx = [1:n-1, n+1:N];
Lm = exp(1j*k0*(T(idx,:)*sc.au)) .* repmat(sqrt(sc.kappa(:).'), N-1, 1);
Gi = inv(Lm'*Lm + N*eye(M));  Gi = (Gi + Gi')/2;
ks = sum(sc.kappa);
Y  = Gi + eye(M)/ks;
tl = T(n,:).';
l  = sqrt(sc.kappa(:)) .* exp(-1j*k0*(sc.au.'*tl));
dlx = -1j*k0*sc.au(1,:).' .* l;   dly = -1j*k0*sc.au(2,:).' .* l;
Z.tl = tl;  Z.act = find(p > 0);  Z.p = p;
Z.C = sc.zeta(:)*(N - M)/N;
Z.chi = zeros(M,1);  Z.h0 = zeros(M,1);  Z.g = zeros(2,M);  Z.xi = zeros(M,1);  Z.f0 = zeros(M,1);
for m = 1:M
    X = Gi(m,m)*Y - Gi(:,m)*Gi(m,:);  X = (X + X')/2;
    lam = max(real(eig(X)));
    r = real(l'*X*l);  y = real(l'*Y*l);
    w = 2*Y*l/r - 2*(y/r^2)*(X - lam*eye(M))*l;
    Z.chi(m) = -(y/r^2)*(2*lam*ks - r);
    Z.h0(m)  = real(w'*l);
    Z.g(:,m) = [real(w'*dlx); real(w'*dly)];
    a = abs(w) .* sqrt(sc.kappa(:));
    Xi = [sum(a.*sc.au(1,:).'.^2), sum(a.*abs(sc.au(1,:).'.*sc.au(2,:).')); ...
          sum(a.*abs(sc.au(1,:).'.*sc.au(2,:).')), sum(a.*sc.au(2,:).'.^2)];
    Z.xi(m) = k0^2*max(eig(Xi));
    Z.f0(m) = y/r;                                   % = 1/omega_m at t_l
end
end
