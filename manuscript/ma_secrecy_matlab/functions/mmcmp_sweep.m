function [T, deltaLast, st] = mmcmp_sweep(sc, T, p, q, prm, deltaLast, opt, st)
%MMCMP_SWEEP  Copy of position_sweep.m (mode 'full') with instrumentation (st) and
%   opt.stage1 (true/false) and opt.mode = 's0' (Stage 2 of main.tex: MM with backtracking,
%   identical to position_sweep.m), 's1best' (MM with the fixed oracle curvature
%   sup_C ||Hess F||), 's1zheng' (surrogate of [ZhengTCOM2025]: Lemma 1 and the closed-form
%   curvature for the LU terms, mmcmp_zheng_lu.m; second-order Taylor bound with the largest
%   curvature over C for the Eve terms, mmcmp_hess_sup.m; the concave subproblem is solved
%   numerically, by sqp in Octave or fmincon in MATLAB), or 'none' (Stage 1 only).
N = sc.N;
if isempty(deltaLast), deltaLast = prm.delta0*ones(N,1); end
xs = -sc.A/2 : prm.gridStep : sc.A/2;  [X, Y] = meshgrid(xs, xs);  G = [X(:).'; Y(:).'];
for n = 1:N
    if opt.stage1
        t0 = tic;
        idx = [1:n-1, n+1:N];
        D2 = (repmat(G(1,:), N-1, 1) - repmat(T(idx,1), 1, size(G,2))).^2 + ...
             (repmat(G(2,:), N-1, 1) - repmat(T(idx,2), 1, size(G,2))).^2;
        C  = [G(:, all(D2 >= sc.Dmin^2, 1)), T(n,:).'];
        Fc = objective_F_n(sc, T, n, C, p, q, false);
        [~, k] = max(Fc);
        if Fc(k) > Fc(end), T(n,:) = C(:,k).'; end
        st.tS1 = st.tS1 + toc(t0);
    end
    if strcmp(opt.mode, 'none'), continue; end
    switch opt.mode
        case 's1best'
            t0 = tic;  LF = mmcmp_hess_sup(sc, T, n, p, q, G, 0.005);  st.tOr = st.tOr + toc(t0);
            st.curv(end+1) = LF;
        case 's1zheng'
            t0 = tic;  [~, LE] = mmcmp_hess_sup(sc, T, n, p, q, G, 0.005);  st.tOr = st.tOr + toc(t0);
            st.curv(end+1) = LE;
    end
    t0 = tic;
    Fcur = objective_F(sc, T, p, q, false);
    for it = 1:prm.mmMaxIter
        F0 = Fcur;  st.mmIt = st.mmIt + 1;
        [Acon, bcon] = lin_constraints(sc, T, n);
        tn = T(n,:).';
        switch opt.mode
            case 's0'
                g = grad_F_n(sc, T, p, q, n, []);
                delta = max(prm.delta0, deltaLast(n)/2);  accepted = false;
                for k = 1:60
                    st.evals = st.evals + 1;
                    tnew = proj_polygon(tn + g/delta, Acon, bcon, tn);
                    Tn = T;  Tn(n,:) = tnew.';
                    Fnew = objective_F(sc, Tn, p, q, false);
                    if Fnew >= Fcur + g.'*(tnew - tn) - delta/2*sum((tnew - tn).^2) - 1e-12
                        accepted = true;  break;
                    end
                    delta = 2*delta;
                end
                if accepted, st.curv(end+1) = delta; end
                if accepted && Fnew >= Fcur, st.step(end+1) = norm(tnew - tn);  T = Tn;  Fcur = Fnew;  deltaLast(n) = delta; end
            case 's1best'
                g = grad_F_n(sc, T, p, q, n, []);
                tnew = proj_polygon(tn + g/LF, Acon, bcon, tn);  st.evals = st.evals + 1;
                Tn = T;  Tn(n,:) = tnew.';  Fnew = objective_F(sc, Tn, p, q, false);
                if Fnew >= Fcur, st.step(end+1) = norm(tnew - tn);  T = Tn;  Fcur = Fnew;  else, st.viol = st.viol + 1;  break; end
            case 's1zheng'
                Z = mmcmp_zheng_lu(sc, T, n, p);
                hh = 1e-6;  Pe = [tn + [hh;0], tn - [hh;0], tn + [0;hh], tn - [0;hh], tn];
                [~, ~, sRe] = mmcmp_parts_n(sc, T, n, Pe, p, q, false);
                E0 = -sRe(5);  gE = -[(sRe(1) - sRe(2)); (sRe(3) - sRe(4))]/(2*hh);
                phi  = @(x) -( mmcmp_zheng_eval(Z, x) + E0 + gE.'*(x - tn) - LE/2*sum((x - tn).^2) );
                dphi = @(x) -( lu_grad(Z, x) + gE - LE*(x - tn) );
                hfun = @(x) [Acon*x - bcon; lu_arg(Z, x) - 1e-9];
                if it == 1                                   % effective curvature of the surrogate at t_l
                    hs = 1e-4;  f0 = phi(tn);
                    fx1 = phi(tn + [hs;0]);  fx2 = phi(tn - [hs;0]);  fy1 = phi(tn + [0;hs]);  fy2 = phi(tn - [0;hs]);
                    fxy = (phi(tn + [hs;hs]) - phi(tn + [hs;-hs]) - phi(tn + [-hs;hs]) + phi(tn + [-hs;-hs]))/(4*hs^2);
                    Hs = [(fx1 - 2*f0 + fx2)/hs^2, fxy; fxy, (fy1 - 2*f0 + fy2)/hs^2];
                    st.curvEff(end+1) = max(abs(eig((Hs + Hs.')/2)));
                end
                [tnew, info] = solve_sub(tn, phi, dphi, hfun);
                st.solver = st.solver + 1;  st.info(end+1) = info;  st.evals = st.evals + 1;
                Tn = T;  Tn(n,:) = tnew(:).';  Fnew = objective_F(sc, Tn, p, q, false);
                if Fnew >= Fcur - 1e-12, st.step(end+1) = norm(tnew(:) - tn);  T = Tn;  Fcur = max(Fnew, Fcur);  else, st.viol = st.viol + 1;  break; end
        end
        if Fcur - F0 < prm.mmTol*max(1, abs(Fcur)), break; end
    end
    st.tS2 = st.tS2 + toc(t0);
end
end

function g = lu_grad(Z, x)
[~, g] = mmcmp_zheng_eval(Z, x);
end

function a = lu_arg(Z, x)
[~, ~, a] = mmcmp_zheng_eval(Z, x);
end

function [x, info] = solve_sub(x0, phi, dphi, hfun)
% Minimizes phi subject to hfun(x) >= 0 (Octave: sqp; MATLAB: fmincon, Optimization Toolbox).
if exist('OCTAVE_VERSION', 'builtin') ~= 0
    [x, ~, info] = sqp(x0, {phi, dphi}, [], hfun, [], [], 200, 1e-10);
else
    o = optimoptions('fmincon', 'Algorithm', 'sqp', 'SpecifyObjectiveGradient', true, ...
                     'Display', 'off', 'MaxIterations', 200, 'OptimalityTolerance', 1e-10, ...
                     'StepTolerance', 1e-12);
    fun = @(x) deal(phi(x), dphi(x));
    con = @(x) deal(-hfun(x), []);
    [x, ~, info] = fmincon(fun, x0, [], [], [], [], [], [], con, o);
end
end
