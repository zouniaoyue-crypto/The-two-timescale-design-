function plot_fig8(res)
%PLOT_FIG8  Relative ESSR gain (%) of the long-term per-user power allocation over the
%   equal user power allocation (alpha only), versus the spread of the large-scale
%   fading coefficients of the LUs, for the MA and FPA designs and each SNR in res.Plist.
if ~isfield(res, 'Plist')           % single-SNR results: plot the ESSR curves directly
    names = {'Proposed MA', 'MA, equal power', 'FPA (\lambda/2 UPA)', 'FPA, equal power'};
    plot_sweep(res, res.values, 'Spread \varsigma of \beta_m among the LUs (dB)', ...
               'Ergodic secrecy sum rate (bps/Hz)', 'essr', names, 'southwest', 1:4, [1 2 4 6]);
    save_figure('fig8_power_allocation');
    return;
end
new_figure();
col = {[0 0.447 0.741], [0.494 0.184 0.556]};     % MA, FPA
mk = {'-o', '--s'; '-^', '--d'};                  % rows: SNR index, columns: MA/FPA
leg = {};
for j = 1:numel(res.Plist)
    E = res.essr(:, :, j);
    gMA  = 100*(E(:,1)./E(:,2) - 1);
    gFPA = 100*(E(:,3)./E(:,4) - 1);
    plot(res.values, gMA,  mk{j,1}, 'Color', col{1}, 'LineWidth', 1.6, 'MarkerSize', 7);
    plot(res.values, gFPA, mk{j,2}, 'Color', col{2}, 'LineWidth', 1.6, 'MarkerSize', 7);
    leg{end+1} = sprintf('MA, P_{tot}/\\sigma^2 = %d dB', res.Plist(j));  %#ok<AGROW>
    leg{end+1} = sprintf('FPA, P_{tot}/\\sigma^2 = %d dB', res.Plist(j)); %#ok<AGROW>
end
xlabel('Spread \varsigma of \beta_m among the LUs (dB)');
ylabel('ESSR gain over equal power (%)');
legend(leg, 'Location', 'northwest', 'FontSize', 9);
save_figure('fig8_power_allocation');
end
