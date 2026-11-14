function w = text_width(str, fs)
%TEXT_WIDTH  Width (inches) of a one-line label in Times at fs points, computed from the
%   advance widths of the Adobe Times-Roman font metrics (Times New Roman and Liberation
%   Serif have nearly identical widths). This keeps the legend layout identical in MATLAB
%   and Octave, whose on-screen text extents depend on the display resolution.
%   TeX markup is interpreted approximately: {\it ...} and braces are ignored, Greek
%   letters (e.g., \alpha) take the Symbol-font widths, and sub-/superscripts (_x, ^{xy})
%   are scaled by 0.7. A margin of 3% is added.
persistent tab
if isempty(tab)
    tab = 500*ones(1, 128);                                   % default (digits, etc.)
    up  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    wUp = [722 667 667 722 611 556 722 722 333 389 722 611 889 722 722 556 722 667 556 611 722 722 944 722 722 611];
    lo  = 'abcdefghijklmnopqrstuvwxyz';
    wLo = [444 500 444 500 444 333 500 500 278 278 500 278 778 500 500 500 500 333 389 278 500 500 722 500 500 444];
    tab(double(up)) = wUp;  tab(double(lo)) = wLo;
    pun = ' !"#$%&''()*+,-./:;<=>?@[\]^_';
    wPu = [250 333 408 500 500 833 778 333 333 333 500 564 250 333 250 278 278 278 564 564 564 444 921 333 278 333 469 500];
    tab(double(pun)) = wPu;
end
greek = {'alpha', 631; 'beta', 549; 'gamma', 411; 'delta', 494; 'Delta', 612; ...
         'kappa', 549; 'lambda', 549; 'mu', 576; 'nu', 521; 'sigma', 603; 'theta', 521; ...
         'rho', 549; 'xi', 493; 'Xi', 645; 'phi', 521; 'pi', 549; 'eta', 603};
s = regexprep(str, '\\(it|rm|bf)\s*', '');                 % font switches
w = 0;  i = 1;  scale = 1;  n = numel(s);  subEnd = 0;
while i <= n
    ch = s(i);
    if i > subEnd, scale = 1; end
    if ch == '{' || ch == '}'
        i = i + 1;  continue;
    elseif ch == '_' || ch == '^'                             % sub-/superscript
        scale = 0.7;
        if i < n && s(i + 1) == '{'
            k = find(s(i+1:end) == '}', 1);  subEnd = i + k;  % until the closing brace
        else
            subEnd = i + 1;
        end
        i = i + 1;  continue;
    elseif ch == '\'
        tok = regexp(s(i+1:end), '^[A-Za-z]+', 'match', 'once');
        g = find(strcmp(greek(:, 1), tok), 1);
        if ~isempty(g), w = w + scale*greek{g, 2}; else, w = w + scale*500; end
        i = i + 1 + numel(tok);  continue;
    end
    c = double(ch);
    if c < 128, w = w + scale*tab(c); else, w = w + scale*600; end
    i = i + 1;
end
w = 1.03 * w/1000 * fs/72;
end
