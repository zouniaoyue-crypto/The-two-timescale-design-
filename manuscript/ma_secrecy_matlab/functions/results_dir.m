function d = results_dir()
%RESULTS_DIR  Folder where .mat files and figures are stored (created if missing).
d = fullfile(fileparts(fileparts(mfilename('fullpath'))), 'results');
if ~exist(d, 'dir'), mkdir(d); end
end
