function s = main_schemes()
%MAIN_SCHEMES  Schemes compared in Figs. 5 and 6 and Table II of main.tex (see
%   evaluate_schemes.m): proposed, rate-oriented MA, antenna selection, and the compact
%   FPA. All of them use the long-term power allocation of Algorithm 1, so that the
%   comparisons isolate the effect of the antenna positions. The sparse FPA ('SPA_full')
%   is also evaluated by the simulation scripts but only quoted in the text.
s = {'MA_full', 'MA_rate', 'AS', 'FPA_full'};
end
