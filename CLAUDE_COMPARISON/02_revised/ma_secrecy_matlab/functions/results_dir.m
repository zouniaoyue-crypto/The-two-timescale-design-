function d = results_dir()
%RESULTS_DIR  Folder where .mat files and figures are stored (created if missing).
% A separate output folder preserves the supplied results during verification.
d = getenv('MA_RESULTS_DIR');
if isempty(d)
    d = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'results');
end
if ~exist(d, 'dir'), mkdir(d); end
end
