function [F, Rb, Re] = objective_F(sc, T, p, q, plusFlag)
%OBJECTIVE_F  Approximate ergodic secrecy sum rate.
%   F  = sum_m [ Rb_m - Re_m ]            (objective of (P3), [.]^+ dropped)
%   F  = sum_m [ Rb_m - Re_m ]^+          if plusFlag = true (eq. (24))
%   Rb_m = log2(1 + eta_m p_m)                        (eq. (15))
%   Re_m = log2(1 + xi_m p_m / (q psi + sbar_e^2))    (eq. (23))

if nargin < 5, plusFlag = false; end
[eta, xi, psi] = rate_coeffs(sc, T);
p  = p(:);
Rb = log2(1 + eta .* p);
Re = log2(1 + xi .* p / (q*psi + sc.sbe));
if plusFlag
    F = sum(max(Rb - Re, 0));
else
    F = sum(Rb - Re);
end
end
