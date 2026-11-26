function st = scheme_style(key)
%SCHEME_STYLE  Legend name, color, line style, line width, marker, and marker face of each
%   scheme. The same scheme is drawn identically in all figures: the color identifies the
%   scheme (fig_palette.m), the line style the array type (solid: MAs; dash-dotted: AS;
%   dashed: fixed arrays; dotted: equal power or no AN), and each scheme has its own hollow
%   marker (circle, square, triangles, diamond). The proposed design is distinguished by
%   its color and a thicker line (1.4 pt versus 1.0 pt). The equal-power variants
%   (p_m = q = P_tot/N; Fig. 6) keep the color and marker of their counterpart and are
%   drawn with dotted lines and filled markers.
c = fig_palette();
switch key
    case 'MA_full',   st = mk('Proposed',               c.red,    '-',  'o', 1.4);
    case 'MA_rate',   st = mk('Rate-oriented MA',       c.blue,   '-',  's', 1.0);
    case 'AS',        st = mk('AS',                     c.teal,   '-.', '^', 1.0);
    case 'SPA_full',  st = mk('Sparse FPA',             c.ochre,  '--', 'v', 1.0);
    case 'FPA_full',  st = mk('FPA',                    c.gray,   '--', 'd', 1.0);
    case 'MA_eq',     st = mk('MA, equal power',        c.red,    ':',  'o', 1.0);  st.mfc = c.red;
    case 'FPA_eq',    st = mk('FPA, equal power',       c.gray,   ':',  'd', 1.0);  st.mfc = c.gray;
    case 'AS_region', st = mk('AS, region-wide',        c.teal,   ':',  '>', 1.2);
    case 'MA_noAN',   st = mk('Proposed w/o AN',        c.red,    ':',  'x', 1.0);
    case 'FPA_noAN',  st = mk('FPA w/o AN',             c.gray,   ':',  '+', 1.0);
    % supplementary power-allocation study (former Fig. 8)
    case 'MA_EPA',    st = mk('Equal power, opt. {\it\alpha}', c.purple, '-', 'p', 1.0);
    case 'MA_fix',    st = mk('Equal power, {\it\alpha} = 0.5', c.dark,  '-', '>', 1.0);
    otherwise, error('scheme_style: unknown scheme %s', key);
end
end

function st = mk(name, color, ls, marker, lw)
st = struct('name', name, 'color', color, 'ls', ls, 'marker', marker, 'lw', lw, 'mfc', 'w');
end
