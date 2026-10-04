function st = scheme_style(key)
%SCHEME_STYLE  Legend name, color, line style, and marker of each scheme. The same scheme
%   is drawn identically in all figures: MA-based designs with solid lines, fixed arrays
%   with dashed lines, and antenna selection with dash-dotted lines. The colors (red, blue,
%   orange, dark gray) remain distinguishable for color-vision deficiencies, and the line
%   styles and markers keep the curves distinguishable in grayscale print. The equal-power
%   benchmarks of Fig. 7 use colors (purple, black) that do not occur in Figs. 5 and 6.
red    = [0.80 0.10 0.12];
blue   = [0.00 0.38 0.70];
orange = [0.90 0.55 0.00];
gray   = [0.30 0.30 0.30];
green  = [0.00 0.55 0.40];
purple = [0.49 0.18 0.56];
black  = [0.00 0.00 0.00];
switch key
    case 'MA_full',   st = mk('Proposed',               red,    '-',  'o');
    case 'MA_rate',   st = mk('Rate-oriented MA',       blue,   '-',  's');
    case 'AS',        st = mk('Antenna selection',      orange, '-.', '^');
    case 'FPA_full',  st = mk('FPA',                    gray,   '--', 'd');
    % evaluated but only quoted in the text
    case 'SPA_full',  st = mk('Sparse FPA',             green,  '--', 'v');
    case 'AS_region', st = mk('AS (candidates span C)', orange, ':',  'v');
    case 'MA_noAN',   st = mk('Proposed w/o AN',        gray,   ':',  'x');
    % power-allocation study (Fig. 7)
    case 'MA_EPA',    st = mk('Equal power, opt. {\it\alpha}', purple, '-', 'd');
    case 'MA_fix',    st = mk('Equal power, {\it\alpha} = 0.5', black,  '-', 'v');
    otherwise, error('scheme_style: unknown scheme %s', key);
end
end

function st = mk(name, color, ls, marker)
st = struct('name', name, 'color', color, 'ls', ls, 'marker', marker);
end
