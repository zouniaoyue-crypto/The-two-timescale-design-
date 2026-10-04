function out = evaluate_schemes(sc, prm, schemes, seed, scTrue)
%EVALUATE_SCHEMES  Optimizes the given schemes for one scenario (statistical CSI only)
%   and evaluates them by Monte Carlo simulation of the exact ZF/null-space-AN rates.
%   sc is the statistical CSI available at the BS, which is used for the design. The
%   optional scTrue (default: sc) is the true scenario used for the Monte Carlo
%   evaluation, e.g., when the AoD of Eve known at the BS is erroneous (design_scenario.m).
%
%   schemes : cell array with entries among
%     'MA_full'  - proposed: MA positions + long-term power allocation {p_m}, q (Algorithm 2,
%                  best of prm.numInit initializations)
%     'MA_rate'  - rate-oriented MA [ZhengTCOM2025]: positions maximize the ergodic sum
%                  rate (Eve ignored), then {p_m}, q optimized by Algorithm 1
%     'MA_noAN'  - MA positions + {p_m}, no AN (q = 0)
%     'MA_EPA'   - MA positions + equal user power, power-splitting factor alpha optimized
%     'MA_fix'   - MA positions + equal user power, fixed alpha = prm.alphaFix
%     'FPA_full' - compact lambda/2 UPA + {p_m}, q optimized (Algorithm 1)
%     'SPA_full' - sparse UPA spanning the region C + {p_m}, q optimized
%     'AS'       - antenna selection: N of the 2N antennas of a lambda/2 UPA are selected
%                  by exhaustive search based on the statistical CSI (as_select.m),
%                  then {p_m}, q optimized by Algorithm 1
%     'AS_region'- antenna selection as 'AS', but the 2N candidate antennas form a UPA that
%                  spans the movable region C (spacing A/(asCols-1) x A/(asRows-1))
%   out.<scheme> has fields essr (Monte Carlo ESSR, worst-case Eve), essr_tin (Eve treating
%   the other LUs' signals as noise), Rb, Re, F (approximate ESSR),
%   anfrac ((N-M) q / P_tot), T, p, q, hist.

if nargin < 4, seed = 1; end
if nargin < 5, scTrue = sc; end
N = sc.N;
Tupa = upa_positions(N, prm.upaRows, prm.upaCols, 0.5);
upaFits = all(abs(Tupa(:)) <= sc.A/2 + 1e-12);
% initial positions of Algorithm 2: UPA (if it fits in C) + random feasible positions
rng(seed + 7919);
inits = {};
if upaFits, inits{end+1} = Tupa; end
while numel(inits) < prm.numInit
    inits{end+1} = random_positions(sc); %#ok<AGROW>
end
for k = 1:numel(schemes)
    name = schemes{k};
    hist = [];
    switch name
        case {'MA_full', 'MA_EPA', 'MA_noAN', 'MA_fix'}
            mode = lower(name(4:end));          % 'full', 'epa', 'noan' or 'fix'
            best = -inf;
            for i = 1:numel(inits)
                [Ti, pi_, qi, hi] = ao_optimize(sc, inits{i}, prm, mode);
                if hi(end) > best
                    best = hi(end);  T = Ti;  p = pi_;  q = qi;  hist = hi;
                end
            end
        case 'MA_rate'
            T = rate_oriented_positions(sc, inits, prm);
            [p, q] = power_opt(sc, T, prm, 'full');
        case 'FPA_full'
            T = Tupa;
            [p, q] = power_opt(sc, T, prm, 'full');
        case 'AS'
            T = as_select(sc, prm);
            [p, q] = power_opt(sc, T, prm, 'full');
        case 'AS_region'
            Tc = upa_positions(prm.asRows*prm.asCols, prm.asRows, prm.asCols, ...
                               sc.A/(prm.asCols - 1), sc.A/(prm.asRows - 1));
            T = as_select(sc, prm, Tc);
            [p, q] = power_opt(sc, T, prm, 'full');
        case 'SPA_full'
            T = upa_positions(N, prm.upaRows, prm.upaCols, sc.A/(prm.upaCols - 1), sc.A/(prm.upaRows - 1));
            [p, q] = power_opt(sc, T, prm, 'full');
        otherwise
            error('unknown scheme %s', name);
    end
    [Rb, Re, essr, st] = mc_rates(scTrue, T, p, q, prm.S, seed);
    r.essr = essr;  r.Rb = Rb;  r.Re = Re;
    r.essr_tin = st.essr_tin;                  % eavesdropper treating interference as noise
    r.F = objective_F(sc, T, p, q, true);      % approximate ESSR as predicted at the BS
    r.anfrac = (sc.N - sc.M)*q/sc.P;
    r.T = T;  r.p = p;  r.q = q;  r.hist = hist;
    out.(name) = r;
end
end
