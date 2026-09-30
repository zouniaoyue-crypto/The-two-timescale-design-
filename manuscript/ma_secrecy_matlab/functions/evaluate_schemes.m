function out = evaluate_schemes(sc, prm, schemes, seed)
%EVALUATE_SCHEMES  Optimizes the given schemes for one scenario (statistical CSI only)
%   and evaluates them by Monte Carlo simulation of the exact ZF/null-space-AN rates.
%
%   schemes : cell array with entries among
%     'MA_full'  - proposed: MA positions + long-term power allocation {p_m}, q (Algorithm 2)
%     'MA_EPA'   - MA positions + equal user power, power-splitting factor alpha only
%     'MA_noAN'  - MA positions + {p_m}, no AN (q = 0)
%     'FPA_full' - lambda/2 UPA + {p_m}, q optimized (Algorithm 1)
%     'FPA_EPA'  - lambda/2 UPA + equal user power, alpha optimized
%     'FPA_noAN' - lambda/2 UPA + {p_m}, q = 0
%     'SPA_full' - sparse UPA spanning the region C + {p_m}, q optimized
%   out.<scheme> has fields essr (Monte Carlo ESSR), Rb, Re, F (approximate ESSR),
%   anfrac ((N-M) q / P_tot), T, p, q, hist.

if nargin < 4, seed = 1; end
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
        case {'MA_full', 'MA_EPA', 'MA_noAN'}
            mode = lower(name(4:end));          % 'full', 'epa' or 'noan'
            best = -inf;
            for i = 1:numel(inits)
                [Ti, pi_, qi, hi] = ao_optimize(sc, inits{i}, prm, mode);
                if hi(end) > best
                    best = hi(end);  T = Ti;  p = pi_;  q = qi;  hist = hi;
                end
            end
        case {'FPA_full', 'FPA_EPA', 'FPA_noAN'}
            T = Tupa;
            [p, q] = power_opt(sc, T, prm, lower(name(5:end)));
        case 'SPA_full'
            T = upa_positions(N, prm.upaRows, prm.upaCols, sc.A/(prm.upaCols - 1), sc.A/(prm.upaRows - 1));
            [p, q] = power_opt(sc, T, prm, 'full');
        otherwise
            error('unknown scheme %s', name);
    end
    [Rb, Re, essr] = mc_rates(sc, T, p, q, prm.S, seed);
    r.essr = essr;  r.Rb = Rb;  r.Re = Re;
    r.F = objective_F(sc, T, p, q, true);
    r.anfrac = (sc.N - sc.M)*q/sc.P;
    r.T = T;  r.p = p;  r.q = q;  r.hist = hist;
    out.(name) = r;
end
end
