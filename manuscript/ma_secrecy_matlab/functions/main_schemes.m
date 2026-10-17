function s = main_schemes()
%MAIN_SCHEMES  Schemes compared in Figs. 5 and 6 and Tables I and II of main.tex (see
%   evaluate_schemes.m): proposed, rate-oriented MA, antenna selection, the sparse FPA
%   spanning the movable region (aperture-matched fixed array), and the compact FPA. All
%   of them use the long-term power allocation of Algorithm 1, so that the comparisons
%   isolate the effect of the antenna positions.
s = {'MA_full', 'MA_rate', 'AS', 'SPA_full', 'FPA_full'};
end
