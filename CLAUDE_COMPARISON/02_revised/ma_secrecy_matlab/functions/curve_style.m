function [lw, mfc] = curve_style(st, s)
%CURVE_STYLE  Line width and marker face color of the style st (defaults of fig_style).
lw = s.lw;  mfc = 'w';
if isfield(st, 'lw') && ~isempty(st.lw), lw = st.lw; end
if isfield(st, 'mfc') && ~isempty(st.mfc), mfc = st.mfc; end
end
