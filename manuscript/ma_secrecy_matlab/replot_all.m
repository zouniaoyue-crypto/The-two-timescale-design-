%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations, e.g., after changing the plot styles (fig_style.m,
%   scheme_style.m). In Octave, run under a display with the qt toolkit, e.g.,
%   xvfb-run -a octave --no-gui --eval replot_all
%   Set SUPPLEMENTARY = true to also redraw the supplementary figures (AoD offset and
%   power allocation versus the fading spread; former Figs. 7 and 8).

if ~exist('SUPPLEMENTARY', 'var'), SUPPLEMENTARY = false; end
here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
R = struct();
for f = {'fig3_accuracy', 'fig4_convergence', 'fig5_snr', 'fig7_region', ...
         'extra_num_antennas', 'fig8_rician_a', 'fig8_rician_b', 'extra_single_user', ...
         'extra_pa_spread_10dB'}
    R.(f{1}) = load_results(f{1});
end
if ~isempty(R.fig3_accuracy),    plot_fig3(R.fig3_accuracy);    close all; disp('replotted Fig. 3'); end
if ~isempty(R.fig4_convergence), plot_fig4(R.fig4_convergence); close all; disp('replotted Fig. 4'); end
if ~isempty(R.fig5_snr)
    plot_fig5(R.fig5_snr);  plot_fig6(R.fig5_snr);  close all;  disp('replotted Figs. 5 and 6');
end
if ~isempty(R.fig7_region)
    plot_fig7(R.fig7_region, R.extra_num_antennas);  close all;  disp('replotted Fig. 7');
end
if ~isempty(R.fig8_rician_a) || ~isempty(R.fig8_rician_b)
    plot_fig8(R.fig8_rician_a, R.fig8_rician_b);  close all;  disp('replotted Fig. 8');
end
if SUPPLEMENTARY && ~isempty(R.extra_single_user)
    plot_offset(R.extra_single_user);  close all;  disp('replotted the AoD-offset figure');
end
if SUPPLEMENTARY && ~isempty(R.extra_pa_spread_10dB)
    plot_pa_spread(R.extra_pa_spread_10dB);  close all;  disp('replotted the fading-spread figure');
end
