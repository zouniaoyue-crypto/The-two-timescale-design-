%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations, e.g., after changing the plot styles (fig_style.m,
%   scheme_style.m). In Octave, run under a display with the qt toolkit, e.g.,
%   xvfb-run -a octave --no-gui --eval replot_all
%   Set SUPPLEMENTARY = true to also redraw the supplementary figures (AoD offset, power
%   allocation versus the fading spread, and the rev-8 candidate comparisons of
%   plot_candidates.m: number of LUs, AoD error and large-scale fading of Eve, AN ablation).

if ~exist('SUPPLEMENTARY', 'var'), SUPPLEMENTARY = false; end
here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
R = struct();
for f = {'fig3_accuracy', 'fig4_convergence', 'fig5_snr', 'fig7_region', ...
         'extra_num_antennas', 'fig8_rician_b', 'extra_single_user', 'extra_pa_spread_10dB', ...
         'extra_num_users', 'extra_eve_aod_error', 'extra_eve_beta', 'extra_no_an'}
    R.(f{1}) = load_results(f{1});
end
if ~isempty(R.fig3_accuracy),    plot_fig3(R.fig3_accuracy);    close all; disp('replotted Fig. 3'); end
if ~isempty(R.fig4_convergence), plot_fig4(R.fig4_convergence); close all; disp('replotted Fig. 4'); end
if ~isempty(R.fig5_snr)
    plot_fig5(R.fig5_snr);  plot_fig6(R.fig5_snr, R.extra_no_an);  close all;  disp('replotted Figs. 5 and 6');
end
if ~isempty(R.fig7_region)
    plot_fig7(R.fig7_region, R.extra_num_antennas);  close all;  disp('replotted Fig. 7');
end
if ~isempty(R.fig8_rician_b) || ~isempty(R.extra_num_users)
    plot_fig8(R.extra_num_users, R.fig8_rician_b);  close all;  disp('replotted Fig. 8');
end
if SUPPLEMENTARY && ~isempty(R.extra_single_user)
    plot_offset(R.extra_single_user);  close all;  disp('replotted the AoD-offset figure');
end
if SUPPLEMENTARY && ~isempty(R.extra_pa_spread_10dB)
    plot_pa_spread(R.extra_pa_spread_10dB);  close all;  disp('replotted the fading-spread figure');
end
if SUPPLEMENTARY
    plot_candidates(R.extra_num_users, R.extra_eve_aod_error, R.extra_eve_beta, R.extra_no_an, R.fig5_snr);
    close all;  disp('replotted the candidate comparisons');
end
