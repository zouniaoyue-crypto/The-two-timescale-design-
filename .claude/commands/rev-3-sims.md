---
description: Phase 3 — audit simulation code vs paper, add approved experiments, regenerate figures in IEEE style
argument-hint: [IDs of approved experiments, e.g. E1 E2 E3]
---
Phase 3 (simulations). Approved new experiments: $ARGUMENTS. Run nothing beyond these.
1. Audit: compare every parameter, benchmark definition and evaluation step in the code with
   Section V and Sections II–IV (N, M, A, D_min, Rician factors, AoD model, Δ model,
   initializations, d_g, tolerances, number of AoD and channel realizations, exact-SINR
   evaluation, benchmark power allocation). List each mismatch with file:line; fix code or
   text only after telling me which side is wrong.
2. Sanity: rerun one existing figure at reduced realizations to confirm the pipeline and the
   trends; report runtime per point to estimate full runs.
3. Implement the approved experiments as separate scripts writing to `results/` (raw data
   saved, seeds fixed, parameters in one config). Run long jobs in the background and check on
   them; do not block the session.
4. Regenerate all figures from saved data with one shared style: vector PDF, column width
   3.5 in (or 7.16 in for double-column), fonts ≈ 8 pt after scaling, identical color/marker per
   scheme across all figures, colorblind-safe palette, legends not covering data, axis labels
   with units, symbols matching the (renamed) notation.
5. Update every number in Section V text from the results files (seed A3, D1–D5) and add the
   new subsections/figures/table with short, factual text: observation → reason.
6. Update ISSUES.md and CHANGELOG.md; compile; commit `rev-3: simulations`. Reply with a table:
   figure/experiment | status | key number | any change in conclusions.
