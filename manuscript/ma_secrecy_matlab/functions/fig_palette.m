function c = fig_palette()
%FIG_PALETTE  Colors of all figures: the Okabe-Ito palette with a darker purple (Tol), which
%   remains distinguishable for the common color-vision deficiencies (checked with a CVD
%   simulator), complemented by a neutral gray for the FPA reference. Every series also has
%   its own marker and line style, so that the figures remain readable in grayscale print.
c.verm   = [213  94   0]/255;     % proposed design
c.blue   = [  0 114 178]/255;     % rate-oriented MA, LUs (Fig. 3), 10 dB (Fig. 4)
c.green  = [  0 158 115]/255;     % antenna selection
c.purple = [170  51 119]/255;     % equal power, optimized alpha (Fig. 7; Tol's purple)
c.sky    = [ 86 180 233]/255;     % sparse FPA (not plotted)
c.gray   = [0.38 0.38 0.38];      % FPA (reference), MM only (Fig. 4)
c.dark   = [0.15 0.15 0.15];      % equal power, alpha = 0.5 (Fig. 7)
c.tint   = @(col, a) 1 - a*(1 - col);   % light tint of a color for marker faces
end
