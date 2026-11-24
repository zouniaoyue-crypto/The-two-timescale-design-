function [LF, LE, LU] = hess_sup(sc, T, n, p, q, Cg, h)
%HESS_SUP  Oracle: largest spectral norm of the Hessian (central finite differences, step h)
%   of F, of the Eve part -sum_m Re_m, and of the LU part sum_m Rb_m, as functions of t_n,
%   over the sample points Cg (2 x K). Used as the most favorable "closed-form" curvature:
%   any analytical bound must be at least as large.
K = size(Cg, 2);
off = [0 0; h 0; -h 0; 0 h; 0 -h; h h; h -h; -h h; -h -h].';
P = zeros(2, 9*K);
for j = 1:9, P(:, (j-1)*K + (1:K)) = Cg + repmat(off(:,j), 1, K); end
[F, sRb, sRe] = objF_parts_n(sc, T, n, P, p, q, false);
vals = {F, -sRe, sRb};  L = zeros(1,3);
for v = 1:3
    f = reshape(vals{v}, K, 9);
    hxx = (f(:,2) - 2*f(:,1) + f(:,3))/h^2;
    hyy = (f(:,4) - 2*f(:,1) + f(:,5))/h^2;
    hxy = (f(:,6) - f(:,7) - f(:,8) + f(:,9))/(4*h^2);
    lam = (hxx + hyy)/2 + sqrt(((hxx - hyy)/2).^2 + hxy.^2);    % largest eigenvalue
    lmn = (hxx + hyy)/2 - sqrt(((hxx - hyy)/2).^2 + hxy.^2);    % smallest eigenvalue
    L(v) = max(max(abs(lam)), max(abs(lmn)));
end
LF = L(1);  LE = L(2);  LU = L(3);
end
