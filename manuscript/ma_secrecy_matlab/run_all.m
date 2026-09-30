%RUN_ALL  Reproduces all numerical results of main.tex (Figs. 3-8; see readme.pdf).
%   Set QUICK = true for a fast functional test (few drops, few Monte Carlo samples).
%   Results (.mat) and figures (.pdf/.eps/.png/.fig in MATLAB, .png in Octave) are
%   written to ./results. To re-draw the figures without re-running, use replot_all.
%   The scripts are independent and can be run in parallel MATLAB sessions.

QUICK = false;

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
prm = default_params();
if QUICK
    prm.numDrops = 3;  prm.S = 2000;  prm.numInit = 2;  prm.aoMaxIter = 20;
end
t0 = tic;
fig3_accuracy(prm);                 % Fig. 3: accuracy of the closed-form rates
fig4_convergence(prm);              % Fig. 4: convergence of Algorithm 2
fig5_snr(prm);                      % Fig. 5: ESSR and AN power fraction vs. SNR
fig6a_angle(prm);                   % Fig. 6(a): ESSR vs. angular offset, M = 3
fig6b_single_user(prm);             % Fig. 6(b): ESSR vs. angular offset, M = 1
fig7_region(prm);                   % Fig. 7: ESSR vs. region size
fig8_power_allocation(prm, 0);      % Fig. 8: power allocation, identical LUs
fig8_power_allocation(prm, 20);     % Fig. 8: power allocation, 20-dB spread of beta_m
close all;
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
