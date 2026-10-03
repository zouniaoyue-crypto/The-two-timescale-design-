function [Acon, bcon] = lin_constraints(sc, T, n)
%LIN_CONSTRAINTS  Linear constraints of subproblem (P3.2.n) in main.tex:
%   box:       -A/2 <= x_n, y_n <= A/2
%   distance:  (t_n^(l) - t_i)^T t_n >= (t_n^(l) - t_i)^T t_n^(l) + (Dmin^2 - ||t_n^(l) - t_i||^2)/2,
%              i ~= n   (first-order inner approximation of ||t_n - t_i|| >= Dmin, eq. (51)).
%   Returned in the form Acon * t_n >= bcon.

N = sc.N;  A2 = sc.A/2;
tn = T(n,:).';
idx = [1:n-1, n+1:N];
Dl = repmat(tn.', N-1, 1) - T(idx,:);                 % rows: (t_n^(l) - t_i)^T
Acon = [1 0; -1 0; 0 1; 0 -1; Dl];
bcon = [-A2; -A2; -A2; -A2; Dl*tn + (sc.Dmin^2 - sum(Dl.^2, 2))/2];
end
