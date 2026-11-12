function [sel, f] = as_swap(sc, prm, Tc, N)
%AS_SWAP  Low-complexity subset search of the AS benchmark for large N, where the
%   exhaustive search over nchoosek(K, N) subsets is prohibitive. The metric is the same
%   approximate ESSR as in the exhaustive search (as_metric.m).
%   Initializations (prm.asSwapStarts, 5 by default):
%     - greedy removal: starting from all K candidates, the candidate whose removal yields
%       the largest metric is removed until N candidates remain;
%     - prm.asSwapStarts - 1 random subsets (fixed seed; the global random number state is
%       restored on exit, so the Monte Carlo evaluation is not affected).
%   Swap search from each initialization: among all N (K - N) exchanges of one selected and
%   one unselected candidate, the best one is applied while it increases the metric (at
%   most prm.asSwapMaxIter exchanges, 100 by default). The best local solution is returned.
%   Outputs: sel (1 x N sorted candidate indices) and its metric f.

K = size(Tc, 1);
if isfield(prm, 'asSwapStarts'), nStart = prm.asSwapStarts; else, nStart = 5; end
if isfield(prm, 'asSwapMaxIter'), maxIt = prm.asSwapMaxIter; else, maxIt = 100; end
% initializations
s0 = 1:K;
while numel(s0) > N                                % greedy removal
    n = numel(s0);
    cand = zeros(n, n - 1);
    for i = 1:n
        cand(i, :) = s0([1:i-1, i+1:n]);
    end
    [~, s] = max(as_metric(sc, prm, Tc, cand));
    s0 = cand(s, :);
end
starts = {s0};
st = rng;  rng(4099);
for r = 2:nStart
    starts{r} = sort(randperm(K, N)); %#ok<AGROW>
end
rng(st);
% swap search from each initialization
f = -inf;  sel = s0;
for r = 1:nStart
    [sr, fr] = swap_search(sc, prm, Tc, N, K, starts{r}, maxIt);
    if fr > f, f = fr;  sel = sr; end
end
sel = sort(sel);
end

function [sel, f] = swap_search(sc, prm, Tc, N, K, sel, maxIt)
f = as_metric(sc, prm, Tc, sel);
for it = 1:maxIt
    out = setdiff(1:K, sel);
    [I, J] = ndgrid(1:N, 1:numel(out));
    cand = repmat(sel, numel(I), 1);
    cand(sub2ind(size(cand), (1:numel(I)).', I(:))) = out(J(:));
    [fm, s] = max(as_metric(sc, prm, Tc, cand));
    if fm <= f + 1e-12*max(1, abs(f)), break; end
    sel = cand(s, :);  f = fm;
end
end
