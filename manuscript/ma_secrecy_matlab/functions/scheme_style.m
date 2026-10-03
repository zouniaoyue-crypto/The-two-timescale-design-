function st = scheme_style(key)
%SCHEME_STYLE  Legend name, color, line style, and marker of each scheme. The same
%   scheme is drawn identically in all figures: MA-based designs with solid lines,
%   FPA-based designs with dashed lines, and antenna selection with dash-dotted lines.
switch key
    case 'MA_full',  st = mk('Proposed',                [0.84 0.15 0.16], '-',  'o');
    case 'MA_rate',  st = mk('Rate-oriented MA',        [0.12 0.47 0.71], '-',  's');
    case 'SPA_full', st = mk('Sparse FPA',              [0.17 0.63 0.17], '--', '^');
    case 'FPA_full', st = mk('Compact FPA',             [0.58 0.40 0.74], '--', 'd');
    case 'AS',       st = mk('Antenna selection',       [0.95 0.55 0.10], '-.', 'v');
    case 'MA_noAN',  st = mk('Proposed w/o AN',         [0.30 0.30 0.30], ':',  'x');
    % power-allocation study (Fig. 8): color = power allocation, line = array
    case 'MA_EPA',   st = mk('MA, equal power, opt. {\it\alpha}',     [0.12 0.47 0.71], '-',  's');
    case 'MA_fix',   st = mk('MA, equal power, {\it\alpha} = 0.5',   [0.45 0.45 0.45], '-',  '^');
    case 'FPA_PA',   st = mk('Compact FPA, proposed power',          [0.84 0.15 0.16], '--', 'o');   % FPA_full data
    case 'FPA_EPA',  st = mk('Compact FPA, equal power, opt. {\it\alpha}', [0.12 0.47 0.71], '--', 's');
    case 'FPA_fix',  st = mk('Compact FPA, equal power, {\it\alpha} = 0.5', [0.45 0.45 0.45], '--', '^');
    otherwise, error('scheme_style: unknown scheme %s', key);
end
end

function st = mk(name, color, ls, marker)
st = struct('name', name, 'color', color, 'ls', ls, 'marker', marker);
end
