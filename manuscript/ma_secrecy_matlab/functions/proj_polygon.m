function t = proj_polygon(z, Acon, bcon)
%PROJ_POLYGON  Exact solution of the two-dimensional convex QP
%       min_t ||t - z||^2   s.t.  Acon * t >= bcon,
%   i.e., the Euclidean projection of z onto a (nonempty) convex polygon.
%   If z is infeasible, the minimizer lies on an edge (projection of z onto a
%   constraint line) or at a vertex (intersection of two constraint lines); all
%   such candidates are enumerated and the closest feasible one is returned.

tol = 1e-10;
z = z(:);
if all(Acon*z >= bcon - tol)
    t = z;  return;
end
K = size(Acon, 1);
% (i) projections of z onto every constraint line
nrm2 = sum(Acon.^2, 2);
C1 = repmat(z, 1, K) + Acon.' .* repmat(((bcon - Acon*z)./nrm2).', 2, 1);   % 2 x K
% (ii) intersections of every pair of constraint lines
[I, J] = find(triu(true(K), 1));
a11 = Acon(I,1); a12 = Acon(I,2); a21 = Acon(J,1); a22 = Acon(J,2);
det2 = a11.*a22 - a12.*a21;
ok = abs(det2) > 1e-12;
xi = ( a22.*bcon(I) - a12.*bcon(J)) ./ det2;
yi = (-a21.*bcon(I) + a11.*bcon(J)) ./ det2;
C2 = [xi(ok).'; yi(ok).'];
C = [C1, C2];
feas = all(Acon*C >= repmat(bcon, 1, size(C,2)) - tol, 1);
C = C(:, feas);
[~, k] = min(sum((C - repmat(z, 1, size(C,2))).^2, 1));
t = C(:, k);
end
