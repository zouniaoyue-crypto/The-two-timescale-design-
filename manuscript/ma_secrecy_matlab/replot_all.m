%REPLOT_ALL  Re-creates all figures from the saved results (results/*.mat) without
%   re-running the simulations, e.g., after changing the plot styles (fig_style.m,
%   scheme_style.m), and prints Table I. In Octave, run under a display with the qt
%   toolkit, e.g., xvfb-run -a octave --no-gui --eval replot_all

here = fileparts(mfilename('fullpath'));
if isempty(here), here = pwd; end
addpath(here);  addpath(fullfile(here, 'functions'));
R = struct();
for f = {'fig3_accuracy', 'fig4_convergence', 'fig5_snr', 'fig6_region', ...
         'extra_as_region', 'extra_num_antennas', 'extra_angle_offset', 'extra_single_user', ...
         'extra_pa_spread_0dB', 'extra_pa_spread_10dB'}
    R.(f{1}) = load_results(f{1});
end
if ~isempty(R.fig3_accuracy),    plot_fig3(R.fig3_accuracy);    close all; disp('replotted Fig. 3'); end
if ~isempty(R.fig4_convergence), plot_fig4(R.fig4_convergence); close all; disp('replotted Fig. 4'); end
if ~isempty(R.fig5_snr),         plot_fig5(R.fig5_snr);         close all; disp('replotted Fig. 5'); end
if ~isempty(R.fig6_region)
    plot_fig6(R.fig6_region, R.extra_as_region, R.extra_num_antennas);
    close all;  disp('replotted Fig. 6');
end
if ~isempty(R.extra_angle_offset) || ~isempty(R.extra_pa_spread_10dB)
    plot_fig7(R.extra_angle_offset, R.extra_single_user, R.extra_pa_spread_0dB, R.extra_pa_spread_10dB);
    close all;  disp('replotted Fig. 7');
end
if ~isempty(R.fig5_snr) && isfield(R.fig5_snr, 'essr_tin')
    print_table_eve(R.fig5_snr, [10 20 30]);                 % Table I
end
