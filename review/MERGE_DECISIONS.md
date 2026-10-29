# Merge decisions — v1 (01_original, Claude) vs v2 (02_revised, GPT/Codex)

Both versions were reviewed independently; v2 was treated as a reference, not as ground truth.
Each row gives the final choice and the check that supports it (D = derivation, C = code,
R = results file, X = executed check). Details: `review/ISSUES.md`, `review/VALIDATION.md`.

| # | Location | v1 | v2 | Final | Evidence |
|---|---|---|---|---|---|
| 1 | Abstract | chronological, long "Since…" clause | cautious, list-like, hedged | new version organized around solving the nonconvex problem; names all constraints; states what the AO algorithm is for; 14.8% gain | CLAUDE.md style; R fig5_snr.mat |
| 2 | Intro, contributions | strong, partly redundant with the abstract | heavy caveats | flow topic → MA → overlooked → closest work → "remains unexplored" → "In this paper …" | CLAUDE.md style |
| 3 | LU ergodic rate (old Lemma 1) | lemma asserting "≈" | separates Jensen bound and Wishart replacement | v2 idea, written inline: exact Jensen bound (eq:lujensen), then the replacement cited to [16] | D; math-style rule |
| 4 | Conditional independence | Lemma 2 | same | kept as Lemma 1 (exact, new); App. A proof with Ũ = [w̄_m, U] | D |
| 5 | Eve-rate approximation | justified by conditional concentration | adds unconditional variances; not a bound | v2 rigor, one sentence: concave in X, convex in Y, hence neither bound; accuracy shown in V-B | D (law of total variance); R fig3_accuracy.mat (max error 0.052) |
| 6 | Prop. 1 | states the approximation | exact properties | exact properties only, incl. linear independence of the LoS vectors; (23)–(24) derived in App. B | D (Woodbury, asymptotics) |
| 7 | Remark 2 (M = 1) | c₁, d formulas | identity X̄₁+Ȳ = N, "requires verification" | identity + exact residual (c₁−1)/((N−1)(κ₁+1)+1) ∈ [−1/4, 1/4]; (28) as affine function of c₁ | D; X (2×10⁵ random cases, max 0.247) |
| 8 | Position update | "global search", basin claims | "grid search", no basin claims | grid search + MM, rank-one O(M²) evaluation; basin claims removed | X extra_grid_check (λ/20: +0.011%) |
| 9 | Stopping rules | "fractional increase" | increase / max{1,\|F\|} | v2 (as implemented) | C ao_optimize.m:22, position_sweep.m:65 |
| 10 | Convergence claim | "converges" | objective value only | objective value only; no stationarity/global-optimality claim | D (monotone, bounded) |
| 11 | Symbols | ς, ϖ, ϑ, ϱ, Υ, o_m, two epsilons, clashes | new symbols I_m, v_m^wf, … | one consistent set, macros in notation.tex | CLAUDE.md glyph rules |
| 12 | Δ | "angular separation" | "coordinate-angle offset" | "AoD offset" (in (θ, φ) coordinates) | C gen_scenario.m |
| 13 | Simulation setup | 5×10³ samples everywhere; SE 0.5% | 10⁴ in Fig. 3; SE 0.55%; AS 21-point ranking | v2 values | C fig3_accuracy.m, as_select.m; R fig5_snr.mat (0.545%) |
| 14 | V-B accuracy | qualitative | adds maximum errors | errors 0.052/0.013; ESSR 18.98 vs 20.75; gap 1.52–1.76 (corrected from 1.53–1.77 in the merge draft) | R fig3_accuracy.mat, fig5_snr.mat via verify_numbers.m |
| 15 | V-C convergence | "about 15 iterations" | — | "99% of the total increase within 15 iterations" | R fig4_convergence.mat (10–15) |
| 16 | V-E sparse FPA | "for N ≥ 12" | — | "for N ≥ 14" | R extra_num_antennas.mat (N = 12: +0.11, SE 0.20) |
| 17 | V-G EP benchmark | — | MM over positive terms | one clause | C position_sweep.m |
| 18 | V-H TIN Eve | "all schemes … at most 1.6" | "schemes with AN" | "schemes with AN … at most 1.53" | R fig5_snr.mat (1.534; w/o AN +13.3) |
| 19 | Eve CSI assumption | cites [15] | — | cites [13]; [15] only for sensing | reference text check |
| 20 | References | Chen as arXiv | Chen in TWC with vol./pages | TWC 2026 with DOI only; Xie arXiv:2601.14755 | DOI/arXiv lookup; vol./pages not verifiable |
| 21 | Extra v2 text | — | failure thresholds, rank-deficient policy, implementation caveats, repeated hedges, verbose Algs. 1–2 | rejected | not paper content; supervisor style |
| 22 | Code | — | name-based lookup, asserts, best-of-both q grids, env. variables | adopted | X: rerun reproduces the stored Fig. 5 drops exactly |
| 23 | Results | v1 .mat files | v2 .mat files | v1 files kept (identical to v2 within MC noise by scheme name); only Figs. 3 and 7 replotted (labels) | X comparison by scheme name |
