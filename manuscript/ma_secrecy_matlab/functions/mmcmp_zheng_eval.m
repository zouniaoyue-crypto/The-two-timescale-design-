function [val, grad, arg] = mmcmp_zheng_eval(Z, t)
%MMCMP_ZHENG_EVAL  Value and gradient of sum_m log2(1 + p_m C_m (chi_m + h_m(t_l) + g_m^T d - xi_m/2 ||d||^2)),
%   d = t - t_l; arg returns the arguments 1 + p_m C_m (.) (must stay positive).
d = t(:) - Z.tl;  val = 0;  grad = zeros(2,1);  arg = ones(numel(Z.act),1);
for k = 1:numel(Z.act)
    m = Z.act(k);
    qd = Z.chi(m) + Z.h0(m) + Z.g(:,m).'*d - Z.xi(m)/2*(d.'*d);
    a = 1 + Z.p(m)*Z.C(m)*qd;  arg(k) = a;
    val = val + log2(max(a, realmin));
    grad = grad + Z.p(m)*Z.C(m)*(Z.g(:,m) - Z.xi(m)*d)/(a*log(2));
end
end
