function res = load_results(name)
%LOAD_RESULTS  Returns the struct res saved in results/<name>.mat, or [] if the file does
%   not exist (used by the figures that combine several result files, e.g., Figs. 6 and 7).
res = [];
f = fullfile(results_dir(), [name '.mat']);
if exist(f, 'file')
    S = load(f);  res = S.res;
end
end
