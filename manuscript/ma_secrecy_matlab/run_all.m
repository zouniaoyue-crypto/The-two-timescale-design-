%RUN_ALL  Reproduces all numerical results of main.tex (Figs. 3-8 and the numbers quoted in
%   Section V; see readme.pdf for the run times). Set SUPPLEMENTARY = true to also run the
%   supplementary results that are not reported in main.tex (Eve treating interference as
%   noise, AoDs of Eve independent of the LUs for M = 1, the AoD-offset and power-allocation
%   studies removed from main.tex in rev-7, and the rev-8 candidate comparisons that were
%   not adopted: errors in the AoD of Eve and large-scale fading of Eve).
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
extra_mm_compare(prm);              % Sec. V-B (text): Stage 2 vs. the surrogate of [ZhengTCOM2025]
fig5_snr(prm);                      % Figs. 5 and 6: ESSR, AN power, and power allocation vs. SNR
extra_no_an(prm);                   % Fig. 6: ESSR without AN vs. SNR (same drops as fig5_snr)
table_mechanisms(prm);              % Sec. V-C (text): LoS correlation, leakage, and AN at Eve of the designs (20 dB)
extra_random_eve(prm, 3);           % Sec. V-C (text): AoDs of Eve independent of the LUs, M = 3
fig7_region(prm);                   % Fig. 7(a): ESSR vs. region size
extra_num_antennas(prm);            % Fig. 7(b): ESSR vs. number of MAs
extra_as_swap_check(prm);           % Sec. V-A (footnote): AS swap search vs. exhaustive search, N <= 10
extra_num_users(prm);               % Fig. 8(a): ESSR vs. the number of LUs
fig8_rician(prm);                   % Fig. 8(b) and Sec. V-D (text): ESSR vs. the Rician factors
if SUPPLEMENTARY                    % not reported in main.tex
    extra_as_region(prm);           %   AS with candidates spanning the region
    extra_random_eve(prm, 1);       %   AoDs of Eve independent of the LUs, M = 1
    print_table_eve(load_results('fig5_snr'), [10 20 30]);   % Eve treating interference as noise
    extra_angle_offset(prm);        %   ESSR vs. AoD offset, M = 3 (former Sec. V-F)
    extra_single_user(prm);         %   ESSR vs. AoD offset, M = 1 (former Fig. 7)
    extra_pa_spread(prm, 10);       %   power allocation vs. fading spread (former Fig. 8)
    extra_pa_spread(prm, 0);
    extra_pa_hetero(prm, 20);       %   power allocation vs. SNR, spread 20 dB (former Sec. V-G)
    extra_eve_aod_error(prm);       %   rev-8 candidates not adopted (plot_candidates.m): errors in
    extra_eve_beta(prm);            %     the AoD of Eve and large-scale fading of Eve
end
close all;
replot_all;                         % Figs. 6-8 combine several result files
fprintf('All simulations finished in %.1f min.\n', toc(t0)/60);
