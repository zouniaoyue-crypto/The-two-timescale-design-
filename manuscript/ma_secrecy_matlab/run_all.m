%RUN_ALL  Reproduces all numerical results of main.tex (Figs. 3-7, Table I, and the
%   results quoted in the text of Section V; see readme.pdf).
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
fig5_snr(prm);                      % Fig. 5 and Table I: ESSR and AN power vs. SNR
fig6_region(prm);                   % Fig. 6: ESSR vs. region size
fig7_power_allocation(prm, 0);      % Fig. 7: power allocation vs. SNR, identical LUs
fig7_power_allocation(prm, 20);     %         ... and heterogeneous LUs (spread 20 dB)
% results quoted in the text of Section V (no figures)
extra_eve_aod_error(prm);           % Sec. V-D: robustness to errors in the AoD of Eve
extra_as_region(prm);               % Sec. V-E: AS with candidates spanning the region
extra_angle_offset(prm);            % Sec. V-E: ESSR vs. angular offset (M = 3)
extra_single_user(prm);             % Sec. V-E: single LU (M = 1)
extra_pa_spread(prm, 0);            % Sec. V-F: power allocation vs. fading spread, 0 dB
extra_pa_spread(prm, 10);           %           ... 10 dB
extra_pa_spread(prm, 20);           %           ... 20 dB
close all;
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
