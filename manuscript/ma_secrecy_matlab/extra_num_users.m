function res = extra_num_users(prm, Mvals, schemesRun)
%EXTRA_NUM_USERS  Fig. 8(a) of main.tex: ESSR (Monte Carlo) versus the number of LUs M
%   at the default SNR, N = 8, and A = 4 lambda, for the schemes in main_schemes.m. Eve
%   lies close to LU 1 as in the default scenario (for M = 1, the single-LU case of
%   Section III-D 2)). Every M is saved in
%   results/extra_num_users_M<M>.mat, so that subsets can run in parallel sessions, e.g.,
%   extra_num_users([], [1 2 3]) and extra_num_users([], [4 5 6]); as soon as all values
%   of the default set are available, they are merged into results/extra_num_users.mat.
%   The optional schemesRun runs only these schemes and merges them into the stored file
%   of each M (merge_schemes.m), e.g., extra_num_users([], [], {'MA_null', 'APS'}).

if nargin < 1 || isempty(prm), prm = default_params(); end
Mall = 1:6;                                      % N - M >= 2 AN dimensions for N = 8
if nargin < 2 || isempty(Mvals), Mvals = Mall; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
schemes = main_schemes();
if nargin < 3 || isempty(schemesRun), schemesRun = schemes; end
for M = Mvals
    r = sweep_schemes(prm, 'M', M, schemesRun);
    f = fullfile(results_dir(), sprintf('extra_num_users_M%d.mat', M));
    if exist(f, 'file') && numel(schemesRun) < numel(schemes)   % merge into the stored schemes
        S = load(f);  r = merge_schemes(S.r, r);
    end
    save(f, 'r', '-v7');
end
res = [];
K = numel(schemes);  I = numel(Mall);
for i = 1:I
    f = fullfile(results_dir(), sprintf('extra_num_users_M%d.mat', Mall(i)));
    if ~exist(f, 'file')
        fprintf('extra_num_users: M = %d missing, results not merged yet.\n', Mall(i));
        return;
    end
    S = load(f);
    if i == 1
        res.values = Mall;  res.schemes = schemes;
        res.essr = nan(I, K);  res.essr_tin = nan(I, K);  res.anfrac = nan(I, K);  res.F = nan(I, K);
        res.anpred = nan(I, K);  res.essrDrops = nan(I, K, prm.numDrops);
    end
    [in, k] = ismember(S.r.schemes, schemes);       % stored schemes outside main_schemes are skipped
    res.essr(i, k(in)) = S.r.essr(in);  res.essr_tin(i, k(in)) = S.r.essr_tin(in);
    res.anfrac(i, k(in)) = S.r.anfrac(in);  res.F(i, k(in)) = S.r.F(in);
    res.anpred(i, k(in)) = S.r.anpred(in);  res.essrDrops(i, k(in), :) = S.r.essrDrops(:, in, :);
end
save(fullfile(results_dir(), 'extra_num_users.mat'), 'res', 'prm', '-v7');
print_sweep(res, 'M');
plot_fig8(res, load_results('fig8_rician_b'));          % Fig. 8(a)
end
