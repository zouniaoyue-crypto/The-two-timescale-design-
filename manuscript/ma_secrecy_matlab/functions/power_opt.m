function [p, q, Gbest] = power_opt(sc, T, prm, mode)
%POWER_OPT  Long-term power allocation for given antenna positions (Algorithm 1).
%   mode = 'full'  : {p_m} by secrecy water-filling, q by one-dimensional search (proposed)
%   mode = 'noan'  : q = 0 (no AN), {p_m} by secrecy water-filling
%   mode = 'epa'   : equal power p_m = alpha P/M, q = (1-alpha) P/(N-M), alpha by 1-D search
%
%   The one-dimensional search uses a coarse grid followed by a fine grid around the
%   best coarse point (both with prm.nGrid points).

if nargin < 4, mode = 'full'; end
[eta, xi, psi] = rate_coeffs(sc, T);
N = sc.N;  M = sc.M;  P = sc.P;
switch mode
    case 'full'
        qmax = P/(N - M);
        G = @(qv) Gfull(qv);
        [q, Gbest] = search1d(G, 0, qmax, prm.nGrid);
        [~, p] = Gfull(q);
    case 'noan'
        q = 0;
        p = secrecy_wf(eta, xi/sc.sbe, P, prm.nBisect);
        Gbest = sum(log2(1 + eta.*p) - log2(1 + xi.*p/sc.sbe));
    case 'epa'
        G = @(av) Gepa(av);
        [alpha, Gbest] = search1d(G, 0, 1, prm.nGrid);
        p = alpha*P/M*ones(M,1);
        q = (1 - alpha)*P/(N - M);
    otherwise
        error('unknown mode');
end

    function [val, pp] = Gfull(qv)          % G(q) = optimal objective for given q (vectorized)
        qv = reshape(qv, 1, []);
        th = xi ./ (qv*psi + sc.sbe);        % M x Q, vartheta_m(q)
        pp = secrecy_wf(eta, th, P - (N - M)*qv, prm.nBisect);
        val = sum(log2(1 + repmat(eta,1,numel(qv)).*pp) - log2(1 + th.*pp), 1);
    end
    function val = Gepa(av)                  % objective of the equal-power baseline (vectorized)
        av = reshape(av, 1, []);
        pp = repmat(av*P/M, M, 1);
        qq = (1 - av)*P/(N - M);
        val = sum(log2(1 + repmat(eta,1,numel(av)).*pp) ...
                  - log2(1 + xi.*pp ./ repmat(qq*psi + sc.sbe, M, 1)), 1);
    end
end

function [xbest, fbest] = search1d(f, a, b, n)
% coarse grid on [a, b] followed by a fine grid around the best coarse point
x = linspace(a, b, n);
[~, i] = max(f(x));
lo = x(max(i-1, 1));  hi = x(min(i+1, n));
x2 = linspace(lo, hi, n);
[fbest, j] = max(f(x2));
xbest = x2(j);
end
