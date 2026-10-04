function [ax, h] = plot_schemes(x, Y, keys, names)
%PLOT_SCHEMES  New figure with one curve per scheme (columns of Y), using the common
%   scheme styles of scheme_style.m. Optional names override the legend names.
ax = new_figure();
h = zeros(1, numel(keys));
for k = 1:numel(keys)
    st = scheme_style(keys{k});
    if nargin >= 4 && ~isempty(names), st.name = names{k}; end
    h(k) = plot_curve(ax, x, Y(:, k), st);
end
end
