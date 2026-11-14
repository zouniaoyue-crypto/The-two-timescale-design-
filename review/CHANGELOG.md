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

## Round rev-4 — logical flow and writing quality (line numbers refer to `manuscript/main.tex` after this round)

| ID | file:line | What | Why |
|---|---|---|---|
| I45 | main.tex:51 | Abstract rewritten (260 → 190 words) | TCOM limit 75–200 words; supervisor template |
| I46 | main.tex:55 | Index Terms reduced to five | TCOM: up to five keywords |
| I47, I48 | main.tex:64–72 | Introduction reorganized into five paragraphs (144/170/139/159/167 words; before 315/147/346); insight sentence now contrasts with [16]; tense/parallelism fixed | readability; no duplication of the abstract |
| I49 | main.tex:213 | Protocol paragraph: explicit forward reference to (p, q); g̃ named | clarity |
| I50 | main.tex:256 | Redundant sentence after (P1) removed | (9b) already contains ∀H(t) |
| I51 | main.tex:245, 262–264 | "short-timescale" → "small-timescale" | consistent with Fig. 2 |
| I53 | main.tex:168, 339, 455, 528 | "Since" → "Because" for new reasons | supervisor connector rule |
| I54 | main.tex:180, 227, 374 | Voice alternation for K; explicit antecedent in II-C; Remark 1 split | one idea per sentence |
| I52 | main.tex:337–363 | Lemma 1 discussion split into interpretation and approximation; "we approximate" (no dangling participle); \kappa_{\mathrm e} in ξ_m, ψ; [16], [19] cited for the ZF approximations | logic, typography, accuracy |
| I55 | main.tex:510 | Grid-spacing sentence states why a numerical check is needed | logical link |
| — | main.tex:176 | Footnote 1 rephrased (semicolon splice removed) | style |
| — | main.tex:281, 291, 568 | "In addition"; restriction sentence reordered; "this guarantee concerns the objective value only" | flow, precision |
| I56 | main.tex:583, 632, 650–652 | AS sentence split; "AS with the compact candidate array"; S defined first; "(see Proposition 2)"; parenthetical 20-dB note | clarity, consistent references |
| I57 | main.tex:614 | Fig. 5 caption harmonized | caption consistency |
| I58 | main.tex:665 | Conclusion: guarantee stated precisely; no "and" chain | accuracy |
| — | main.tex:676–696 | Appendix B: five wording trims (scaling invariance referenced to Sec. III-C, "as in [19]", "including those captured", "trace of (57)", compact bound) | concision; keeps 14 pages |
| I59 | main.tex:791–797 | Ngo2013 and Horn2013 bibitems swapped | numbering in order of first citation |
| I60 | main.tex (prose) | Benchmark naming unified | terminology consistency |

## Round rev-4b — sentence-level IEEE language pass (de-templating)

Scope: every prose paragraph from the Introduction to Appendix B (the abstract, which follows the supervisor template, is unchanged).
Invariants checked: all 52 displayed equations, all 55 citations, all inline mathematics and all numbers are unchanged
(script comparison plus the academic-humanizer `check_invariants.py`, which also confirmed 18 protected technical terms);
the only reference changes are "Remarks 1–3" added in Sec. III-D and two redundant references to Secs. IV-A/IV-B and
Algorithm 2 removed. Label numbering unchanged; 14 pages; no overfull boxes or undefined references.

