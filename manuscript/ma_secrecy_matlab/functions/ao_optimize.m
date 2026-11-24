function [T, p, q, hist, iters] = ao_optimize(sc, T0, prm, mode)
%AO_OPTIMIZE  Two-timescale AO algorithm (Algorithm 2 of main.tex).
%   mode = 'full' (proposed), 'noan' (q = 0), 'epa' (equal user power, alpha searched),
%   'fix' (equal user power, fixed alpha) or 'eq' (p_m = q = P_tot/N); see power_opt.m.
%   Returns the optimized positions T (N x 2), powers p (M x 1), AN power per dimension q,
%   and the objective history hist. The optional output iters(k) holds the iterate
%   (T, p, q) after k - 1 AO iterations (iters(1): initialization), e.g., for the Monte
%   Carlo ESSR along the iterations in Fig. 4.

if nargin < 4, mode = 'full'; end
% With equal user power ('epa', 'fix', 'eq'), an LU cannot be switched off, so that the
% operator [.]^+ cannot be dropped (Section III-E) and the objective is the sum of [.]^+ terms.
plus = any(strcmp(mode, {'epa', 'fix', 'eq'}));
T = T0;
[p, q] = power_opt(sc, T, prm, mode);
hist = objective_F(sc, T, p, q, plus);
keep = nargout > 4;
if keep, iters = struct('T', T, 'p', p, 'q', q); end
deltaLast = [];
for it = 1:prm.aoMaxIter
    [T, deltaLast] = position_sweep(sc, T, p, q, prm, deltaLast, plus);   % positions (search + MM)
    [p2, q2] = power_opt(sc, T, prm, mode);                                % power allocation
    if objective_F(sc, T, p2, q2, plus) >= objective_F(sc, T, p, q, plus)
        p = p2;  q = q2;
    end
    hist(end+1) = objective_F(sc, T, p, q, plus); %#ok<AGROW>
    if keep, iters(end+1) = struct('T', T, 'p', p, 'q', q); end %#ok<AGROW>
    if hist(end) - hist(end-1) < prm.aoTol*max(1, abs(hist(end)))
        break;
    end
end
end
