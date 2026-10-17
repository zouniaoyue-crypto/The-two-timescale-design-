function st = scheme_style(key)
%SCHEME_STYLE  Legend name, color, line style, line width, marker, and marker face of each
%   scheme. The same scheme is drawn identically in all figures: MA-based designs with
%   solid lines, fixed arrays with dashed lines, and antenna selection with dash-dotted
%   lines. The proposed design is emphasized by a thicker line and filled markers; the
%   benchmarks use thinner lines and lightly tinted markers (colors: fig_palette.m).
c = fig_palette();
switch key
    case 'MA_full',   st = mk('Proposed',               c.verm,   '-',  'o', 1.4, c.verm);
    case 'MA_rate',   st = mk('Rate-oriented MA',       c.blue,   '-',  's', 1.1, c.tint(c.blue, 0.25));
    case 'AS',        st = mk('AS',                     c.green,  '-.', '^', 1.1, c.tint(c.green, 0.25));
    case 'FPA_full',  st = mk('FPA',                    c.gray,   '--', 'd', 1.1, c.tint(c.gray, 0.2));
    % evaluated but only quoted in the text or in Fig. 6(a)
    case 'SPA_full',  st = mk('Sparse FPA',             c.sky,    '--', 'v', 1.1, c.tint(c.sky, 0.25));
    case 'AS_region', st = mk('AS, region-wide',        c.green,  ':',  'v', 1.3, c.tint(c.green, 0.25));
    case 'MA_noAN',   st = mk('Proposed w/o AN',        c.gray,   ':',  'x', 1.1, 'none');
    % power-allocation study (Fig. 7)
    case 'MA_EPA',    st = mk('Equal power, opt. {\it\alpha}', c.purple, '-', 'd', 1.1, c.tint(c.purple, 0.25));
    case 'MA_fix',    st = mk('Equal power, {\it\alpha} = 0.5', c.dark,  '-', 'v', 1.1, c.tint(c.dark, 0.15));
    otherwise, error('scheme_style: unknown scheme %s', key);
end
end

function st = mk(name, color, ls, marker, lw, mfc)
st = struct('name', name, 'color', color, 'ls', ls, 'marker', marker, 'lw', lw, 'mfc', mfc);
end
