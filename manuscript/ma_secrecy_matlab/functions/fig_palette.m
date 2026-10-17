function c = fig_palette()
%FIG_PALETTE  Colors of all figures: a muted palette (brick red, steel blue, teal, ochre,
%   purple) with neutral grays for the reference schemes. The colors that appear together
%   in a figure pass the color-vision-deficiency separation and contrast checks of a CVD
%   simulator, and every series also has its own marker and line style, so that the
%   figures remain readable in grayscale print.
c.red    = hex('B03A2E');     % proposed design, Eve (Fig. 3), 20 dB (Fig. 4)
c.blue   = hex('2E6DB4');     % rate-oriented MA, LUs (Fig. 3), 10 dB (Fig. 4)
c.teal   = hex('2A9D8F');     % antenna selection
c.ochre  = hex('C7852B');     % sparse FPA
c.purple = hex('7B5EA7');     % equal power, optimized alpha (Fig. 7)
c.gray   = [0.43 0.43 0.43];  % FPA (reference), MM only (Fig. 4)
c.dark   = [0.23 0.23 0.23];  % equal power, alpha = 0.5 (Fig. 7)
end

function rgb = hex(h)
rgb = [hex2dec(h(1:2)) hex2dec(h(3:4)) hex2dec(h(5:6))]/255;
end
