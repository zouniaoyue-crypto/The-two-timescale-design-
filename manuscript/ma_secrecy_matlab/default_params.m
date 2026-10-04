function prm = default_params()
%DEFAULT_PARAMS  Default simulation parameters (Section V of main.tex).
%   All lengths are normalized by the carrier wavelength (lambda = 1).
%   Powers are normalized by the noise power, i.e., P_dB = 10*log10(P_tot/sigma^2).

% ---------------- system ----------------
prm.N        = 8;        % number of MAs at the BS
prm.M        = 3;        % number of LUs
prm.lambda   = 1;        % carrier wavelength (normalization)
prm.A        = 4;        % side length of the square movable region C = [-A/2, A/2]^2 (in lambda)
prm.Dmin     = 0.5;      % minimum inter-MA distance (in lambda)
prm.upaRows  = 2;        % FPA benchmark: rows x cols UPA with lambda/2 spacing
prm.upaCols  = 4;
prm.asRows   = 4;        % AS benchmark: N antennas selected from a 4 x 4 UPA (2N candidates)
prm.asCols   = 4;        %   with lambda/2 spacing

% ---------------- channels ----------------
prm.kappa_dB  = 10;      % Rician factor of the LUs (scalar or 1 x M), dB
prm.kappae_dB = 10;      % Rician factor of Eve, dB
prm.beta_dB   = 0;       % large-scale fading of the LUs (scalar or 1 x M), dB
prm.betae_dB  = 0;       % large-scale fading of Eve, dB
prm.sigma2    = 1;       % noise power at the LUs
prm.sigma2e   = 1;       % noise power at Eve
prm.P_dB      = 20;      % P_tot / sigma^2 in dB
prm.angMax    = pi/3;    % LU AoDs theta_m, phi_m ~ U[-angMax, angMax]
prm.Delta     = 0.1;     % angular offset (rad) between Eve and LU 1
prm.eveAoDErr = 0;       % error (rad) of the AoD of Eve known at the BS (robustness study)

% ---------------- algorithms ----------------
prm.aoMaxIter  = 50;     % maximum number of AO iterations I_max (Algorithm 2)
prm.aoTol      = 1e-4;   % relative-increase stopping threshold epsilon of Algorithm 2
prm.gridStep   = 0.1;    % spacing of the candidate grid of the position search (in lambda);
                         %   0 disables the global search (pure MM updates)
prm.mmMaxIter  = 20;     % maximum number of MM iterations per MA and AO iteration
prm.mmTol      = 1e-6;   % relative-increase stopping threshold of the MM refinement
prm.delta0     = 1;      % smallest initial MM curvature parameter delta_0
prm.nGrid      = 41;     % grid size of the one-dimensional search (coarse and fine stage)
prm.nBisect    = 60;     % bisection iterations for the water level nu
prm.numInit    = 3;      % initializations of Algorithm 2: UPA + (numInit-1) random
prm.asGrid     = 21;     % coarse grid of q used to rank the antenna subsets of the AS benchmark
prm.alphaFix   = 0.5;    % fixed power-splitting factor of the equal-power benchmark (Fig. 7)

% ---------------- evaluation ----------------
prm.S          = 5000;   % Monte Carlo channel realizations per evaluation
prm.numDrops   = 100;    % random user/Eve drops per point
prm.seed       = 2026;   % base random seed
end
