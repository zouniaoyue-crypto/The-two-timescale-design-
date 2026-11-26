function res = extra_num_antennas(prm, Nvals, schemesRun)
%EXTRA_NUM_ANTENNAS  ESSR (Monte Carlo) versus the number of MAs N at the default SNR and
%   region size (Fig. 7(b) of main.tex), for the schemes in main_schemes.m. For each N, the
%   FPA is a 2 x N/2 UPA with lambda/2 spacing (the stored files of rev-7 also contain AS
%   and the sparse FPA, which are no longer plotted).
%   Every N is saved in results/extra_num_antennas_N<N>.mat. Since the values of N use the
%   same drops but are otherwise independent, they can be run in parallel sessions, e.g.,
%   extra_num_antennas([], [4 16]) and extra_num_antennas([], [6 14]); as soon as all
%   values of the default set are available, they are merged into extra_num_antennas.mat.
%   The optional schemesRun (subset of main_schemes()) runs only these schemes and merges
%   them into the existing file of each N (merge_schemes.m), e.g.,
%   extra_num_antennas([], [], {'MA_null', 'APS'}).

if nargin < 1 || isempty(prm), prm = default_params(); end
Nall = [4 6 8 10 12 14 16];
if nargin < 2 || isempty(Nvals), Nvals = Nall; end
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
    [in, k] = ismember(S.r.schemes, schemes);       % stored schemes outside main_schemes are skipped
    res.essr(i, k(in)) = S.r.essr(in);  res.essr_tin(i, k(in)) = S.r.essr_tin(in);
    res.anfrac(i, k(in)) = S.r.anfrac(in);  res.F(i, k(in)) = S.r.F(in);
    res.essrDrops(i, k(in), :) = S.r.essrDrops(:, in, :);
end
save(fullfile(results_dir(), 'extra_num_antennas.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'N');
end
