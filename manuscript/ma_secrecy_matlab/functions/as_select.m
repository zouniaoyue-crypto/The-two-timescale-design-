function [T, best, sel] = as_select(sc, prm, Tc)
%AS_SELECT  Benchmark "antenna selection (AS)" with statistical CSI: N of the 2N
%   antennas of a lambda/2-spaced UPA (prm.asRows x prm.asCols, e.g., 4 x 4 for N = 8)
%   are selected to maximize the approximate ESSR (P3), where every subset is ranked using
%   secrecy water-filling at prm.asGrid uniformly spaced q values (21 by default, see
%   as_metric.m). Only the selected subset is refined by power_opt.m (Algorithm 1).
%   The optional Tc (K x 2) overrides the candidate positions (e.g., a UPA spanning C).
%
%   Search: exhaustive over all nchoosek(K, N) subsets if their number does not exceed
%   prm.asMaxSubsets (2e5 by default, i.e., N <= 10 for K = 2N); otherwise, a swap search
%   (as_swap.m) initialized by greedy removal, which is validated against the exhaustive
%   search for N <= 10 in extra_as_swap_check.m.
%   Outputs: T (N x 2) selected positions, best (approximate ESSR of the selected subset),
%   sel (1 x N indices of the selected candidates).

N = sc.N;
if nargin < 3                                    % default candidates: lambda/2 UPA
    Tc = upa_positions(prm.asRows*prm.asCols, prm.asRows, prm.asCols, 0.5);
end
K = size(Tc, 1);
if isfield(prm, 'asMaxSubsets'), Smax = prm.asMaxSubsets; else, Smax = 2e5; end
if nchoosek(K, N) <= Smax                        % exhaustive search
    idx = nchoosek(1:K, N);                      % S x N subsets
    f = as_metric(sc, prm, Tc, idx);
    [best, s] = max(f);
    sel = idx(s, :);
else                                             % swap search
    [sel, best] = as_swap(sc, prm, Tc, N);
end
T = Tc(sel, :);
end
