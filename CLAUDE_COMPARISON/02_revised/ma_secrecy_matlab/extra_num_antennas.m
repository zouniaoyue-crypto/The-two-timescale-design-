function res = extra_num_antennas(prm, Nvals)
%EXTRA_NUM_ANTENNAS  ESSR (Monte Carlo) versus the number of MAs N at the default SNR and
%   region size (Fig. 6(b) of main.tex). For each N, the FPA is a 2 x N/2 UPA with lambda/2
%   spacing, the sparse FPA a 2 x N/2 UPA spanning the movable region, and AS selects N of
%   the 2N antennas of a 4 x N/2 UPA with lambda/2 spacing. AS is evaluated only for
%   N <= 10 (NaN otherwise), since its exhaustive search over nchoosek(2N, N) subsets
%   becomes prohibitive for larger N (2.7e6 subsets for N = 12).
%   Every N is saved in results/extra_num_antennas_N<N>.mat. Since the values of N use the
%   same drops but are otherwise independent, they can be run in parallel sessions, e.g.,
%   extra_num_antennas([], [4 16]) and extra_num_antennas([], [6 14]); as soon as all
%   values of the default set are available, they are merged into extra_num_antennas.mat.

if nargin < 1 || isempty(prm), prm = default_params(); end
Nall = [4 6 8 10 12 14 16];
if nargin < 2, Nvals = Nall; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
schemes = main_schemes();
for N = Nvals
    pr = prm;
    pr.N = N;  pr.upaCols = N/2;  pr.asCols = N/2;
    sN = schemes;
    if N > 10, sN = sN(~strcmp(sN, 'AS')); end
    r = sweep_schemes(pr, 'N', N, sN);
    save(fullfile(results_dir(), sprintf('extra_num_antennas_N%d.mat', N)), 'r', 'pr', '-v7');
end
% merge all values of N (missing schemes are NaN)
K = numel(schemes);  I = numel(Nall);
res.values = Nall;  res.schemes = schemes;
res.essr = nan(I, K);  res.essr_tin = nan(I, K);  res.anfrac = nan(I, K);  res.F = nan(I, K);
res.essrDrops = nan(I, K, prm.numDrops);
res.designs = cell(I, K, prm.numDrops);
res.leak = nan(I, K, prm.M);
res.an = nan(I, K);
res.parameterField = 'N';
res.evaluationSamples = prm.S;
res.algorithmVersion = 'revision-v1';
for i = 1:I
    f = fullfile(results_dir(), sprintf('extra_num_antennas_N%d.mat', Nall(i)));
    if ~exist(f, 'file')
        fprintf('extra_num_antennas: N = %d missing, results not merged yet.\n', Nall(i));
        return;
    end
    S = load(f);
    [~, k] = ismember(S.r.schemes, schemes);
    res.essr(i, k) = S.r.essr;  res.essr_tin(i, k) = S.r.essr_tin;
    res.anfrac(i, k) = S.r.anfrac;  res.F(i, k) = S.r.F;
    res.essrDrops(i, k, :) = S.r.essrDrops;
    assert(isfield(S.r, 'designs') && isfield(S.r, 'leak') && isfield(S.r, 'an'), ...
        'Regenerate this N result with the revised provenance fields before merging');
    assert(S.r.evaluationSamples == prm.S && S.pr.numDrops == prm.numDrops);
    res.designs(i, k, :) = S.r.designs;
    res.leak(i, k, :) = S.r.leak;
    res.an(i, k) = S.r.an;
end
save(fullfile(results_dir(), 'extra_num_antennas.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'N');
end
