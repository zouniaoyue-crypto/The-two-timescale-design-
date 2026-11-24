function s = pa_schemes()
%PA_SCHEMES  Schemes of Fig. 6 of main.tex (2 x 2 power-allocation design, see
%   evaluate_schemes.m): the proposed design and the FPA, each with the power allocation of
%   Algorithm 1 and with equal power p_m = q = P_tot/N. For 'MA_eq', the positions are
%   designed by Algorithm 2 under equal power.
s = {'MA_full', 'MA_eq', 'FPA_full', 'FPA_eq'};
end
