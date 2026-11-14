%RUN_ALL  Reproduces all numerical results of main.tex (Figs. 3-7 and the numbers quoted in
%   Section V; see readme.pdf for the run times). Set SUPPLEMENTARY = true to also run the
%   robustness checks that are not reported in main.tex (Eve treating interference as noise,
%   errors in the AoD of Eve, and AoDs of Eve independent of the LUs).
%   Set QUICK = true for a fast functional test (few drops, few Monte Carlo samples).
%   Results (.mat) and figures (.pdf/.eps/.png/.fig in MATLAB, .png in Octave) are
%   written to ./results. To re-draw the figures without re-running, use replot_all.
%   The scripts are independent and can be run in parallel MATLAB sessions.

QUICK = false;
SUPPLEMENTARY = false;

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
extra_grid_check(prm);              % Sec. V-A: Stage-1 grid spacing halved (20 drops)
fig5_snr(prm);                      % Fig. 5: ESSR and AN power vs. SNR
fig6_region(prm);                   % Fig. 6(a): ESSR vs. region size
extra_num_antennas(prm);            % Fig. 6(b): ESSR vs. number of MAs
extra_as_swap_check(prm);           % Sec. V-A (footnote): AS swap search vs. exhaustive search, N <= 10
extra_angle_offset(prm);            % Sec. V-F (text): ESSR vs. AoD offset, M = 3
extra_single_user(prm);             % Fig. 7: ESSR vs. AoD offset, M = 1
extra_pa_spread(prm, 10);           % Fig. 8: power allocation vs. large-scale fading spread, 10 dB
extra_pa_spread(prm, 0);            % Sec. V-G (text): the same at 0 dB
fig7_power_allocation(prm, 20);     % Sec. V-G (text): power allocation vs. SNR (spread 20 dB)
if SUPPLEMENTARY                    % not reported in main.tex (former Sec. V-H)
    extra_as_region(prm);           %   AS with candidates spanning the region (former Fig. 6(a) curve)
    extra_eve_aod_error(prm);       %   errors in the AoD of Eve
    extra_random_eve(prm, 3);       %   AoDs of Eve independent of the LUs, M = 3
    extra_random_eve(prm, 1);       %   ... M = 1
    print_table_eve(load_results('fig5_snr'), [10 20 30]);   % Eve treating interference as noise
end
close all;
replot_all;                         % Figs. 6-8 combine several result files
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
