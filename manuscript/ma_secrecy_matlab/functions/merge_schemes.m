function r = merge_schemes(r, rn)
%MERGE_SCHEMES  Adds (or replaces) the schemes of rn in r, where r and rn are results of
%   sweep_schemes.m for the same parameter values and drops (fields schemes, essr,
%   essr_tin, anfrac, F, anpred, essrDrops; missing fields are skipped).
f2 = {'essr', 'essr_tin', 'anfrac', 'F', 'anpred'};
for k = 1:numel(rn.schemes)
    j = find(strcmp(r.schemes, rn.schemes{k}), 1);
    if isempty(j), j = numel(r.schemes) + 1;  r.schemes{j} = rn.schemes{k}; end
    for f = f2
        if isfield(rn, f{1}) && isfield(r, f{1}), r.(f{1})(:, j) = rn.(f{1})(:, k); end
    end
    r.essrDrops(:, j, :) = rn.essrDrops(:, k, :);
end
end
