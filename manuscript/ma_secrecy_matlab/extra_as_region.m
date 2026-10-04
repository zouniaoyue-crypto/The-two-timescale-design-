function res = extra_as_region(prm, Avec)
%EXTRA_AS_REGION  Antenna selection whose 2N candidates span the movable region (quoted
%   in Section V-E of main.tex, no figure): N of the 2N antennas of a UPA spanning
%   C = [-A/2, A/2]^2 are selected by the same statistical-CSI metric as the 'AS'
%   benchmark, versus the side length A (the 'AS' benchmark uses a lambda/2 UPA).

if nargin < 1 || isempty(prm), prm = default_params(); end
if nargin < 2 || isempty(Avec), Avec = [1.5 2 3 4 5 6]; end
addpath(fullfile(fileparts(mfilename('fullpath')), 'functions'));
res = sweep_schemes(prm, 'A', Avec, {'AS_region'});
save(fullfile(results_dir(), 'extra_as_region.mat'), 'res', 'prm', '-v7');
fprintf('\nESSR (bps/Hz) of AS with candidates spanning C, A/lambda = %s:\n%s\n', ...
        mat2str(Avec), sprintf('%8.2f', res.essr));
end
