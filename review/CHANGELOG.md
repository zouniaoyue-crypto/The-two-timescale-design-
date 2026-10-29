# Changelog — merge of 01_original (Claude) and 02_revised (GPT/Codex)

Line numbers refer to `manuscript/main.tex` after the merge. Issue IDs refer to `review/ISSUES.md`.
Code paths are relative to `manuscript/ma_secrecy_matlab/`.

| ID | file:line | What | Why |
|---|---|---|---|
| I15 | main.tex:51 | Abstract rewritten around how the nonconvex problem is solved ("To solve this nonconvex stochastic problem, we first …, where …"); all constraints named; purpose of the AO algorithm stated | CLAUDE.md supervisor rules; v1 was chronological with a "Since…" clause, v2 hedged |
| I32 | main.tex:55 | Index Terms alphabetical | IEEE style (S-F1) |
| I15 | main.tex:66–68 | Intro P2 ends "…remains unexplored."; contributions start "In this paper"; own-voice explanations removed | CLAUDE.md intro flow |
| I32 | main.tex:70 | Notation: proper complex Gaussian, ⪰ ordering, ∅, ∖; "with respect to" | symbols used later were undefined |
| I19 | main.tex:162, 172 | Mutual-coupling sentence and footnote: i.i.d. NLoS is an idealization; D_min ≥ λ/2 reduces but does not remove correlation | v2 rigor point, stated concisely |
| I18 | main.tex:207 | Statistical CSI of Eve attributed to [13] ("Following [13], we assume …") | [15] senses Eve's direction; it does not make this assumption |
| I20 | main.tex:229 | "an achievable ergodic secrecy rate … is given by" | precise wording (S-B3) |
| I1, I4 | main.tex:303–310 | Old Lemma 1 removed: exact Jensen bound (eq:lujensen) followed by the central-Wishart replacement cited to [16, Sec. IV-A] | math style: known results inline; exact and approximate steps separated |
| I1 | main.tex:320 | Old Lemma 2 (conditional independence) is now Lemma 1 (only new exact statement kept as lemma) | math style |
| I2 | main.tex:334 | Moment replacement justified without conditional-only concentration; "neither an upper nor a lower bound" (concave in X, convex in Y) | v2 rigor point, verified (law of total variance) |
| I1, I3 | main.tex:351 | Prop. 1 states only exact properties (range, exactness at κ_m = 0, asymptotic exactness for linearly independent LoS as K = κK₀, κ → ∞) | approximations presented as derivations (App. B) |
| I5, I37 | main.tex:372–378 | Remark 2: identity X̄₁ + Ȳ = N; (28) written as d = A(N + 1/(κ₁+1) − c₁); residual (c₁ − 1)/((N−1)(κ₁+1)+1) ∈ [−1/4, 1/4] | exact identity from v2; bound proved and checked numerically; one-line display keeps 14 pages |
| I38 | main.tex:385 | (29) split over two lines | number was pushed to its own line |
| — | main.tex:387 | "the antenna positions affect only the constant term" (was "affect the approximate ESSR only through the constant term") | same meaning, one line shorter |
| I21 | main.tex:402 | F ≤ approximate ESSR at any feasible point | v2 rigor point (x ≤ [x]⁺) |
| I14 | main.tex, notation.tex | Symbols renamed (ς→S, ϑ→χ, ϱ→κ, ϖ/τ/o_m removed, Υ/χ_m removed, l_n→ℓ_n, D_u→Λ_u, I_max→N_AO, I_in→N_MM, I_b→N_b, J→N_bt, P_I→P_s, G→F⋆, ε_e→Δ_err, Q→Ũ); all macros moved to notation.tex | CLAUDE.md glyph and one-meaning rules |
| I6 | main.tex:484–501 | "global search"/"basin" claims replaced by "grid search" with the rank-one O(M²) evaluation | claims were unsupported; grid resolution checked (I40) |
| I7 | main.tex:546 (Alg. 2), 563 | Stopping tests normalized by max{1,\|F\|} | matches ao_optimize.m:22, position_sweep.m:65 |
| I8 | main.tex:563 | Convergence concerns the objective value only | no stationarity or global-optimality claim |
| I9 | main.tex:572–576, 631; plot_fig7.m | Δ called "AoD offset" (offset in (θ, φ) coordinates); Fig. 7(a) relabeled | gen_scenario.m defines Δ in coordinates, not as a physical angle |
| I31 | main.tex:576 | Grid spacing λ/10 is at most one fifth of the shortest phase period | ‖a_j − a_i‖ ≤ 2 gives period ≥ λ/2 |
| I40 | main.tex:576; extra_grid_check.m; results/extra_grid_check.mat; run_all.m | Grid-halving sentence now backed by a script and results file | CLAUDE.md rule 3 |
| I11, I12, I13 | main.tex:574–576 | 10⁴ samples in Fig. 3; AS ranks subsets on a 21-point q grid; standard error 0.55% | code (fig3_accuracy.m, as_select.m) and fig5_snr.mat |
| I22, I39 | main.tex:590 | Eve-rate errors 0.052/0.013; 18.98 vs 20.75; gap range corrected from 1.53–1.77 to 1.52–1.76 | recomputed by verify_numbers.m |
| I26 | main.tex:601 | "99% of their total increase within 15 iterations" | fig4_convergence.mat |
| I27 | main.tex:629 | Sparse FPA outperforms the rate-oriented MA "for N ≥ 14" | curves coincide at N = 12 within MC error |
| I25, I28 | main.tex:645–647 | EP benchmark positions: MM over the currently positive terms; 20-dB PA values "(not shown in Fig. 7(b))" | code (position_sweep.m plus-flag); fig7_pa_hetero.mat |
| I16 | main.tex:651 | TIN Eve: "all the schemes with AN … at most 1.53" | w/o AN increases by 13.3 |
| I17 | main.tex:769 | Chen et al.: IEEE TWC 2026 with verified DOI only (no unverified vol./pages); Xie et al.: arXiv:2601.14755 | reference rule 4 |
| I23 | plot_fig7.m, power_opt.m, position_sweep.m, evaluate_schemes.m, results_dir.m, fig_style.m | v2 code adopted: scheme lookup by name, feasibility asserts, best of both q grids, gridStep = 0 handling, MA_RESULTS_DIR / MA_PLOT_FONT | robustness; outputs unchanged (rerun reproduces stored drops exactly) |
| I41 | *.m comments, plot_fig3.m, plot_fig7.m, results/fig3*.png, fig7*.png | Comments cite main.tex labels; Fig. 3 legend "closed form"; Fig. 7 labels "AoD offset Δ", "Fading spread S"; Figs. 3 and 7 replotted from stored results | terminology and numbering consistency |
| I41, I42, I43 | readme.tex/readme.pdf | Equation numbers remapped from main.aux; symbols/terms updated; overclaim removed; extra_grid_check and verify_numbers documented | consistency with the final manuscript |
| I43 | verify_numbers.m | New script printing every Section V number next to its recomputed value | CLAUDE.md rule 3 |
| I24 | — | Rejected from v2: numerical-failure thresholds, rank-deficient policy, implementation-complexity caveats, repeated "does not establish" hedges, verbose Algorithms 1–2 | not paper content / over-hedging |
