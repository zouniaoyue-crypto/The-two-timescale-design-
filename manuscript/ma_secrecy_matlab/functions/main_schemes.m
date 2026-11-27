function s = main_schemes()
%MAIN_SCHEMES  Schemes compared in Figs. 5, 7, and 8 of main.tex (see evaluate_schemes.m).
%   The spatial information in the statistical CSI of Eve is exploited
%     MA_full  - through the antenna positions (proposed design),
%     MA_rate  - not at all by the MAs (rate-oriented MA [ZhengTCOM2025]),
%     FPA_ean  - through the AN direction of a fixed array (FPA with Eve-aware AN),
%     FPA_full - not at all by a fixed array (FPA with isotropic AN).
%   All of them use the long-term power allocation of Algorithm 1 (for FPA_ean with
%   psi_dir, rate_coeffs.m). The rev-8e benchmarks (Eve-nulling MA 'MA_null', APS) and the
%   rev-7 benchmarks (AS, sparse FPA) remain available in evaluate_schemes.m.
s = {'MA_full', 'MA_rate', 'FPA_ean', 'FPA_full'};
end
