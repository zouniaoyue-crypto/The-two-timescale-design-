function [T, p, q, hist] = ao_optimize(sc, T0, prm, mode)
%AO_OPTIMIZE  Two-timescale AO algorithm (Algorithm 2 of main.tex).
%   mode = 'full' (proposed), 'noan' (q = 0) or 'epa' (equal user power, alpha searched);
%   see power_opt.m. Returns the optimized positions T (N x 2), powers p (M x 1),
%   AN power per dimension q, and the objective history hist.

if nargin < 4, mode = 'full'; end
T = T0;
[p, q] = power_opt(sc, T, prm, mode);
hist = objective_F(sc, T, p, q);
deltaLast = [];
for it = 1:prm.aoMaxIter
    [T, deltaLast] = position_sweep(sc, T, p, q, prm, deltaLast);   % positions (MM)
    [p2, q2] = power_opt(sc, T, prm, mode);                          % power allocation
    if objective_F(sc, T, p2, q2) >= objective_F(sc, T, p, q)
        p = p2;  q = q2;
    end
    hist(end+1) = objective_F(sc, T, p, q); %#ok<AGROW>
    if hist(end) - hist(end-1) < prm.aoTol*max(1, abs(hist(end)))
        break;
    end
end
end
