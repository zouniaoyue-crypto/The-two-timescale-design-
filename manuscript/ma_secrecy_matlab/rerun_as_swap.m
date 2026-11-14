function res = rerun_as_swap(which, idx)
%RERUN_AS_SWAP  Re-runs only the AS benchmark with the swap search (as_swap.m) for the
%   values of a stored sweep and replaces the AS columns of the stored results, so that
%   the AS benchmark uses the same subset search in all figures of main.tex (Section V-A).
%   The other schemes, the drops, and the Monte Carlo channel samples are unchanged
%   (same seeds, which depend only on the drop index), so the comparisons remain paired.
%   which : 'fig5_snr' (Fig. 5), 'fig6_region' (Fig. 6(a)), 'extra_angle_offset'
%           (Section V-F, M = 3), or 'extra_single_user' (Fig. 7, M = 1).
%   idx   : optional indices of the values to run in this call (default: all values).
%   The AS results of each value are saved in results/<which>_AS_swap_<i>.mat as soon as
%   they are available, so that an interrupted run resumes where it stopped and the values
%   can be split over parallel sessions, e.g., rerun_as_swap('fig5_snr', 1:4) and
%   rerun_as_swap('fig5_snr', 5:7). Once all values are available, the AS column of
%   results/<which>.mat is replaced (the per-value files can then be deleted).
%   For Fig. 6(b), use extra_num_antennas([], [4 6 8 10], {'AS'}).

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
switch which
    case 'fig5_snr',                                   field = 'P_dB';
    case 'fig6_region',                                field = 'A';
    case {'extra_angle_offset', 'extra_single_user'},  field = 'Delta';
    otherwise, error('rerun_as_swap: unknown results file %s', which);
end
f = fullfile(results_dir(), [which '.mat']);
S = load(f);
prm = S.prm;  d = default_params();
prm.asMaxSubsets = 0;                              % swap search for every N
prm.asSwapStarts = d.asSwapStarts;  prm.asSwapMaxIter = d.asSwapMaxIter;
vals = S.res.values;
part = @(i) fullfile(results_dir(), sprintf('%s_AS_swap_%d.mat', which, i));
if nargin < 2 || isempty(idx), idx = 1:numel(vals); end
for i = idx(:).'
    if exist(part(i), 'file'), continue; end       % done in an earlier or parallel run
    r = sweep_schemes(prm, field, vals(i), {'AS'});
    save(part(i), 'r', '-v7');
end
res = [];
for i = 1:numel(vals)
    if ~exist(part(i), 'file')
        fprintf('%s: value %g not available yet, results not merged.\n', which, vals(i));
        return;
    end
end
res = S.res;
j = find(strcmp(res.schemes, 'AS'), 1);
assert(~isempty(j), 'rerun_as_swap: no AS column in %s', which);
for i = 1:numel(vals)
    T = load(part(i));  r = T.r;
    res.essr(i, j) = r.essr(1, 1);  res.essr_tin(i, j) = r.essr_tin(1, 1);
    res.anfrac(i, j) = r.anfrac(1, 1);  res.F(i, j) = r.F(1, 1);
    res.essrDrops(i, j, :) = r.essrDrops(1, 1, :);
end
save(f, 'res', 'prm', '-v7');
fprintf('%s: AS (swap search) = %s\n', which, mat2str(res.essr(:, j).', 5));
end
