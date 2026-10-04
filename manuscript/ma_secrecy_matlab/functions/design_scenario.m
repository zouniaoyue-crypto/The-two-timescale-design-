function scD = design_scenario(prm, sc, seed)
%DESIGN_SCENARIO  Statistical CSI available at the BS for the true scenario sc. With
%   prm.eveAoDErr = 0 (default), it equals sc. Otherwise, the AoD of Eve known at the BS
%   deviates from the true one by prm.eveAoDErr (rad) in a random direction (robustness
%   study of Section V-D):
%       theta_e_hat = theta_e + err cos(phi0),  phi_e_hat = phi_e + err sin(phi0),
%   where phi0 ~ U[0, 2 pi) is drawn with its own seed, so that the same direction is
%   used for all values of err and the other random streams are not affected.
if ~isfield(prm, 'eveAoDErr') || prm.eveAoDErr == 0
    scD = sc;
    return;
end
rng(seed + 50021);
phi0 = 2*pi*rand;
err = prm.eveAoDErr;
scD = build_scenario(prm, sc.th, sc.ph, sc.th_e + err*cos(phi0), sc.ph_e + err*sin(phi0));
end
