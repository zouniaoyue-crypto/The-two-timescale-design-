function new_figure()
%NEW_FIGURE  Opens a figure with a common style for all plots.
figure('Color', 'w');
hold on;  box on;  grid on;
set(gca, 'FontSize', 12, 'LineWidth', 0.8);
end
