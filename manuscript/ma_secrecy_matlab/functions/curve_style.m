function [lw, mfc, ms] = curve_style(st, s)
%CURVE_STYLE  Line width, marker face color, and marker size of the style st (defaults of
%   fig_style). Star markers (pentagram, hexagram) are enlarged by 1.4, because at the same
%   nominal size they look much smaller than circles, squares, and triangles. An explicit
%   field st.ms overrides the marker size.
lw = s.lw;  mfc = 'w';  ms = s.ms;
if isfield(st, 'lw') && ~isempty(st.lw), lw = st.lw; end
if isfield(st, 'mfc') && ~isempty(st.mfc), mfc = st.mfc; end
if isfield(st, 'marker') && any(strcmp(st.marker, {'p', 'pentagram', 'h', 'hexagram'})), ms = 1.4*s.ms; end
if isfield(st, 'ms') && ~isempty(st.ms), ms = st.ms; end              % explicit marker size
end
