function p = secrecy_wf(eta, th, PI, nBisect)
%SECRECY_WF  Secrecy water-filling (Proposition 3, eq. (38), of main.tex), vectorized over
%   Q candidate AN powers:
%       max_{p >= 0} sum_m log2(1 + eta_m p_m) - log2(1 + th_m p_m)
%       s.t. sum_m p_m <= PI
%   eta : M x 1 or M x Q,  th : M x Q (th_m = eta_{e,m}(q)),  PI : 1 x Q or scalar  ->  p : M x Q
%   (the Q columns are independent problems, e.g., different q or different antenna subsets)
%
%   p_m(nu) = [ 2 (rho_m - 1) / ( sqrt((eta_m - th_m)^2 + 4 eta_m th_m rho_m) + eta_m + th_m ) ]^+,
%   rho_m = (eta_m - th_m) / (nu ln 2), for LUs with eta_m > th_m; p_m = 0 otherwise.
%   The water level nu is found by bisection such that sum_m p_m(nu) = PI.

if nargin < 4, nBisect = 60; end
[M, Q] = size(th);
if size(eta, 2) == 1, eta = repmat(eta(:), 1, Q); end
if numel(PI) == 1, PI = repmat(PI, 1, Q); end
PI  = reshape(PI, 1, Q);
act = (eta > th) & repmat(PI > 0, M, 1);
gap = eta - th;
lo  = zeros(1, Q);
hi  = max(gap .* act, [], 1) / log(2);        % p_m(hi) = 0 for all m
for it = 1:nBisect
    mid = (lo + hi)/2;
    s = sum(pnu(mid), 1);
    up = s > PI;                              % too much power -> increase nu
    lo(up) = mid(up);
    hi(~up) = mid(~up);
end
p = pnu(hi);                                  % feasible: sum_m p_m <= PI

    function pp = pnu(nu)
        rho = gap ./ (repmat(nu, M, 1) * log(2));
        D   = gap.^2 + 4*eta.*th.*rho;
        pp  = 2*(rho - 1) ./ (sqrt(max(D, 0)) + eta + th);
        pp(~act | ~(pp > 0)) = 0;
    end
end
