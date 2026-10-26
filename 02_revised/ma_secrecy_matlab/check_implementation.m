function check_implementation()
%CHECK_IMPLEMENTATION  Self-test of the implementation (about 1 minute):
%   1) analytical gradient (Appendix C) versus central finite differences, for all LUs
%      and for a subset of LUs (used by the equal-power benchmarks), and the rank-one
%      evaluation of F over candidate positions (objective_F_n) versus objective_F;
%   2) secrecy water-filling (Proposition 2): KKT conditions and power budget;
%   3) monotonic convergence of Algorithm 2;
%   4) closed-form rates (Lemma 1, Proposition 1) versus Monte Carlo.

here = fileparts(mfilename('fullpath'));
addpath(here);  addpath(fullfile(here, 'functions'));
prm = default_params();
prm.N = 6;  prm.M = 3;  prm.A = 3;  prm.kappa_dB = [10 5 0];  prm.beta_dB = [0 -3 -6];
sc = gen_scenario(prm, 1);
rng(2);
T = random_positions(sc);
p = [3; 20; 40];  q = 10;

% ---- 1) gradient check ----
worst = 0;  h = 1e-6;
for n = 1:sc.N
    g = grad_F_n(sc, T, p, q, n);
    for k = 1:2
        Tp = T;  Tp(n,k) = Tp(n,k) + h;
        Tm = T;  Tm(n,k) = Tm(n,k) - h;
        fd = (objective_F(sc, Tp, p, q) - objective_F(sc, Tm, p, q))/(2*h);
        worst = max(worst, abs(fd - g(k))/max(1e-6, abs(fd)));
    end
end
fprintf('1) max relative error of the analytical gradient: %.2e  (should be < 1e-5)\n', worst);
assert(worst < 1e-5, 'Analytical gradient fails the finite-difference check');
act = logical([1; 0; 1]);  worst = 0;               % gradient of the terms of LUs 1 and 3 only
for n = 1:sc.N
    g = grad_F_n(sc, T, p, q, n, act);
    for k = 1:2
        Tp = T;  Tp(n,k) = Tp(n,k) + h;
        Tm = T;  Tm(n,k) = Tm(n,k) - h;
        [~, Rbp, Rep] = objective_F(sc, Tp, p, q);
        [~, Rbm, Rem] = objective_F(sc, Tm, p, q);
        fd = (sum((Rbp - Rep).*act) - sum((Rbm - Rem).*act))/(2*h);
        worst = max(worst, abs(fd - g(k))/max(1e-6, abs(fd)));
    end
end
fprintf('   partial gradient (subset of LUs): %.2e  (should be < 1e-5)\n', worst);
assert(worst < 1e-5, 'Partial analytical gradient fails the finite-difference check');
C = [T(2,:).', (rand(2, 50) - 0.5)*sc.A];             % candidate positions of MA 2
Fn = objective_F_n(sc, T, 2, C, p, q);  worst = 0;
for k = 1:size(C, 2)
    Tk = T;  Tk(2,:) = C(:,k).';
    worst = max(worst, abs(Fn(k) - objective_F(sc, Tk, p, q)));
end
fprintf('   rank-one evaluation of F over candidate positions (objective_F_n): max error %.2e\n', worst);
assert(worst < 1e-9, 'Rank-one and direct objective evaluations disagree');

% ---- 2) secrecy water-filling ----
[eta, xi, psi] = rate_coeffs(sc, T);
th = xi/(q*psi + sc.sbe);
PI = sc.P - (sc.N - sc.M)*q;
pw = secrecy_wf(eta, th, PI, 100);
act = pw > 1e-9;
fprime = (eta - th)./(log(2)*(1 + eta.*pw).*(1 + th.*pw));      % derivative (main.tex label eq:fm1)
nu = mean(fprime(act));
assert(any(act), 'KKT fixture must contain a secrecy-active user');
assert(all(pw >= 0) && sum(pw) <= PI + 1e-9 && abs(sum(pw) - PI) < 1e-8, ...
    'Water-filling violates nonnegativity or its signal-power budget');
assert((max(fprime(act)) - min(fprime(act)))/nu < 1e-7, ...
    'Active-user KKT derivatives do not agree');
assert(all((eta(~act) - th(~act))/log(2) <= nu*(1 + 1e-6)), ...
    'An inactive user violates the KKT derivative condition');
assert(all(secrecy_wf([1; 2], [2; 3], 10, 60) == 0), ...
    'No secrecy-active users must produce zero user powers');
assert(all(secrecy_wf([2; 3], [1; 1], 0, 60) == 0), ...
    'A zero signal-power budget must produce zero user powers');
fprintf('2) water-filling: power used %.6f of %.6f; spread of df/dp over active LUs %.2e;\n', sum(pw), PI, ...
        (max(fprime(act)) - min(fprime(act)))/nu);
fprintf('   inactive LUs satisfy df/dp(0) <= nu: %d\n', all((eta(~act) - th(~act))/log(2) <= nu*(1 + 1e-6)));

% ---- 3) monotonic convergence of Algorithm 2 (and of the equal-power variants) ----
[To, po, qo, hist] = ao_optimize(sc, T, prm, 'full');
assert(all(diff(hist) >= -1e-9), 'The AO objective history decreases');
assert(all(abs(To(:)) <= sc.A/2 + 1e-8));
D2 = (To(:,1) - To(:,1).').^2 + (To(:,2) - To(:,2).').^2;
D2(1:sc.N+1:end) = inf;
assert(all(D2(:) >= sc.Dmin^2 - 1e-8), 'AO violates minimum antenna spacing');
assert(all(po >= -1e-10) && qo >= -1e-10 && ...
    sum(po) + (sc.N - sc.M)*qo <= sc.P + 1e-8*max(1, sc.P));
fprintf('3) Algorithm 2: %d iterations, objective %.4f -> %.4f, monotone: %d\n', ...
        numel(hist) - 1, hist(1), hist(end), all(diff(hist) >= -1e-9));
modes = {'epa', 'fix'};
for i = 1:2
    [~, ~, ~, h2] = ao_optimize(sc, T, prm, modes{i});
    assert(all(diff(h2) >= -1e-9), 'An equal-power AO objective history decreases');
    fprintf('   mode ''%s'': %d iterations, monotone: %d\n', modes{i}, numel(h2) - 1, all(diff(h2) >= -1e-9));
end

% ---- 4) closed form versus Monte Carlo ----
[Rb, Re] = mc_rates(sc, To, po, qo, 20000, 3);
[Rba, Rea] = analytic_rates(sc, To, po, qo);
assert(all(isfinite([Rb; Re; Rba; Rea])) && all([Rb; Re] >= -1e-10), ...
    'The rate evaluator returns invalid values');
fprintf('4) LU rates   (MC / closed form): %s / %s\n', mat2str(Rb.', 3), mat2str(Rba.', 3));
fprintf('   Eve rates  (MC / closed form): %s / %s\n', mat2str(Re.', 3), mat2str(Rea.', 3));
fprintf('   ESSR       (MC / closed form): %.3f / %.3f\n', sum(max(Rb - Re, 0)), sum(max(Rba - Rea, 0)));
end
