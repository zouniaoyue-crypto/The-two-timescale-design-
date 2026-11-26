function s = main_schemes()
%MAIN_SCHEMES  Schemes compared in Figs. 5, 7, and 8 of main.tex (see evaluate_schemes.m):
%   the proposed design and four benchmarks, each of which isolates one aspect of it:
%     MA_rate  - rate-oriented MA [ZhengTCOM2025]: decorrelates the LUs, ignores Eve
%     MA_null  - Eve-nulling MA: decorrelates Eve from the LUs, ignores the LU correlation
%     APS      - alternating position selection [HuTVT2025]: the proposed objective with the
%                MAs restricted to a lambda/2 grid (discrete positions)
%     FPA_full - compact lambda/2 UPA (no movement)
%   All of them use the long-term power allocation of Algorithm 1, so that the comparisons
%   isolate the effect of the antenna positions. AS and the sparse FPA (rev-7) remain
%   available in evaluate_schemes.m for the supplementary scripts.
s = {'MA_full', 'MA_rate', 'MA_null', 'APS', 'FPA_full'};
end
