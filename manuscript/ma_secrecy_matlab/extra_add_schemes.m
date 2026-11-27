function extra_add_schemes(prm, which, schemes)
%EXTRA_ADD_SCHEMES  Adds benchmark schemes (default: the FPA with Eve-aware AN 'FPA_ean',
%   rev-8g; in rev-8e: 'MA_null' and 'APS') to the stored sweeps without rerunning the
%   other schemes.
%   sweep_schemes.m uses the same drops (seeds) for every scheme, so that the added
%   columns are identical to those of a joint run. which: cell array of
%     'fig5'  results/fig5_snr.mat        (P_dB = 0:5:30; Figs. 5 and 6)
%     'fig7a' results/fig7_region.mat     (A; Fig. 7(a))
%     'fig7b' results/extra_num_antennas*  (N; Fig. 7(b), via extra_num_antennas.m)
%     'fig8a' results/extra_num_users*     (M; Fig. 8(a), via extra_num_users.m)
%     'fig8b' results/fig8_rician_b.mat   (kappa_e; Fig. 8(b))
%     'kappa' results/fig8_rician_a.mat   (common Rician factor; Section V-D, text)
%   Example (parallel sessions): extra_add_schemes([], {'fig5', 'fig7a'}).

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(which), which = {'fig5', 'fig7a', 'fig7b', 'fig8a', 'fig8b', 'kappa'}; end
if nargin < 3 || isempty(schemes), schemes = {'FPA_ean'}; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
files = struct('fig5', {{'fig5_snr', 'P_dB'}}, 'fig7a', {{'fig7_region', 'A'}}, ...
               'fig8b', {{'fig8_rician_b', 'kappae_dB'}}, 'kappa', {{'fig8_rician_a', 'kappa_common'}});
for w = which
    switch w{1}
        case 'fig7b'
            extra_num_antennas(prm, [], schemes);
        case 'fig8a'
            extra_num_users(prm, [], schemes);
        otherwise
            fn = files.(w{1});
            f = fullfile(results_dir(), [fn{1} '.mat']);
            S = load(f);
            rn = sweep_schemes(prm, fn{2}, S.res.values, schemes);
            res = merge_schemes(S.res, rn);  %#ok<NASGU>
            save(f, 'res', 'prm', '-v7');
            fprintf('extra_add_schemes: %s updated with %s\n', fn{1}, strjoin(schemes, ', '));
    end
end
end
