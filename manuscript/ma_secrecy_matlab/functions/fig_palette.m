function c = fig_palette()
%FIG_PALETTE  Colors of all figures: four muted hues (brick red, steel blue, teal, ochre)
%   and a charcoal for the reference FPA. One color identifies one scheme in all figures
%   (Figs. 4-8: red for the proposed design and Algorithm 2), the line style identifies the
%   array type, and black is reserved for analytical marks. All pairs of these colors pass
%   the OKLab separation checks under normal vision and simulated color-vision deficiency,
%   and the contrast check against white; every series also has its own marker, so that
%   the figures remain readable in grayscale print.
c.red    = hex('B03A2E');     % proposed design, Algorithm 2 (Fig. 4), Eve (Fig. 3)
c.blue   = hex('2E6DB4');     % rate-oriented MA, LUs (Fig. 3)
c.teal   = hex('2A9D8F');     % FPA with Eve-aware AN (APS, AS in the supplementary scripts)
c.ochre  = hex('C7852B');     % supplementary scripts only (Eve-nulling MA, sparse FPA)
c.gray   = hex('3D3D3D');     % charcoal: FPA (reference), MM only (Fig. 4)
c.black  = [0 0 0];           % analytical marks (high-SNR prediction, Fig. 5(b))
c.purple = hex('7B5EA7');     % supplementary only: equal power, optimized alpha
c.dark   = [0.23 0.23 0.23];  % supplementary only: equal power, alpha = 0.5
end

function rgb = hex(h)
rgb = [hex2dec(h(1:2)) hex2dec(h(3:4)) hex2dec(h(5:6))]/255;
end
