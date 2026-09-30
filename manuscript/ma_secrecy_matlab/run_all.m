%RUN_ALL  Reproduces all figures of the simulation package (see readme.pdf).
%   Set QUICK = true for a fast functional test (few drops, few Monte Carlo samples).
%   Results (.mat, .pdf, .png, .eps, and .fig in MATLAB) are written to ./results.
%   To re-draw the figures from saved results without re-running, use replot_all.

QUICK = false;

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
prm = default_params();
if QUICK
    prm.numDrops = 3;  prm.S = 2000;  prm.numInit = 2;  prm.aoMaxIter = 20;
end
t0 = tic;
fig1_accuracy(prm);           % Figs. 1a-1d: accuracy of the closed-form rates
fig2_convergence(prm);        % Fig. 2: convergence of Algorithm 2
fig3_essr_vs_power(prm);      % Fig. 3: ESSR vs P_tot/sigma^2, and Fig. 6: AN power fraction
fig4_essr_vs_angle(prm);      % Fig. 4: ESSR vs angular offset Delta
fig5_essr_vs_region(prm);     % Fig. 5: ESSR vs region size A
fig7_single_user(prm);        % Figs. 7a-7b: single LU (M = 1)
fig8_power_allocation(prm);   % Fig. 8: per-user power allocation vs equal power
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