| ID | file:line | What | Why |
|---|---|---|---|
| I62, I65 | main.tex:64–72 | Introduction: "thus complements", "Both techniques, however, ...", "promising" removed, connector-free sentence for [16]/[17], "reduces the cost of evaluating each grid point", "less AN power" | template cues, vague intensity |
| I62 | main.tex:166–260 | Section II: "must be separated by at least D_min", causal "so that" for the LoS phase, "follows Rician fading and is given by", protocol sentence merged, worst-case model split into guarantee + SINR sentences, "which maps the instantaneous CSI ...", "which yields a deterministic problem" | clarity, fewer "i.e." and participial tails |
| I62, I63 | main.tex:264–410 | Section III: "The AN therefore causes ...", "whereas w̄_m and P⊥ are updated ...", restriction stated with a colon, LoS-gain sentence merged, Lemma 1 discussion rewritten with one condition per variance, "Remarks 1–3 show ...", Remark 1 mechanisms as cause → effect, "so that reducing the leakage is equivalent to ...", (P3) justification with a colon | logic, readability |
| I62, I64 | main.tex:412–572 | Section IV: "two structures that simplify its optimization", derivative lead-in, "the quadratic equation ... in p", "Equation (36) can therefore be regarded ...", "oscillates on the scale of a wavelength", two-stage sentence, "Consequently, once Γ_n⁻¹ and r_n are available ...", convergence paragraph without "Note that" | precision, connectors |
| I62, I64 | main.tex:579–660 | Section V: "so that ... is the transmit SNR", "Eve thus lies well within ...", paired-comparison sentence, "isolates the gain", "agrees ... within maximum absolute errors", explicit cause of the underestimation, "This fast convergence results from ...", "is consistent with the AN-saving effect", "substantially improves", "optimized for the assumed AoDs" | observation → reason without stock openers; claim strength |
| I66 | main.tex:665 | Conclusion: "Building on this approximation ...", "is left for future work" | stock phrasing |
| I66 | main.tex:671–678 | Appendices A–B: connectors ("Since", "Because", "As a result"), "We also use ...", "These are two separate approximations" | stock phrasing |

## Round rev-4c — advisor's annotated PDF (Part I: simulations; Part II: 67 comments, whole-text rewrite)

Line numbers refer to `manuscript/main.tex` after this round. Equation numbers changed: (5) and (7) are new
displays of y_m and y_e, (28)–(29) display the LoS correlations, (41) displays the KKT conditions, and the
normalized matrix Ȟ was removed. All numbers in Section V are recomputed by `verify_numbers.m`.

| ID | file:line | What | Why |
|---|---|---|---|
| I67 | main.tex:590, 641; functions/as_metric.m, as_swap.m, as_select.m; extra_num_antennas.m; extra_as_swap_check.m; default_params.m; plot_fig6.m; results/extra_num_antennas*.mat, extra_as_swap_check.mat, fig6b_essr_antennas.png | AS for N ≥ 12 by a swap search with the exhaustive-search metric; validated for N ≤ 10; complete AS curve in Fig. 6(b); V-A/V-E text | advisor Part I-1 |
| I68 | main.tex:645, 653; plot_fig7.m; results/fig7a_essr_offset.png | rate-oriented MA drawn for M = 1 (coincides with the FPA); caption and text explain why; purpose of the Δ study stated | advisor Part I-2 |
| I69 | main.tex:645, 657–659; plot_fig7.m; replot_all.m; run_all.m; results/fig7b_pa_spread.png | Fig. 7(b) at 10 dB only, axis "Large-scale fading spread S"; V-G rewritten (purpose, setting, β_e, observations, 0/20-dB gains in text) | advisor Part I-3, comment 65 |
| I70 | main.tex (former V-H), 586, 70; run_all.m; verify_numbers.m; replot_all.m | Sec. V-H and its cross-references removed; robustness scripts kept behind `SUPPLEMENTARY` | advisor Part I-4, comment 67 |
| I71 | main.tex:51 | Abstract: insight as its own sentence; technical detail of the first step in the where-clause; "with guaranteed convergence" removed; comma before "subject to"; unambiguous result sentence | comments 1–5 |
| I72, I73 | main.tex:64–72 | Introduction rewritten: citations placed on PLS; fluid antennas removed; "Under fast fading" → CI-based statement; supported claim "high operational complexity" [16]; two-timescale sentence split; ZF-approximation logic stated step by step; contributions and simulation summary shortened | comments 6–23 |
| I85 | main.tex (bibliography) | WongTWC2021 removed (no longer cited); first-citation order verified | comment 9 |
| I77 | main.tex:166, 168 | N ≥ M + 1 as its own sentence; LoS phase sentence with the reference point stated; eq. (1) ends with a period; footnote on i.i.d. NLoS removed | comments 24, 25, 34 |
| I76 | main.tex:186–205, 211–213 | Protocol: statistical CSI sentence, frame/CI structure, no undefined (p, q) in text or Fig. 2, overhead sentence removed | comments 26–30 |
| I77 | main.tex:217–241 | Signal model: x displayed first with symbols defined after it; y_m (5) and y_e (7) displayed; coding over the CIs explained | comments 31, 33, 35, 36 |
| I74 | main.tex:253–262, 270–300 | 𝒲, "small-timescale policy" and w_m(H(t)), Σ(H(t)) removed; (P1) optimizes {w_m}, Σ with ∀H(t); III-A motivates ZF-AN by the missing CSI of Eve; restriction and lower bound stated | comments 32, 37, 38, 41–46 |
| I78 | main.tex:264 | Problem-difficulty paragraph rewritten | comments 39, 40 |
| I75, I80 | main.tex:303–325, 341–369, 675 | Ȟ removed: H(t) = (L(t) + H̃)B^{1/2} (17); Jensen bound (18) and Wishart step written with H(t); β̃_m defined like β̃_e; Lemma 1 discussion shortened; App. B sets B = I without loss of generality | comments 47–49 |
| I81, I84 | main.tex:371–418, 456 | Remarks 1–3 → Sec. III-D "Secrecy Mechanisms of the MAs" with run-in paragraphs 1)–3) before (P3) (now Sec. III-E); LoS correlations displayed as (28)–(29) with indices (i, k); equal-power case declared as insight only; EP [·]⁺ sentence moved to V-G; Remark 4 → text after Proposition 2 | comments 50, 51 |
| I82 | main.tex:419, 425–460, 488–535 | Sec. IV: properties paragraph; η_e,m definition; KKT conditions displayed (41); "as summarized in Algorithm 1"; (P3.2) difficulty via (28)–(29); local-trap sentence split; O(M²) vs O(NM² + M³); grid-spacing sentence stated positively; backtracking justified against a Hessian-based Lipschitz bound | comments 52–62 |
| I83 | main.tex:613; verify_numbers.m | "converges within about 15 iterations" | comment 63 |
| I61 | review/ISSUES.md | page limit closed: advisor allows up to 15 pages (now 14) | advisor Part II-1 |
| — | main.tex (whole text) | long sentences split (abstract scope sentence trimmed; intro, V-D, V-G, III-E); "Note that" in III-D removed; "switches off" → "allocates zero power to" | advisor Part II-2–4, 7 |
| — | ma_secrecy_matlab/readme.tex, readme.pdf | equation numbers remapped; AS swap search, Fig. 7(b), supplementary scripts, run times | consistency with main.tex |

