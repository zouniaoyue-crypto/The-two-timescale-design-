%RUN_ALL  Reproduces all numerical results of main.tex (Figs. 3-7 and Tables I-II; see
%   readme.pdf for the run times).
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
extra_eve_aod_error(prm);           % Table II: robustness to errors in the AoD of Eve
fig6_region(prm);                   % Fig. 6(a): ESSR vs. region size
extra_as_region(prm);               %   ... AS with candidates spanning the region
extra_angle_offset(prm);            % Fig. 6(b): ESSR vs. angular separation, M = 3
extra_single_user(prm);             %   ... M = 1
extra_random_eve(prm, 3);           % Sec. V-F: AoDs of Eve independent of the LUs, M = 3
extra_random_eve(prm, 1);           %   ... M = 1
fig7_power_allocation(prm, 20);     % Fig. 7(a): power allocation vs. SNR (spread 20 dB)
extra_pa_spread(prm, 0);            % Fig. 7(b): power allocation vs. fading spread, 0 dB
extra_pa_spread(prm, 10);           %   ... 10 dB
close all;
replot_all;                         % Figs. 6 and 7 combine several result files
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
