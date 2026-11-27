function st = scheme_style(key)
%SCHEME_STYLE  Legend name, color, line style, line width, marker, and marker face of each
%   scheme. The same scheme is drawn identically in all figures: the color identifies the
%   scheme (fig_palette.m), the line style the array type (solid: MAs with continuous
%   positions; dash-dotted: discrete positions (APS, AS; supplementary scripts only);
%   dashed: fixed arrays, i.e., the FPA and the FPA with Eve-aware AN; dotted: equal power
%   or without AN), and each scheme has its own hollow marker (circle, square, triangle,
%   diamond). The proposed design is distinguished by its color and a thicker line (1.4 pt
%   versus 1.0 pt). The variants of Fig. 6 (with equal power p_m = q = P_tot/N; without AN)
%   keep the color of their counterpart and are drawn with dotted lines, with filled markers
%   (equal power) or the markers x and + (without AN).
c = fig_palette();
switch key
    case 'MA_full',   st = mk('Proposed',               c.red,    '-',  'o', 1.4);
    case 'MA_rate',   st = mk('Rate-oriented MA',       c.blue,   '-',  's', 1.0);
    case 'MA_null',   st = mk('Eve-nulling MA',         c.ochre,  '-',  'v', 1.0);
    case 'APS',       st = mk('APS',                    c.teal,   '-.', '^', 1.0);
    case 'AS',        st = mk('AS',                     c.teal,   '-.', '^', 1.0);
    case 'SPA_full',  st = mk('Sparse FPA',             c.ochre,  '--', 'v', 1.0);
    case 'FPA_full',  st = mk('FPA',                    c.gray,   '--', 'd', 1.0);
    case 'MA_eq',     st = mk('MA with equal power',    c.red,    ':',  'o', 1.0);  st.mfc = c.red;
    case 'FPA_eq',    st = mk('FPA with equal power',   c.gray,   ':',  'd', 1.0);  st.mfc = c.gray;
    case 'FPA_ean',   st = mk('FPA with Eve-aware AN',  c.teal,   '--', '^', 1.0);
    case 'AS_region', st = mk('AS, region-wide',        c.teal,   ':',  '>', 1.2);
    case 'MA_noAN',   st = mk('MA without AN',          c.red,    ':',  'x', 1.0);
    case 'FPA_noAN',  st = mk('FPA without AN',         c.gray,   ':',  '+', 1.0);
    % supplementary power-allocation study (former Fig. 8)
    case 'MA_EPA',    st = mk('Equal power, opt. {\it\alpha}', c.purple, '-', 'p', 1.0);
    case 'MA_fix',    st = mk('Equal power, {\it\alpha} = 0.5', c.dark,  '-', '>', 1.0);
    otherwise, error('scheme_style: unknown scheme %s', key);
end
end

function st = mk(name, color, ls, marker, lw)
st = struct('name', name, 'color', color, 'ls', ls, 'marker', marker, 'lw', lw, 'mfc', 'w');
end