## Round rev-5b — author's selection of the referee-style comments (`review/referee_report_rev5.pdf`)

Implemented comments 4, 6, 8, 9 (Fig. 4, Fig. 5(a), Fig. 6(a), Fig. 6(b), Fig. 7, captions), 10, 11, 12, 15, 16, 17, 18, and 21;
no comparison or parameter table (author). Line numbers refer to `manuscript/main.tex` after this round.

| ID | file:line | What | Why |
|---|---|---|---|
| I102 | main.tex:63 | "This separability is limited for an FPA array …" merged into the preceding sentence and cited to [2], [6]; [6] = Hu et al., IEEE SPL 2024 (Sec. I: the static steering vector of an FPA array "will weaken the secure beamforming gain because of the inherent spatial correlation over different (desired and undesired) steering angles"), moved to [6] in the bibliography (first-citation order; [2] alone only states that AN/precoding rely on channel differences); P3: "For secure transmission, however," → "By contrast, for secure transmission," | comment 17: uncited claim; double "however" |
| I89 | main.tex:65, 781–785 | AN-aided MA works added: joint precoding/AN covariance/positions with perfect CSI [13] (Tang et al., IEEE TCOM 2025, DOI 10.1109/TCOMM.2024.3465369, verified on Crossref) and null-space AN with MAs without the CSI of Eve [14] (Cheng et al., arXiv:2412.19656, verified on arXiv); limitation sentence covers [6], [12]–[15] and states that [15] uses statistical CSI of Eve only | comment 4: novelty positioning, AN-aided MA works; references approved by the author's selection of comment 4 |
| I89, I100 | main.tex:69–73 | Contributions as "First/Second/Third": problem (positions based on the statistical CSI of the LUs and Eve, unlike [15]); conditional independence and closed form (captures the LoS correlations, unlike [17], [18], [20]); AO algorithm and simulation results; one-sentence outline of Sections II–VI | comments 4 and 15 |
| I95 | main.tex:212, 271–281, 300, 326, 379, 455, 495, 510, 534, 712, 719 | "Hence" 18 → 5 (kept: (1) LoS phase, high-SNR slope, Prop. 2 proof, two deductions in App. B); III-B sentence with the suggested wording; other deductions as subordinate clauses or "so that"; "thus" kept at 13 (11 before) | comment 10 |
| I91 | main.tex:281 | Sentence justifying isotropic null-space AN (no knowledge of Eve required; focus on the positions), cited to [5], [21]. The report's wording "no knowledge of Eve in each CI" was not used, since AN shaped by the statistical CSI of Eve would not need it either | comment 6 (explanation only) |
| I103 | main.tex:331–337, 685 | Lemma 1 states the conditional means and the independence; the conditional variances and the concentration statement moved to App. A (no dummy symbol μ; equation numbers unchanged) | comment 18 |
| I96 | main.tex:344 | Paragraph after Lemma 1: main step → accuracy condition (weak NLoS components of Eve and the LUs, App. A) → asymptotic exactness with its condition (unchanged claim) → neither bound, evaluated in V-B | comment 11; the suggested "e.g., when κ_e X̄_m and κ_e Ȳ + N − M are large" was not used because X̄_m and Ȳ also vary with H̃ |
| I101 | main.tex:355, 374–386, 393–397, 443–452, 487, 578; notation.tex:46 | ρ_m(t) ≜ \|h̄_mᴴ(t)ḡ(t)\|/N defined once in III-D and used in (30) (c₁ = (κ₁Nρ₁² + 1)/(κ₁ + 1), same expression), V-A, V-F; "LoS array/weighted LoS correlations" unified; WF auxiliary ρ_m(ν) → μ_m(ν); Θ_m → Ξ_m (θ_m are AoDs); P⊥ macro without (t); convention for the arguments of F stated at (P3.2); N_bt → N_δ | comment 16 |
| I93 | main.tex:601–612 | V-A: setup / algorithm parameters / evaluation paragraphs; benchmarks as an itemized list (purpose of each); AS swap search and its validation in a footnote (numbers unchanged, extra_as_swap_check.mat) | comment 8 (no table) |
| I94, I108 | main.tex:587, 594, 613, 625, 637–646, 660–667; functions/plot_fig4–8.m, new_figure.m, as_select.m, default_params.m; rerun_as_swap.m | Fig. 4 x-axis 0–30; Fig. 5(a) inset at 20 ± 0.5 dB; Fig. 6(a) without region-wide AS; AS = swap search in all figures (re-run on the same drops and channel samples); Fig. 7 = (a) M = 3, (b) M = 1 with label "Rate-oriented MA = FPA"; new single-column Fig. 8 (PA vs S); captions with N, M, A, P_tot/σ², Δ | comment 9 (selected items) |
| I97, I106, I95 | main.tex:649–675 | V-D: mechanism sentences refer to Sec. III-D; "as predicted by (33)" → "which is consistent with (33)"; V-E: region-wide AS text removed, swap-search text moved to V-A; V-G: starts from the setting, EP [·]⁺ detail in a footnote, "Hence" removed; Fig. references updated | comments 10, 12, 21 |
| — | ma_secrecy_matlab/run_all.m, replot_all.m, fig6_region.m, extra_*.m, verify_numbers.m, readme.tex | extra_as_region moved to SUPPLEMENTARY; plot calls and figure numbers updated; verify_numbers checks the AS footnote, AN fractions and gains of all benchmarks, Fig. 6(a) AS gaps (MATLAB-compatible indexing) | consistency |
| I108 | ma_secrecy_matlab/results/fig5_snr.mat, fig6_region.mat, extra_angle_offset.mat, extra_single_user.mat, extra_num_antennas{,_N4,_N6,_N8,_N10}.mat | AS columns re-run with the swap search (`rerun_as_swap.m`, resumable per value; `extra_num_antennas([], [4 6 8 10], {'AS'})`), same drops and channel samples | one AS search in all figures; all Sec. V numbers unchanged (`verify_numbers`) |
| I109 | ma_secrecy_matlab/functions/new_figure.m | figures created without menu and tool bars | Octave (qt) shifted the first figure after `close all` down by 0.27 in and cut its x-label |
| — | main_preview.pdf; ma_secrecy_matlab/readme.tex, readme.pdf | rebuilt; readme: Fig. 3–8 numbering, AS swap search for all N, `rerun_as_swap.m`, `plot_fig8.m`, run times, long table rows split (no overfull box) | consistency |
