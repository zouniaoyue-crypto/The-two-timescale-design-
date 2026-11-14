function res = extra_num_antennas(prm, Nvals, schemesRun)
%EXTRA_NUM_ANTENNAS  ESSR (Monte Carlo) versus the number of MAs N at the default SNR and
%   region size (Fig. 6(b) of main.tex). For each N, the FPA is a 2 x N/2 UPA with lambda/2
%   spacing, the sparse FPA a 2 x N/2 UPA spanning the movable region, and AS selects N of
%   the 2N antennas of a 4 x N/2 UPA with lambda/2 spacing by the swap search (as_swap.m)
%   for all N, as in the other figures; the exhaustive search over nchoosek(2N, N) subsets
%   (2.7e6 for N = 12) is used only for the validation in extra_as_swap_check.m (N <= 10).
%   Every N is saved in results/extra_num_antennas_N<N>.mat. Since the values of N use the
%   same drops but are otherwise independent, they can be run in parallel sessions, e.g.,
%   extra_num_antennas([], [4 16]) and extra_num_antennas([], [6 14]); as soon as all
%   values of the default set are available, they are merged into extra_num_antennas.mat.
%   The optional schemesRun (subset of main_schemes()) runs only these schemes and merges
%   them into the existing file of each N, e.g., extra_num_antennas([], [12 14 16], {'AS'}).

if nargin < 1 || isempty(prm), prm = default_params(); end
Nall = [4 6 8 10 12 14 16];
if nargin < 2, Nvals = Nall; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
schemes = main_schemes();
if nargin < 3 || isempty(schemesRun), schemesRun = schemes; end
for N = Nvals
    pr = prm;
    pr.N = N;  pr.upaCols = N/2;  pr.asCols = N/2;
    r = sweep_schemes(pr, 'N', N, schemesRun);
    f = fullfile(results_dir(), sprintf('extra_num_antennas_N%d.mat', N));
    if exist(f, 'file') && numel(schemesRun) < numel(schemes)   % merge into the stored schemes
        S = load(f);  r = merge_schemes(S.r, r);
    end
    save(f, 'r', 'pr', '-v7');
end
% merge all values of N (missing schemes are NaN)
K = numel(schemes);  I = numel(Nall);
res.values = Nall;  res.schemes = schemes;
res.essr = nan(I, K);  res.essr_tin = nan(I, K);  res.anfrac = nan(I, K);  res.F = nan(I, K);
res.essrDrops = nan(I, K, prm.numDrops);
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
end
save(fullfile(results_dir(), 'extra_num_antennas.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'N');
end

function r = merge_schemes(r, rn)
% adds (or replaces) the schemes of rn in r; both are results of sweep_schemes for one N
for k = 1:numel(rn.schemes)
    j = find(strcmp(r.schemes, rn.schemes{k}), 1);
    if isempty(j), j = numel(r.schemes) + 1;  r.schemes{j} = rn.schemes{k}; end
    r.essr(:, j) = rn.essr(:, k);  r.essr_tin(:, j) = rn.essr_tin(:, k);
    r.anfrac(:, j) = rn.anfrac(:, k);  r.F(:, j) = rn.F(:, k);
    r.essrDrops(:, j, :) = rn.essrDrops(:, k, :);
end
end
