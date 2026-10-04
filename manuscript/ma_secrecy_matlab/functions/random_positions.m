function T = random_positions(sc)
%RANDOM_POSITIONS  Random feasible MA positions in C = [-A/2, A/2]^2 satisfying the
%   minimum-distance constraint (sequential rejection sampling with restarts).
%   Uses the current state of the random number generator.
for restart = 1:100
    T = zeros(sc.N, 2);
    n = 0;  tries = 0;
    while n < sc.N && tries < 2000
        c = (rand(1, 2) - 0.5) * sc.A;
        tries = tries + 1;
        if n == 0 || all(sqrt(sum((T(1:n,:) - repmat(c, n, 1)).^2, 2)) >= sc.Dmin)
            n = n + 1;  T(n,:) = c;
        end
    end
    if n == sc.N, return; end
end
error('random_positions: could not place %d MAs in the region (A = %g, Dmin = %g)', sc.N, sc.A, sc.Dmin);
end
