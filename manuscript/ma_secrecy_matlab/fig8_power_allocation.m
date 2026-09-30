function res = fig8_power_allocation(prm)
%FIG8_POWER_ALLOCATION  Benefit of the long-term per-user power allocation {p_m}
%   (Propositions 2 and 3 of main.tex) over the information--AN power splitting with
%   equal user power (only alpha optimized). The large-scale fading coefficients of the
%   LUs are heterogeneous, beta_m (dB) = -spread*(m-1)/(M-1), i.e., [0, -spread/2,
%   -spread] for M = 3, and the ESSR is evaluated versus the spread for
%   P_tot/sigma^2 = 5 dB and 15 dB.
%   res.essr(i, k, j): spread i, scheme k (MA_full, MA_EPA, FPA_full, FPA_EPA), SNR j.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.Plist = [5 15];
res.values = [0 5 10 15 20];
res.schemes = {'MA_full', 'MA_EPA', 'FPA_full', 'FPA_EPA'};
K = numel(res.schemes);
res.essr = zeros(numel(res.values), K, numel(res.Plist));
res.anfrac = res.essr;
res.F = res.essr;
for j = 1:numel(res.Plist)
    r = power_allocation_sweep(prm, res.Plist(j), res.values, res.schemes);
    res.essr(:, :, j) = r.essr;
    res.anfrac(:, :, j) = r.anfrac;
    res.F(:, :, j) = r.F;
end
save(fullfile(results_dir(), 'fig8_power_allocation.mat'), 'res', 'prm', '-v7');
plot_fig8(res);
end
