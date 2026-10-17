function res = extra_random_eve(prm, M)
%EXTRA_RANDOM_EVE  ESSR (Monte Carlo) when the AoDs of Eve are independent of those of the
%   LUs, i.e., uniformly distributed over the same range as those of the LUs (prm.Delta = Inf
%   in gen_scenario.m), at the default SNR. Quoted in Section V-F of main.tex for M = 3 and
%   M = 1 (results/extra_random_eve_M<M>.mat).

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2, M = prm.M; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
prm.M = M;
res = sweep_schemes(prm, 'Delta', Inf, main_schemes());
save(fullfile(results_dir(), sprintf('extra_random_eve_M%d.mat', M)), 'res', 'prm', '-v7');
print_sweep(res, 'Delta (rad)');
end
