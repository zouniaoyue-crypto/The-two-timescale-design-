function [Y, keys] = pick_schemes(res, field, keys)
%PICK_SCHEMES  Columns of res.(field) that belong to the schemes in keys (default:
%   main_schemes), in that order. Schemes missing from res are skipped.
if nargin < 3, keys = main_schemes(); end
have = res.schemes;
if ischar(have), have = {have}; end
sel = [];  kept = {};
for k = 1:numel(keys)
    j = find(strcmp(have, keys{k}), 1);
    if ~isempty(j), sel(end+1) = j; kept{end+1} = keys{k}; end %#ok<AGROW>
end
Y = res.(field)(:, sel);  keys = kept;
end
