function res = fig3_accuracy(prm)
%FIG3_ACCURACY  Fig. 3 of main.tex: accuracy of the closed-form ergodic rates at the
%   designs of the proposed scheme (Algorithm 2), averaged over prm.numDrops drops:
%     Fig. 3(a): versus P_tot/sigma^2 (kappa_m = kappa_e = 10 dB)
%     Fig. 3(b): versus kappa = kappa_m = kappa_e (P_tot/sigma^2 = 20 dB)
%   Markers: Monte Carlo (max(prm.S, 1e4) channel realizations); lines: closed forms
%   (LUs: Lemma 1; Eve: Proposition 1). See accuracy_point.m.
%   res.vsP(i, :) and res.vsK(i, :) = [LU MC, LU closed form, Eve MC, Eve closed form,
%   ESSR MC, approximate ESSR] for the i-th SNR and Rician factor, respectively.

if nargin < 1, prm = default_params(); end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res.Pvec = 0:5:30;
res.Kvec = -5:5:20;
S = max(prm.S, 10000);
res.vsP = zeros(numel(res.Pvec), 6);
res.vsK = zeros(numel(res.Kvec), 6);
for i = 1:numel(res.Pvec)
    pr = prm;  pr.P_dB = res.Pvec(i);
    r = accuracy_point(pr, prm.numDrops, S);
    res.vsP(i, :) = [r.lu, r.eve, r.essr];
    fprintf('fig3: P = %d dB done\n', res.Pvec(i));
end
for i = 1:numel(res.Kvec)
    pr = prm;  pr.kappa_dB = res.Kvec(i);  pr.kappae_dB = res.Kvec(i);
    r = accuracy_point(pr, prm.numDrops, S);
    res.vsK(i, :) = [r.lu, r.eve, r.essr];
    fprintf('fig3: kappa = %d dB done\n', res.Kvec(i));
end
save(fullfile(results_dir(), 'fig3_accuracy.mat'), 'res', 'prm', '-v7');
plot_fig3(res);
end
