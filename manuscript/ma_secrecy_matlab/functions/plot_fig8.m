function plot_fig8(res)
%PLOT_FIG8  ESSR versus the spread of the large-scale fading coefficients of the LUs:
%   long-term per-user power allocation versus equal user power (alpha only).
names = {'Proposed MA', 'MA, equal power', 'FPA (\lambda/2 UPA)', 'FPA, equal power'};
plot_sweep(res, res.values, 'Spread \varsigma of \beta_m among the LUs (dB)', ...
           'Ergodic secrecy sum rate (bps/Hz)', 'essr', names, 'southwest', 1:4, [1 2 4 6]);
save_figure('fig8_power_allocation');
end
