function print_sweep(res, xname)
%PRINT_SWEEP  Prints the average ESSR and AN power fraction of every scheme in res
%   (output of sweep_schemes) and the relative gain of the first scheme.
name = @(k) regexprep(scheme_name(res.schemes{k}), '\\it|\\|[{}]', '');   % strip TeX markup
fprintf('\n%-24s %s\n', xname, sprintf('%8.3g', res.values));
for k = 1:numel(res.schemes)
    fprintf('%-24s %s   (AN fraction %s)\n', name(k), ...
            sprintf('%8.2f', res.essr(:, k)), sprintf('%5.2f', res.anfrac(:, k)));
end
for k = 2:numel(res.schemes)
    fprintf('gain over %-14s %s %%\n', name(k), ...
            sprintf('%8.1f', 100*(res.essr(:, 1)./res.essr(:, k) - 1)));
end
end
