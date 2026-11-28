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

## Round rev-5c — simulation section: Fig. 7 and figure formatting

| ID | file:line | What | Why |
|---|---|---|---|
| I111 | main.tex:651–670 | Fig. 7: double-column figure (M = 3, M = 1) → single-column figure of the M = 1 panel (y-axis "Ergodic secrecy rate"); Fig. 7 now defined at the start of V-F and Fig. 8 at the start of V-G | M = 1 panel is the only support of the single-LU claim; the M = 3 panel repeats Figs. 5–6 at Δ = 0.1 rad |
| I111 | main.tex:660 | V-F rewritten: M = 1 first (rate-oriented MA = FPA; gain only from Eve-aware positioning; 9% / 79% / 33% at Δ = 0.02 / 0.2 / 0.5 rad; reasons for small and large Δ); M = 3 summarized (2.4% / 14.8% / 10.7% at Δ = 0.02 / 0.1 / 0.5 rad) | conciseness; numbers recomputed by verify_numbers (V-F block added) |
| I112 | ma_secrecy_matlab/functions/fig_style.m, manual_legend.m, place_legend.m (new), text_width.m (new), plot_fig3–8.m | all figure text 9 pt (was 8/9/7 pt); panels 3.5 × 2.6 in (was 3.5 × 2.45 in); markers 5 pt; curve widths 1.0 pt (proposed 1.2 pt); legends sized from Times-Roman glyph widths and placed at axes corners; Fig. 5(b) legend in the common style; y-limits adjusted where the larger legends would cover curves (Fig. 5(a) 0–40, Fig. 6(a) 14–26, Fig. 7 3–12) | IEEE journal graphics guidance (≈9–10 pt at final size; one column 3.5 in, two columns 7.16 in); identical layout in MATLAB and Octave |
| I113 | functions/plot_fig5.m | "Proposed w/o AN" labeled next to its curve; inset with 9-pt integer ticks and an in-plot "20 dB" label | legend width; readability |
| I112 | functions/save_figure.m | Octave PNGs: 600 dpi recorded in the header with ImageMagick (pixels unchanged) | Octave writes 72 dpi, which reads as a 29-in-wide image |
| — | replot_all.m, run_all.m, rerun_as_swap.m, extra_angle_offset.m, extra_single_user.m, main_schemes.m, verify_numbers.m, readme.tex/pdf; results/fig7_essr_offset.png (new), fig7a_essr_offset_M3.png and fig7b_essr_offset_M1.png (removed) | figure numbers, plot calls, and descriptions updated | consistency |

## Round rev-6a — synchronization with the author's reference version v7

| ID | file:line | What | Why |
|---|---|---|---|
| I114 | main.tex (whole file except Sec. V) | text, equations, preamble (revision marks \rev, red), and bibliography taken from main_revised_v7.tex: Lemma 1 and Proposition 2 turned into inline derivations, Remark 1 (Eve-aware AN) added, ζ_e⁻¹ replaces σ̄_e², \hat R replaces \tilde R, R_m replaces \bar R_m, r_m replaces y_m, F_m(p;q) replaces f_m(p;q), \varkappa in Prop. 1, new contribution paragraph, etc. | author's reference version (merge only) |
| I114 | main.tex (25 places) | reference notation \rev{\mathbf f}_m for the normalized ZF vector replaced by \wb_m (w̄_m) | author: keep the original ZF notation |
| I115 | main.tex:Sec. V-B, V-D, V-G | eq:esrapprox → $\sum_{m=1}^M\hat R_m^{\mathrm{sec}}$; eq:alphastar → "$\alpha^\star$ in Section~\ref{sec:insight}"; Proposition~\ref{prop:wf} → \eqref{eq:wf} (×2), worded as in the reference | labels removed by the synced Secs. III–IV; all other Sec. V text unchanged |
| I116 | main.tex (bibliography) | five new references from the reference, verified (arXiv ×4, OpenAlex/DOI ×1); ChenArxiv2026 "early access" | author's reference version |
| — | main_preview.pdf | rebuilt (14 pages, no errors, undefined references, or overfull boxes; citation order = bibliography order) | build check |

## Round rev-6b — Stage 2 review (read-only)

| ID | File:line | What | Why |
|---|---|---|---|
| I117–I140 | review/review_report.txt (new), review/ISSUES.md | Stage 2 review report (High: none; Medium: 4; Figure: 8; Low: 11) and issue entries, all "proposed" or "needs-decision" | author's instruction: report first, modify only after item-by-item approval; no change to main.tex or the code |

## Round rev-6c — implementation of the Stage 2 items approved by the author

| ID | File:line | What | Why |
|---|---|---|---|
| I117 (S-3a) | main.tex:567 | "Similar to [ChenArxiv2026]" → "\rev{As in} [ChenArxiv2026]" (v7 wording); \tilde\phi and the sentence on Δ kept | author: follow the report's recommendations |
| I117 (S-3b) | main.tex:569 | "is executed from ... and two sets" → "is initialized with ... and with two sets" (v7) | same |
| I117 (S-3d) | main.tex:592 | v7 wording ("confirms its accuracy at the optimized antenna positions", "In contrast", "all tested cases", gap "varies by less than 0.25 bps/Hz ... (from 1.52 to 1.76)"); ranking claim qualified: preserved at 20 dB and for P_tot/σ² ≥ 10 dB, below 10 dB only the order of the benchmarks differs | verify_numbers.m (fig5_snr.mat, F vs essr): spread 0.2406; rankings equal at every SNR ≥ 10 dB; proposed first at all SNRs |
| I117 (S-3g) + I119 (M-2) | main.tex:611 | "For P_tot/σ² ≥ 10 dB, the proposed design allocates less power to the AN than all the benchmarks, ..., because the optimized positions decrease Ξ_m(t) in (32)"; former last sentence merged (v7) | fig5_snr.mat (anfrac): at 5 dB 0.039 vs AS 0.004 and FPA 0.028 |
| I117 (S-3h) | main.tex:615 | "where the ESSRs of the FPA and AS do not depend on A" (v7) | grammar |
| I117 (S-3i) + I136 (L-7) | main.tex:617 | "for which the AN occupies a single dimension" (v7); N = 8 proposed vs N = 16 rate-oriented MA: "slightly outperforms" | extra_num_antennas.mat: +0.2275 bps/Hz, paired SE 0.080 |
| I117 (S-3j) | main.tex:628 | "can hardly" → "cannot effectively" (v7); sentence on the sparse FPA kept | author |
| I117 (S-3c, S-3f) | main.tex:576, 609 | no change (AS footnote and V-D benchmark explanations kept as recommended) | author |
| I118 (M-1) | main.tex:609; plot_fig5.m; fig5_snr.m:6 | sentence on the design without AN deleted; curve and direct label removed from Fig. 5(a) (MA_noAN still computed and stored in fig5_snr.mat, not plotted) | contradicted V-A (all schemes use Algorithm 1) |
| I120 (M-3) | main.tex:617 | "approaches the rate-oriented MA as N increases and slightly exceeds it for N = 16" | paired differences resolved only at N = 16 (+0.44, SE 0.18) |
| I121 (M-4) | main.tex:363, 685 | ϰ replaced: Proposition 1 "as κ_1 → ∞ with fixed ratios κ_m/κ_1 > 0, m ∈ M"; App. B "K = κ_1 K_0 with K_0 ≜ diag(1, κ_2/κ_1, ..., κ_M/κ_1) ≻ 0" (7 occurrences) | glyph next to κ_m; statement unchanged |
| I122 (F-0) | main.tex:571 | new sentence: at 20 dB, the standard error of the average ESSR difference between any two schemes does not exceed 0.22 bps/Hz | F-0(3), option "sentence in V-A"; max over the 10 pairs = 0.2167 |
| I122 (F-0) | main.tex:585, 598; functions/plot_fig5.m, plot_fig6.m, plot_legend_strip.m (new) | one-row legend shared by the two panels of Figs. 5 and 6 (results/legend_main_schemes, natural size, 9 pt); in-axes legends removed; y-ranges 5(a) [0, 35], 5(b) [0, 0.6], 6(a) [14, 24], 6(b) [10, 24]; inset of 5(a) moved into the freed upper-left area | F-0(2) |
| I122 (F-0) | functions/save_figure.m, plot_legend_strip.m | PNG export drops the ancillary chunks (pixels identical, files reproducible byte for byte); MATLAB path unchanged (vector PDF/EPS), legend strip drawn at box size in MATLAB | F-0(1); the 254-gray seen in the review renders is a pdftoppm downsampling artifact (images are DeviceRGB, pure white at native resolution) |
| I124 (F-2) | main.tex:196-219 | Fig. 2 redrawn: first block split into "Optimize t and powers (statistical CSI)" → "Move MAs"; braces state "t and powers fixed" (frame) and "precoders and AN updated" (CI); \footnotesize; wider last CI box | F-2; p, q, w̄_m, P⊥ are named in words because they are defined only in Sec. III-A |
| I128 (F-7) | extra_single_user.m; results/extra_single_user.mat; functions/plot_fig7.m | Δ = 0.4 rad added (Octave 8.4, same parameters and drop seeds as the stored points, merged by scheme name, old rows unchanged); in-figure annotation removed, both legend entries kept | F-7(a), (b) |
| I129 (F-8a) | functions/scheme_style.m, curve_style.m, plot_curve.m, manual_legend.m | EP benchmarks: pentagram (optimized α), right-pointing triangle (α = 0.5); star markers drawn 1.4× larger | F-8(a) |
| I131 (L-2) | main.tex:76 | "..., whereas most MA-enabled PLS designs assume that this delay is negligible or tolerable [YuArxiv2025]." | source, Sec. 2.2.2: "most of these investigations assume that the latency of antenna movement is negligible or tolerable" (MA PLS works) |
| I132 (L-3) | — | checked, no change | [ZhuArxiv2024NF] Sec. III-D: APV on statistical CSI, DBFM on instantaneous CSI (verbatim) |
| I135 (L-6) | main.tex:605 | "attains more than 95% of its total increase within three iterations, and converges within about 15 iterations" | fig4_convergence.mat: smallest fraction 0.9575 |
| I138 (L-9) | main.tex:628 | sparse FPA not monotonic in Δ: Eve approaches a grating lobe around Δ = 0.3 rad, which increases ρ_1(t) | extra_single_user.mat: 7.90 / 7.61 / 7.99 bps/Hz at Δ = 0.2 / 0.3 / 0.4; mean ρ_1 of the sparse FPA 0.279 / 0.319 / 0.319 / 0.252 at Δ = 0.2 / 0.25 / 0.3 / 0.4 |
| I139 (L-10) | notation.tex:45 | unused macro \sbe deleted | — |
| — | ma_secrecy_matlab/verify_numbers.m | new checks for every new or changed statement in Sec. V (paired SE, ranking, 95%, AN fraction ≥ 10 dB, crossover, N = 8 vs 16, Δ = 0.4, ρ_1 of the sparse FPA) | CLAUDE.md rule 3 |
| — | ma_secrecy_matlab/readme.tex, readme.pdf | updated: legend strip, Fig. 5 without the w/o-AN curve, Δ grid of Fig. 7, Fig. 8 markers, PNG export | documentation |
| — | results/*.png, main_preview.pdf | all figures replotted; manuscript rebuilt (14 pages; 0 errors, undefined references, overfull boxes, or LaTeX warnings) | build check |

## Round rev-7a — revision plan (no manuscript, code, or result changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I141–I151 | review/revision_plan_rev7.md (new), review/ISSUES.md | unified revision plan for questions (2)–(7): MM comparison with Zheng et al., feasibility and predicted impact, macro assessment, Δ, ergodic-approximation layers, sample size, benchmark redesign, Section V structure, Rician-factor figure | author's request: plan first, apply after approval |

## Round rev-7b — D1 verification and final selection (no manuscript or production-code changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I141 (D1) | review/experiments/rev7b_d1/ (new: experiment copies, d1_A/B/C.mat, logs, checks) | small-scale S0-vs-S1 verification: 10 drops at 20 dB; S0, Stage 1 only, S1-best (oracle curvature), S1-Zheng (Lemma 1 + closed-form curvature of Zheng et al.), and both without Stage 1 | author's request (D1 Q1–Q3) |
| I141–I151 | review/rev7b_d1_report.md (new) | answers to Q1–Q3, D2 recommendation, benchmark list, figure assignment (layout L-A′), legend label sets A/B/C with measured widths, final selection of D1–D11 | author's request; decisions delegated to Claude by the author on 2026-11-24 |
| I141–I151 | review/ISSUES.md:200–214 | decisions and statuses recorded (decided; implementation in rev-7c) | shared state |

## Round rev-7c/7d — execution of the rev-7 selection (decisions delegated by the author on 2026-11-24)

Simulations: all Section V results rerun in Octave 8.4 (100 drops, 10³ channel realizations; Fig. 3 unchanged with 10⁴), four to five parallel sessions, about 3.1 h. Every number below is printed by `ma_secrecy_matlab/verify_numbers.m`; the full output is in `review/verify_numbers_rev7.txt`.

| ID | File:line | What | Why |
|---|---|---|---|
| I145 (D5) | default_params.m | `S = 1000` (was 5000) | D5 |
| I147 (D7) | functions/power_opt.m (`'eq'`), ao_optimize.m, evaluate_schemes.m (`MA_eq`, `FPA_eq`), pa_schemes.m (new), scheme_style.m | equal-power benchmarks p_m = q = P_tot/N; dotted lines with filled markers in the color of the counterpart | D7 (2 × 2 design) |
| I142 (D2c) | functions/an_highsnr.m (new), evaluate_schemes.m (`anpred`), sweep_schemes.m, plot_fig5.m | high-SNR prediction 1 − α⋆ of the AN fraction (root of eq:alphastar), drawn as dotted saturation levels in Fig. 5(b) | D2(c) |
| I144 (D4) | ao_optimize.m (`iters`), fig4_convergence.m (`essrIt`), plot_fig4.m, fig_palette.m | Monte Carlo ESSR of the iterates (N = 8, 20 dB) in Fig. 4, purple with filled markers | D4 |
| I149 (D9) | fig5_snr.m, functions/plot_fig6.m (new), plot_fig7.m (was plot_fig6.m), fig7_region.m (was fig6_region.m) | layout L-A′: Fig. 5 (a) ESSR, (b) AN fraction; new one-column Fig. 6 (2 × 2 power allocation); Fig. 7 (A, N) | D9 |
| I151 (D11) | fig8_rician.m (new), functions/plot_fig8.m (new), sweep_schemes.m (`kappa_common`) | Fig. 8: ESSR vs. (a) κ = κ_m = κ_e, (b) κ_e | D11 |
| I142 (D2d) | extra_mm_compare.m (new), functions/mmcmp_*.m (new, ported from review/experiments/rev7b_d1) | Stage 2 vs. the surrogate of [ZhengTCOM2025], 100 drops | D2(d) |
| I143, I147 | functions/plot_offset.m, plot_pa_spread.m (renamed), extra_pa_hetero.m (was fig7_power_allocation.m), results/extra_pa_hetero.mat (renamed), run_all.m, replot_all.m | removed figures and sections kept as supplementary scripts (not rerun) | D3, D7 |
| — | extra_as_swap_check.m | ESSR of the exhaustive subset evaluated by Monte Carlo instead of read from extra_num_antennas_N<N>.mat, which hold swap subsets since the AS unification | the check would otherwise compare the swap search with itself |
| — | verify_numbers.m | rewritten for the new Section V; uses results_dir() | CLAUDE.md rule 3 |
| — | readme.tex, readme.pdf | new scripts, schemes, outputs, figures, run times; equation numbers updated to the current main.tex (they were stale: e.g., water-filling (40) → (37), "Proposition 2" removed) | documentation |
| — | results/ | new: fig6_essr_power, fig7a/7b, fig8a/8b PNGs, fig7_region.mat, fig8_rician_a/b.mat, extra_mm_compare.mat; rerun: fig4, fig5_snr, extra_num_antennas*, extra_random_eve_M3, extra_grid_check, extra_as_swap_check; removed: fig6_region.mat, fig6a/6b, fig7_essr_offset, fig8_pa_spread PNGs | reruns |
| — | main.tex:39–46 | revision marks: previous round accepted, this round in red | file convention |
| I142 (D2b) | main.tex:391 | III-D 2): ρ₁ = 0 optimal for any (p₁, q); sufficient region condition λ/(2‖a_e − a₁‖) + (N/2 − 1)D_min ≤ A (even N, D_min ≤ λ/(2‖a_e − a₁‖)); infeasible if λ/(2‖a_e − a₁‖) > √2 A | D2(b), exact remark without a figure |
| I142 (D2c) | main.tex:399 (eq:alphastar), 443 (eq:qstat) | III-D 3): α⋆ for unequal Ξ_m as the unique root of a strictly concave objective; IV-A: stationarity condition of q⋆ with its interpretation | D2(c) |
| I142 (D2a) | main.tex:507 | IV-B: backtracking terminates after at most 1 + ⌈log₂(L/δ₀)⌉⁺ trials; accepted δ_n ≤ max{δ₀, 2L} | D2(a) (short form; explicit constant omitted) |
| I150 (D10) | main.tex:573–650 | Section V regrouped: V-A Setup and Benchmarks; V-B Accuracy and Convergence (1), 2)); V-C Secrecy Performance Versus Transmit SNR; V-D Impact of System Parameters (1), 2)) | D10 |
| I145, I148, I147 | main.tex:577–587 | V-A: grid check 0.04% (rerun), standard errors 0.55% / 0.22, 10³ realizations, AS rationale ("reconfigures the array by switching instead of antenna movement"), equal-power benchmark item | D5, D8, D7 |
| I144, I142 (D2d) | main.tex:596–605, Fig. 4 caption | V-B 2): Monte Carlo ESSR along the iterations (15.82 → 20.70 bps/Hz, 1.61–1.76 above the objective); comparison with the surrogate of [ZhengTCOM2025]: objective within 0.1%, curvature ≈ 12×, MM iterations 2.6× | D4, D2(d) |
| I143 (D3), I147 (D7) | main.tex:607–629, Fig. 6 (new) | V-C: gains 14.8% / 31.1% at 20 dB; random-Eve gain 10.3%; AN fraction predictions 0.29 / 0.49 vs. 0.28 / 0.49 at 30 dB; Fig. 6 paragraph (equal-power loss 1.79–1.94 bps/Hz for the MAs, 1.83 → 0.64 for the FPA) | D3, D7 |
| I151 (D11) | main.tex:631–646, Fig. 8 (new) | V-D 2): Rician factors (spread < 0.04 bps/Hz at κ = −10 dB; gains 19.3% / 49.4% at κ = 20 dB; gain over the rate-oriented MA 1.0% → 17.0% from κ_e = −10 to 20 dB) | D11 |
| I143, I147 | main.tex (former V-F, V-G, Figs. 7–8) | removed: AoD-offset subsection and figure, power-allocation subsection and figure, heterogeneous-LU discussion | D3 (option C), D7 |
| — | main.tex:80, 651 | contributions and conclusion: "its gain persists for a single LU" (no longer simulated) → gain grows with the Rician factor of Eve | consistency with the new Section V |

## Round rev-8a — analysis of the author's figure guidelines and items 2.1–2.7 (no manuscript or production-code changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I152–I160 | review/revision_plan_rev8.md (new), review/ISSUES.md | point-by-point analysis and recommendations; unified plan and decision checklist | author's request |
| I152, I153, I155, I156, I159 | review/experiments/rev8a_figstyle/ (new: proto_figs.m, previews) | prototype of the proposed figure style on the stored rev-7 data (production plot code unchanged) | to decide on the figures by looking at them |

## Round rev-8b — implementation of the approved rev-8 plan (author's approval of all recommendations, 2026-11-26)

| ID | File:line | What | Why |
|---|---|---|---|
| I157 | main.tex:292 | pointer to Remark 1 replaced by one sentence on why the AN is isotropic (no CSI of Eve per CI, unknown eavesdroppers, attribution of the gain to the MAs) | plan §2.4 |
| I157 | main.tex (former 371–373) | Remark 1 (Eve-aware AN, `rem:an`) deleted | plan §2.4 |
| I158 | main.tex:398 | III-D 3): sentence linking (33) to [Zhou2010]: for M = 1 and κ_e = 0, Ξ₁ = 1 and α⋆ = 1/2, the equal split that is near-optimal for non-colluding eavesdroppers in Rayleigh fading | plan §2.5 |
| I154 | main.tex:571 | V-A: Eve's AoDs stated as θ₁ + 0.1 cos φ̃, φ₁ + 0.1 sin φ̃ (rad) without the symbol Δ; ρ₁ of the FPA exceeds 0.94 (verify_numbers V-A) | plan §2.1 |
| I154 | main.tex:557, 564, 592, 607, 615 | captions of Figs. 3–7: only swept or non-default parameters (N = 8, M = 3, A = 4λ, 20 dB, Δ removed where default; Fig. 7 keeps "with N = 8" / "with A = 4λ") | plan §2.1 caption rule |
| I155 | main.tex:564 | Fig. 4 caption: Monte Carlo clause and "lines without markers" removed | plan §2.2 |
| I155 | main.tex:598 | V-B 2): the three sentences on the Monte Carlo ESSR of the iterates removed | plan §2.2 (reverses D4/I144) |
| I159 | main.tex:592 | Fig. 5 caption: dotted-line clause replaced by "the high-SNR predictions in (b) are evaluated by (33) for the designs at 30 dB" | plan §2.6 |
| I158, I159 | main.tex:621 | V-C: predictions marked by crosses; they exceed the AN power fractions of Algorithm 1 at 30 dB by at most 0.011 for all five schemes although (33) assumes equal user power; α⋆ = 0.71 (proposed) vs. 0.51 (FPA, close to the equal split of [Zhou2010]) | plan §2.5–2.6; numbers from verify_numbers (V-C) |
| I158 | main.tex:623 | Fig. 6 paragraph: optimal AN fraction "(0.29 versus 0.49 for the FPA at 30 dB)" added | plan §2.5 echo |
| I152 | main.tex (Figs. 5, 7, 8 environments) | `\includegraphics{legend_main_schemes}` lines removed | plan §1.1 |
| I156 | main.tex:627–633 | Fig. 8 is a one-column figure (`fig8_essr_kappae`); caption "ESSR versus the Rician factor κ_e of Eve with κ_m = 10 dB" | plan §2.3 |
| I156 | main.tex:638 | V-D 2): common-κ result stated in text ("figure omitted for brevity"; < 0.04 bps/Hz at −10 dB; 19.3% and 49.4% at 20 dB); reference to Fig. 8 instead of 8(b) | plan §2.3; numbers from fig8_rician_a.mat |
| I157 | main.tex:643 | conclusion: joint design of the AN covariance and the antenna positions added to the future work | plan §2.4 |
| I154 | notation.tex:48 | unused macro `\Derr` deleted | plan §2.1 |
| I153 | functions/fig_palette.m, scheme_style.m | FPA (and Fig. 4 "MM only") charcoal 3D3D3D; proposed line width 1.4; black for analytical marks; header comments state the grammar (color = scheme, line style = array type) | plan §1.2 |
| I152, I159 | functions/plot_fig5.m | in-panel legends; inset moved to the lower right (label "20 dB" in its upper-right corner); (b) black × at 30 dB for all five schemes with legend entry, y 0–0.8 | plan §1.1, §2.6 |
| I155 | functions/plot_fig4.m; fig4_convergence.m | single-hue Algorithm 2 curves, N by line style, direct SNR labels, 3-entry legend, y-label "Objective value of (P3) (bps/Hz)"; the Monte Carlo evaluation of the iterates is no longer computed (each drop and random initialization has its own seed, so the other stored fields are unaffected) | plan §2.2 |
| I152 | functions/plot_fig7.m, plot_fig8.m (new signature `plot_fig8(resB)`), legend_rows.m (new); fig8_rician.m, replot_all.m | in-panel legends; Fig. 7(a) y 14–26; Fig. 8 one panel, y 12–22, legend lower left; `plot_legend_strip.m` and the PNGs `legend_main_schemes`, `fig8a_essr_kappa`, `fig8b_essr_kappae` deleted | plan §1.1, §2.3 |
| I153 | functions/manual_legend.m, curve_style.m | legend text aligned on the baseline (Octave centers 'middle' on the actual glyphs, which misaligned entries with and without descenders); optional explicit marker size `st.ms` | visual check of the replotted figures |
| — | results/fig3*–fig8*.png | all figures replotted from the stored results (no new main simulation) | plan §3 |
| I158, I159 | verify_numbers.m | Monte Carlo lines of V-B 2) removed; 30-dB predictions and AN fractions for all five schemes, largest/smallest difference, α⋆ of the proposed design and the FPA; V-D 2) labels "common kappa (text)" / "Fig. 8" | rule 3 |
| — | readme.tex/.pdf | Fig. 4, 5, 7, 8 descriptions, palette, legends, outputs, scheme table (FPA_noAN), new scripts; output table set with p-columns (it overflowed by 158 pt before) | documentation |
| I161–I164 | extra_num_users.m, extra_eve_beta.m, extra_no_an.m (new); extra_eve_aod_error.m, functions/design_scenario.m (stale "Section V-H" headers); functions/evaluate_schemes.m (`FPA_noAN`), scheme_style.m, plot_candidates.m (new); run_all.m (SUPPLEMENTARY block) | candidate comparisons requested by the author (not in main.tex); results and analysis in rev-8c | author's request |

## Round rev-8c — candidate comparisons and the author's items 1–3 (2026-11-26)

| ID | File:line | What | Why |
|---|---|---|---|
| I161–I164 | results/extra_num_users*.mat, extra_eve_aod_error.mat, extra_eve_beta.mat, extra_no_an.mat (new or rerun; S = 10^3, 100 drops) | full runs of the four candidate comparisons (about 55 min in four parallel sessions); M = 3, zero AoD error, and β_e = 0 dB reproduce Fig. 5 at 20 dB exactly | author's request |
| I161–I164 | review/experiments/rev8c_candidates/analyze_candidates.m, analysis.txt (new) | all numbers of the candidate text | rule 3 |
| I161–I164 | functions/plot_candidates.m; results/supp_essr_users, supp_essr_aod_error, supp_essr_betae, supp_essr_noan, supp_fig6_noan (.png) | candidate figures in the main-figure style | author's request |
| I161–I164 | main_candidates.tex/.pdf (new; 16 pages, clean build) | independent review copy of main.tex with the candidate text (blue, tagged [C1]–[C4]) and Figs. 9–13; Figs. 3–8 keep their numbers; main.tex unchanged by the candidates | author's request ("saved independently") |
| I165 | functions/plot_fig4.m | Fig. 4: SNR by color with color-matched labels "P_tot/σ² = 10 dB" and "P_tot/σ² = 20 dB"; legend (two columns) lists only the line styles in a neutral color; MM only in red (20 dB) dotted | author's item 1 |
| I166 | functions/plot_fig5.m; main.tex:592 (caption), main.tex:621 (V-C) | Fig. 5(b): black dotted high-SNR limit lines (15–30 dB) for the proposed design and the FPA, legend entry "High-SNR limit, (33)"; caption and text say "limits ... shown by dotted lines"; verify_numbers labels updated | author's item 2 |
| I167 | functions/fig_style.m, plot_fig3.m, plot_fig5.m, plot_fig7.m | two-column legends in all figures; legend font 8 pt (axes 9 pt), row 0.15 in, line samples 0.22 in, column gap 0.10 in | author's item 3 |
| I165–I167 | readme.tex/.pdf | Fig. 4/5/7 descriptions, style row (legend 8 pt), palette roles, supp_fig6_noan | documentation |
| — | results/fig3*–fig8*.png | replotted; main.tex rebuilt (14 pages, clean) | items 1–3 |


## Round rev-8d — author's selection (2026-11-26): C1 and C4 adopted, B1 adopted in minimal form, minor insights removed

| ID | File:line | What | Why |
|---|---|---|---|
| I161 | main.tex:629–635 | Fig. 8 becomes a figure* with (a) ESSR vs the number of LUs M (`fig8a_essr_users`) and (b) ESSR vs κ_e (`fig8b_essr_kappae`); label `fig:param` | C1 adopted |
| I161 | main.tex:641 | V-D 2) "Number of LUs": at M = 1 the rate-oriented MA equals the FPA (approximate rate of a single LU independent of t), the proposed design +77.2%; AN fraction 84% (FPA) vs 50%; gain over the rate-oriented MA 2.47–3.39 bps/Hz; gains over the FPA and sparse FPA grow for M ≥ 3 to 64.4% and 47.4% at M = 6; FPA saturates for M ≥ 5 (the drop from M = 5 to 6, −0.20 bps/Hz, is within its standard error 0.46, so no decrease is claimed); Rician item renumbered 3) and refers to Fig. 8(b) | C1 adopted; numbers in verify_numbers (V-D2) |
| I164 | main.tex:607 | Fig. 6 caption: "... with the power allocation of Algorithm 1, with equal power p_m = q = P_tot/N, and without AN (q = 0) ..." | C4 adopted (Fig. 10 layout) |
| I164 | main.tex:625 | V-C: paragraph on the no-AN curves (nearly coincide for ≤ 5 dB; saturation; AN gain 58.9% / 121.1% at 20 / 30 dB; MAs over FPA without AN 30.5–31.2% for ≥ 5 dB; complementary gains) | C4 adopted; numbers in verify_numbers (V-C) |
| I168 | main.tex:387 | III-D 2): the sufficient condition for ρ₁(t) = 0 (pairs of MAs), the infeasibility condition, and the conclusion on the required region size removed; the statement that any feasible t with ρ₁(t) = 0 maximizes the approximate secrecy rate is kept | minor insight not examined in Section V (author's guideline: highlight the core focus) |
| I168 | main.tex (checked, kept) | kept after the check: III-D 1) κ_e = 0 case (Fig. 8(b)); III-D 2) footnote on the exact rate for M = 1 (Fig. 8(a)); III-D 3) α⋆ = 1/2 link (analytical, referred to in V-C); IV-A interpretation of (38) (links to Fig. 5(b)); footnote on multiple non-colluding Eves (exact one-line extension of Algorithm 1, needs no simulation); IV-C complexity statements (analytical) | redundancy check |
| I161, I164 | functions/plot_fig6.m, plot_fig8.m (new signatures `plot_fig6(res, resN)`, `plot_fig8(resU, resB)`), scheme_style.m (labels "MA, no AN", "FPA, no AN"); fig5_snr.m, extra_no_an.m, extra_num_users.m, fig8_rician.m, replot_all.m, run_all.m (extra_no_an, table_mechanisms, extra_num_users moved to the main list; extra_eve_aod_error and extra_eve_beta stay supplementary) | Figs. 6 and 8 from the stored results (no new runs) | C1/C4 adopted |
| I168 | table_mechanisms.m (new), results/table_mechanisms.mat | ρ₁, normalized η_m, ξ_m, ψ, Ξ_m of the designs at 20 dB (same drops as Fig. 5; per-drop ESSRs identical to fig5_snr.mat) | B1 adopted |
| I168 | main.tex:619 | V-C: two sentences instead of a table (author's clarification: keep only what is necessary): ρ₁ 0.98 → 0.52, ξ₁ 54.5 → 24.7, ψ 13.3 → 58.3 (FPA → proposed); rate-oriented MA 0.83 / 53.4 / 25.6 | B1, minimal form |
| I168 | main.tex:380 | III-D 1): the explicit minimum of c_m(t) and maximum of d(t) (derivation not used or verified later) replaced by "both effects are strongest if v(t) = 0, i.e., ..." | author's guideline: delete derivations of little value that are not verified later |
| — | verify_numbers.m | lines for Fig. 6 (no AN), the mechanism numbers, Fig. 8(a); Rician lines relabeled V-D3 | rule 3 |
| — | readme.tex/.pdf | Figs. 6 and 8, Table I, scripts, scheme labels, outputs | documentation |

## Round rev-8e — benchmark suite: one FPA, APS instead of AS, Eve-nulling MA (author's items 1–4)

| ID | File:line | What | Why |
|---|---|---|---|
| I170–I173 | functions/main_schemes.m | suite {Proposed, rate-oriented MA, Eve-nulling MA, APS, FPA} | items 1, 2, 4 |
| I173 | functions/eve_nulling_positions.m (new), evaluate_schemes.m ('MA_null') | element-wise search over the Stage-1 grid minimizing ‖H̄ᴴ(t)ḡ(t)‖² (same initializations; best of them), then Algorithm 1 | item 4 |
| I171 | evaluate_schemes.m ('APS'), functions/snap_to_grid.m (new), default_params.m (apsStep = 0.5) | APS = Algorithm 2 with grid spacing λ/2 and mmMaxIter = 0; initializations snapped to the grid (no new random numbers) | item 2 |
| I170–I173 | functions/merge_schemes.m (new), extra_add_schemes.m (new), extra_num_antennas.m, extra_num_users.m (robust merge, optional scheme subset) | the two new schemes added to all stored sweeps with the same drops (about 12 min in four sessions); table_mechanisms rerun with the new suite | rule 3 (no other scheme rerun) |
| I170–I173 | functions/scheme_style.m, fig_palette.m, plot_fig5.m (inset now proposed vs APS), plot_fig7.m; results/fig3*–fig8*.png | styles: Eve-nulling MA ochre solid ▽, APS teal dash-dot △; figures replotted | items 1, 2, 4 |
| I170–I173 | main.tex:578–586 | V-A benchmark list: Eve-nulling MA and APS added (with [HuTVT2025] for APS), AS (and its swap-search footnote) and sparse FPA removed, "No AN" item added; rate-oriented MA described as exploiting only the LU decorrelation | items 1–4 |
| — | main.tex:597 | V-B 1): gap 1.57–1.76 bps/Hz (< 0.2 across the schemes); approximate and actual rankings coincide at all SNRs (new suite) | verify_numbers |
| I173 | main.tex:620 | V-C: Eve-nulling MA ρ₁ = 0.47, ψ = 56.9, η at 82% of its bound vs 98% (proposed); beats the rate-oriented MA for ≥ 10 dB, not at 0 dB; proposed +8.0% at 20 dB; "neither group of mechanisms suffices alone"; APS 0.5–1.5% below the proposed design; AS / sparse-FPA sentences and the aperture conclusion removed | items 1, 2, 4 |
| I173 | main.tex:622 | V-C: AN fraction of APS close to the proposed one, Eve-nulling MA in between (replaces "comparable to that of the FPA") | new suite |
| I170–I173 | main.tex:638, 640 | V-D 1): Eve-nulling MA above the rate-oriented MA for A ≥ 3λ and N ≥ 8, below for N = 4; APS within 0.7% for all A, gap 2.6% (N = 4) → 0 (N = 16); AS / sparse-FPA sentences removed | new suite |
| I173 | main.tex:642 | V-D 2): at M = 1 the Eve-nulling MA and APS match the proposed design (within 0.01 bps/Hz; confirms III-D 2)); Eve-nulling MA below the rate-oriented MA for M ≥ 5; gain over APS 3.5% at M = 6; sparse-FPA numbers removed | new suite |
| I173 | main.tex:644 | V-D 3): rate-oriented MA and FPA decrease with κ_e; Eve-nulling MA above the rate-oriented MA only for κ_e ≥ 5 dB, 5.4–8.5% below the proposed design | new suite |
| — | main.tex:649 | conclusion: benchmarks described as single-mechanism MA designs, discrete positions, and the FPA | new suite |
| — | verify_numbers.m, run_all.m (extra_as_swap_check moved to SUPPLEMENTARY), readme.tex/.pdf | numbers of the new text; documentation of the new schemes, tools and styles | rule 3 |
| I172 | — | PSO not implemented (decision, I172) | item 3 |

## Round rev-8f — benchmark analysis (no manuscript or production-code changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I174–I177 | review/rev8f_benchmark_plan.md (new) | analysis report and revision plan | author's request |
| I175, I176 | review/experiments/rev8f_benchmarks/ (new: pilot.m, shadow/rate_coeffs.m, pilot_output.txt) | APS grid check; approximate ESSR of the FPA with Eve-aware AN (ψ_dir = (N−M)(κ_e d + 1)) at 10/20/30 dB and κ_e = −10/0/20 dB | evidence for the decisions |

## Round rev-8g — final benchmark suite: Eve-nulling MA and APS removed, FPA with Eve-aware AN added, Fig. 6 split

| ID | File:line | What | Why |
|---|---|---|---|
| I174, I175 | functions/main_schemes.m, evaluate_schemes.m (docs) | main suite {Proposed, rate-oriented MA, FPA with Eve-aware AN, FPA}; 'MA_null' and 'APS' kept as supplementary schemes | author's approval of the rev-8f plan |
| I176 | functions/rate_coeffs.m | `sc.anDir`: ψ = (N−M)(κ_e d + 1) for the Eve-aware AN | benchmark definition |
| I176 | functions/mc_rates.m | `sc.anDirG`: exact received AN power of the rank-one AN, (N−M)\|gᴴP⊥ḡ\|²/‖P⊥ḡ‖² | exact Monte Carlo evaluation |
| I176 | functions/evaluate_schemes.m | case 'FPA_ean' (compact UPA; Algorithm 1 with ψ_dir; F and the high-SNR limit with ψ_dir; r.ReApprox stored) | new benchmark |
| I176 | functions/scheme_style.m, fig_palette.m | "FPA with Eve-aware AN" teal dashed △; labels "MA/FPA with equal power", "MA/FPA without AN"; ochre only in supplementary figures | I176, I177 |
| I176 | extra_add_schemes.m (default 'FPA_ean'), table_mechanisms.m (ψ_dir; ReMC, ReApprox, F stored), extra_ean_check.m (new), run_all.m | FPA_ean added to all stored sweeps on the same drops (other schemes unchanged); mechanism table rerun; AN-power oracle check | runs |
| I177 | functions/plot_fig6.m, pa_schemes.m, fig5_snr.m, extra_no_an.m (docs) | Fig. 6 split: fig6a_essr_power_eq (Algorithm 1 vs equal power) and fig6b_essr_power_noan (with vs without AN) | I177 |
| I181 | functions/plot_fig5.m (inset: rate-oriented MA vs FPA with Eve-aware AN; y 0–40; legend rows via legend_rows), plot_fig6.m (y 0–40), plot_fig7.m ((b) y 6–24), plot_fig8.m ((a) y 0–45, legend upper left); results/fig5–fig8 png | legends clear the curves | I181 |
| — | main.tex:80 | intro: "its gain over the MA design of [ZhengTCOM2025] grows with the Rician factor of Eve" | I179 |
| — | main.tex:292 | III-A: pointer to V-A; "does not depend on the CSI of Eve" (was "requires no CSI of Eve in each CI") | the Eve-aware AN also needs no instantaneous CSI of Eve |
| — | main.tex:575 | SE of paired differences ≤ 0.21 bps/Hz (eight schemes of Figs. 5–6) | verify_numbers |
| I174–I176 | main.tex:577–584 | V-A: "first three" adopt Algorithm 1 (differences from the positions and, for the Eve-aware AN, the AN direction); Eve-nulling MA and APS items removed; FPA item before the new "FPA with Eve-aware AN" item (Σ, received AN power and its conditional mean, ψ replaced by (N−M)(κ_e d+1) ≥ ψ); items renamed "MA and FPA with equal power", "MA and FPA without AN" | new suite |
| I178 | main.tex:596 | V-B 1): gap 1.57–1.76 for the isotropic-AN schemes; Eve-aware AN gap 1.11 (wiretap rates 2.18 vs 2.63, rank-one AN power fluctuates more); AN power of Algorithm 1 near-optimal (+0.09% by an oracle grid); rankings coincide except the two FPA schemes at 0 dB (0.01 bps/Hz) | verify_numbers |
| I177 | main.tex:604–610 | Fig. 6 as figure* with (a) fig6a_essr_power_eq and (b) fig6b_essr_power_noan; caption | I177 |
| I176 | main.tex:620 | V-C Fig. 5(a): gains 14.8/19.1/31.1% over the rate-oriented MA / FPA with Eve-aware AN / FPA; Eve-aware AN raises the normalized AN power at Eve to 46.4 (< 58.3 of the proposed design; Eve nearly orthogonal to the null space), ξ₁ stays 54.5; +10.1% over the FPA, below both MA designs at all SNRs; Eve-nulling and APS sentences removed | table_mechanisms, verify_numbers |
| — | main.tex:622 | V-C Fig. 5(b): limits exceed the AN fractions by at most 0.013 (four schemes; was 0.011); Eve-aware AN fraction 0.35 at 20 dB, below the FPA for ≥ 15 dB; APS / Eve-nulling sentence removed | verify_numbers |
| I177 | main.tex:624, 626 | "Fig. 6(a)", "Fig. 6(b)" | split |
| I179 | main.tex:638 | V-D 1) region: both FPA schemes independent of A; at A = 1.5λ the Eve-aware AN beats the rate-oriented MA and is 0.9% above the proposed design; gain 26.2% at A = 6λ; Eve-nulling / APS sentences removed | verify_numbers |
| I179 | main.tex:640 | V-D 1) N: two FPA schemes coincide at N = 4 (one-dimensional null space); Eve-aware AN gains most with N (its normalized AN power at Eve scales with N−M), beats the rate-oriented MA for N ≥ 12; gain of the proposed design over it 70.9% → 1.5%; Eve-nulling / APS sentences removed | verify_numbers |
| — | main.tex:642 | V-D 2): Eve-aware AN +35.6% over the FPA at M = 1, proposed +30.7% over it; its gain over the FPA → 2.6% at M = 6 (N−M = 2); both FPA schemes saturate for M ≥ 5; gains 64.4% / 60.1% at M = 6; Eve-nulling / APS sentences removed | verify_numbers |
| I180 | main.tex:644 | V-D 3): common-κ claim restricted to the MA designs and the FPA (< 0.04 bps/Hz); gains at κ = 20 dB 19.3 / 31.5 / 49.4%; Eve-aware AN below the FPA for κ_e ≤ 0 dB (5.2%; 2.8% at κ = −10 dB) with its cause; proposed 16.6–20.4% above the Eve-aware AN; Eve-nulling sentence and the "balanced with the decorrelation among the LUs" clause removed (it relied on the Eve-nulling MA) | verify_numbers, check_ean_direction |
| I179 | main.tex:649 | conclusion: outperforms "the rate-oriented MA design, with a gain that grows with the Rician factor of Eve, and the FPA, even with Eve-aware AN unless the movable region is very small" | new suite |
| — | verify_numbers.m, review/verify_numbers_rev8.txt, review/experiments/rev8g_benchmarks/ (analyze_suite.m, analysis.txt, check_ean_direction.m/.txt), readme.tex/.pdf, main_preview.pdf | numbers and evidence of the new text; documentation of the suite, files and styles | rule 3 |

## Round rev-9a — modeling–derivation review (no manuscript or code changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I182–I198 | review/rev9_modeling_review.md (new) | review along modeling → analysis → algorithm with the IEEE modeling and derivation guidelines; 17 recommendations (R1–R17) with draft text; derivations re-checked; equation numbers checked against main.aux | author's request (report only) |

## Round rev-9b — implementation of R1–R14 of the modeling–derivation review (author's approval; R4 and R5: delete)

| ID | File:line | What | Why |
|---|---|---|---|
| I182 (R1) | main.tex:333 | III-B: in the LoS-dominant and high-SNR regime, (20) underestimates the rate by a gap independent of t: (18) becomes tight, the Wishart step overestimates [(HᴴH)⁻¹]_{m,m} by a factor approaching N/(N−M), so R_m − R̂_m → log₂(N/(N−M)) | size of the approximation loss at the step that makes it; verified by fig3_accuracy.mat |
| I182 (R1) | main.tex:591 | V-B 1): the explanatory sentence (moved to III-B) replaced by the check "toward the limit M log₂(N/(N−M)) = 2.03 bps/Hz …, e.g., to 1.99 bps/Hz for κ = 20 dB in Fig. 3(b)" | verify_numbers (new V-B1 lines) |
| I183 (R2) | main.tex:411 | III-E: (P3) differs from (P2) only by (20) and (27); t-independent gap of (20) and asymptotic exactness of c_m, d (Proposition 1) make (P3) a suitable surrogate for the position design | exact/approximate bookkeeping; Proposition 1 now used in the main text |
| I184 (R3) | main.tex:~504 | IV-B: backtracking-bound sentence deleted (finite termination already implied; [Beck2017]); removes the italic L vs bold L(t) clash | defensive derivation |
| I185 (R4) | main.tex:~545 | IV-C: stationarity caveat deleted ("the objective value is guaranteed to converge" kept) | defensive caveat |
| I186 (R5) | main.tex:~437 | IV-A: multi-Eve footnote deleted (future work lists multiple eavesdroppers) | over-reaching generalization |
| I187 (R6) | main.tex:293 | III-A: isotropic-AN rationale trimmed to its two operational reasons | defensive clause |
| I188 (R7) | main.tex:274–275 | (P1): "where (11b) holds for every realization of H(t)" (final period of (11d) → comma) | two timescales visible in the formulation |
| I189 (R8) | main.tex:357 | III-C: reason for the calibration of d(t) | why of an approximation step |
| I190 (R9) | main.tex:381, 388 | ρ_m(t) defined in III-D 1) for every LU; III-D 2) uses it | symbol defined where introduced (also used for M = 3 in V) |
| I191 (R10) | main.tex:439 | IV-A: grid-search decision stated before the stationarity condition (38) | method first, structure second |
| I192 (R11) | main.tex:431 | IV-A: concavity shown by the explicit second derivative | readability |
| I193 (R12) | main.tex:319 | III-B: Jensen step without the dummy variable z | one meaning per symbol |
| I194 (R13) | main.tex:476–480, 530, 549; 655; notation.tex | Γ_n → Φ_{−n}, r_n → v_{−n} ("the parts of Φ(t) and v(t) contributed by the other MAs"); App. B generic matrix A → X; \br, \bGam kept in notation.tex for the archived main_candidates.tex only | one meaning per symbol |
| I195 (R14) | main.tex:488; 688 | derivatives (dℓ/du, dv/du, dΩ/du) and Λ_u moved from IV-B to App. C (now (54)–(56)); IV-B keeps one sentence, η̇ and the gradient (44) | routine algebra to an appendix; equations ≥ (44) renumbered automatically |
| — | ma_secrecy_matlab/readme.tex/.pdf | equation numbers updated ((44)–(48), App. C (54)–(63)) | renumbering by R14 |
| — | verify_numbers.m, review/verify_numbers_rev8.txt | V-B1: gap increasing in κ, 1.991 at κ = 20 dB, limit 2.034 | rule 3 |
| I196–I198 | — | R15–R17 not adopted | author |

## Round rev-10a — diagnostic review in Review mode (no manuscript or code changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I199–I211 | review/rev10_writing_review.md (new) | ieee-wireless-writing Review mode: macro audit of the problem-solving thread, writing quality, figure–text and layout; checklist [R1]–[R13] with excerpts and revision approaches | author's request (review only) |

## Round rev-10b — implementation of [R1]–[R13] of rev10_writing_review.md, rewrite of the abstract and introduction, sentence-level pass (author's request: adopt all items; all changes in red)

| ID | File:line | What | Why |
|---|---|---|---|
| — | main.tex:39; whole body | red marks of rev-8/rev-9 accepted (71 `\rev{}` wrappers removed, text unchanged); only rev-10b changes are red; previous marked version: commit 3d32e13 | file convention (previous round accepted, this round in red) |
| I199 (R1), I212 | main.tex:62 | abstract: "Specifically, … jointly optimized to maximize the ergodic secrecy sum rate subject to the transmit power and antenna position constraints"; closed-form step with the decomposition of Eve's channel (ZF directions, AN subspace); insight sentence; "an alternating optimization algorithm is developed to maximize the approximate ergodic secrecy sum rate, where the power allocation among the LUs is obtained by secrecy water-filling and each antenna position is updated by a grid search followed by majorization–minimization"; result sentence aligned with the conclusion; ZF acronym | supervisor template; R1 |
| I212 | main.tex:74 | I ¶1: "which reshapes" → "where the antenna positions are adjusted … to reshape" | ambiguous "which" |
| I200 (R2) | main.tex:76 | "…negligible or tolerable, as noted in [YuArxiv2025]" | [YuArxiv2025] Sec. 2.2.2 states it verbatim |
| I212 | main.tex:76 | [ChenArxiv2026] described from its PDF: direction of Eve estimated by sensing, positions and robust beamformer maximize the worst-case secrecy rate; Eve's link modeled as LoS (paper: "we model the BS-eavesdropper … links as LoS channels"), so its small-scale fading is ignored | accuracy (old text said "assumes LoS channels") |
| I212 | main.tex:78 | new sentence: positions maximize the ergodic sum rate of a multiuser downlink with MRT or ZF precoding [ZhengTCOM2025] and of a multiuser uplink with linear and nonlinear receivers [HuTVT2025] (both from the papers' abstracts/system models); ZF defined here | closest works stated before their common limitation |
| I212 | main.tex:80 | contributions: model sentence split from the problem sentence; new sentence on the high-SNR AN insight (MAs reduce the optimal AN power fraction by decreasing the leakage-to-AN ratio; Sec. III-D 3)); power allocation in passive voice ("for any given AN power, which is then determined by a one-dimensional search"); AO purpose + convergence guarantee; grid search motivated by the wavelength-scale oscillation; rank-one structure; SNR defined here | supervisor style; not redundant with the abstract |
| I212 | main.tex:82, 390 | roadmap: Section III "approximates the ergodic rates in closed form"; III-D 3): "(SNR)" definition removed (now in Sec. I) | acronym defined at first use (SNR was used at l. 333 before its definition) |
| I201 (R3) | main.tex:176; 569; 640 | II-A: positions exist if, e.g., A ≥ (N/2−1)D_min for even N ≥ 4, since a 2×(N/2) UPA with spacing D_min then fits in C (UPA defined here); V-A: "UPA"; V-D 1): Fig. 7(a) starts from A = (N/2−1)D_min = 1.5λ, the smallest side length for which the FPA fits | feasibility; Fig. 4 caption used "UPA" before its definition |
| I202 (R4) | main.tex:225 | protocol: MAs moved once per frame, CSI of the LUs acquired only at the current positions, and not outdated by the movement delay since it is estimated after the movement | pain points of Sec. I closed by the model (true by construction) |
| I213 | main.tex:277 | II-D roadmap split into First/Then/Finally | one step per sentence |
| I213 | main.tex:285, 295 | III-A: ZF-AN sentence and long-term power sentence split | two relative clauses / three ideas |
| I203 (R5) | main.tex:319–329 | III-B reordered: motivation and Jensen bound first (now (17)), then β̃_m, B, L(t) and the decomposition (now (18)), whose Gram mean B^{1/2}Φ B^{1/2} introduces (19), then the Wishart step; bare "of which" removed | four-step motivation loop; equations unchanged, (17)↔(18) renumbered |
| I213 | main.tex:333, 346, 352, 388, 399, 411 | III-B tightness sentence split; III-C: concession first ("neither an upper nor a lower bound, but accurate when …"), "By taking the expectations of (22) and (23) over H̃"; App.-B steps in passive voice + "These steps yield"; III-D 2) and 3) and III-E splits (same logic) | long sentences, heavy subjects |
| I213 | main.tex:416 | IV opening: nonconvexity attributed to F (nonconcave in t) and (11d) only; coupling of t, p, q stated separately | coupling is not a cause of nonconvexity |
| I213 | main.tex:431, 469, 498, 539 | IV-A concavity sentence split; IV-B local-maximum and backtracking sentences split (colon removed); IV-C convergence sentence split | readability |
| I204 (R6) | main.tex:547 | Section V opening: evaluation goals | skill §2.5 |
| I206 (R8) | main.tex:588 | Fig. 5 caption: "The inset in (a) enlarges the curves of the rate-oriented MA and the FPA with Eve-aware AN around 20 dB." (plot_fig5.m: window 19.5–20.5 dB, these two schemes) | figure–text consistency |
| I213 | main.tex:606 | Fig. 6 caption: "and … and" → "or … or" | and-chain |
| I213 | main.tex:567, 573, 577, 579, 581 | V-A: AoD sentence split; benchmark intro split ("respectively"); Eve-aware AN, equal-power and no-AN items split | readability |
| I205 (R7), I213 | main.tex:592–598 | V-B 1): paragraph break before the FPA with Eve-aware AN; ranking sentence and the underestimation reason split; V-B 2): surrogate comparison sentences split | pacing |
| I205 (R7), I213 | main.tex:618–622 | V-C: three paragraphs (Fig. 5(a) and mechanisms, with the high-SNR sentence moved to its end; FPA with Eve-aware AN; robustness); mechanism and Eve-aware sentences split | one topic per paragraph |
| I210 (R12) | main.tex:622 | robustness paragraph: random-direction AoD error of Eve at the BS (positions and power allocation designed with it): 0.05 rad → ESSR of the proposed design −2.95%, gain over the rate-oriented MA 11.7%; 0.1 rad (= Eve–LU 1 offset) → gain 4.4% (paired SE 0.129 of 0.794 bps/Hz) | extra_eve_aod_error.mat (rev-8c; its err = 0 row equals Fig. 5 at 20 dB); verify_numbers |
| I207 (R9), I213 | main.tex:624–628 | V-C Fig. 5(b): reason sentence split, colon sentence split, "all the benchmarks" → "the other schemes" (the no-AN schemes have zero AN power); Fig. 6(a)/(b) sentences split, "e.g." after a causal clause → "Consequently," | readability; accuracy |
| I208 (R10), I213 | main.tex:642 | "for N ≥ 12" → "for N ≥ 10" (Eve-aware AN − rate-oriented MA: +0.29 (SE 0.18), +0.97, +1.49, +2.00 bps/Hz for N = 10–16); N = 4/8 sentence and gain sentence split | figure–text; verify_numbers |
| I213 | main.tex:644 | V-D 2): three long sentences split | readability |
| I205 (R7) | main.tex:646–648 | V-D 3): paragraph break before Fig. 8(b); the 2.8% (common κ = −10 dB) clause moved into the common-κ paragraph with a pointer to the explanation; reason sentences split | one figure per paragraph |
| I209 (R11), I210 (R12) | main.tex:653 | conclusion: AO sentence ("that … , and its objective value is guaranteed to converge"); results split into rate-oriented MA (+ AN power, antennas) and FPA ("including the FPA with Eve-aware AN unless the movable region is very small"); future work split, robust designs against errors in the statistical CSI of Eve added | nested qualifications; assumption loop |
| I213 | main.tex:659 | App. A: moment sentence split | readability |
| I211 (R13), I213 | main.tex:674–692 | App. B: three "due to" + relation → "since"; heavy-subject sentences in active voice ("We replace … and use …, which yields"; "we apply … and use N ≥ 1, which bounds"); "this implies" → "(51) implies"; double-counting, uniform-sphere and dominated-convergence sentences split | hard grammar error; readability |
| — | ma_secrecy_matlab/readme.tex:291 (+ readme.pdf) | L, Φ, Ω: (17) → (18) | renumbering by R5 |
| — | ma_secrecy_matlab/verify_numbers.m; review/verify_numbers_rev8.txt | R10 text string "> 0 for N >= 10"; four new V-C lines for the AoD-error statements (consistency with Fig. 5, 2.9503%, 11.712%, 4.4269% with paired SE) | CLAUDE.md rule 3 |

## Round rev-11a — independent screening of the GPT review report (no manuscript, code or figure changes)

| ID | File:line | What | Why |
|---|---|---|---|
| I214–I257 | review/rev11_gpt_screening.txt (new) | GPT report (IEEE_TWC_TCOM_Review_ZH.md, written against 3d32e13) screened item by item against rev-10b (f7534ab), the code and the stored results: 10 should-fix, 21 recommended, 6 optional, 4 resolved in rev-10b, 8 rejected; 8 additional issues in the rev-10b text (O1–O8); ICC 2026 FAS paper and published versions of [14], [21], [22] verified via OpenAlex | author's request (screening only; first attachment identical to rev10_writing_review.md) |

## Round rev-11b — implementation of the screened GPT items (author: G2 and G17 reserved for the author's decision; all other items by Claude's judgment; changes in red)

| ID | File:line | What | Why |
|---|---|---|---|
| — | main.tex:39; whole body | red marks of rev-10b accepted (text unchanged); only rev-11b changes are red; rev-10b marked version: commit f7534ab | file convention |
| I215 (G1) | main.tex:62 | abstract: "… outperforms the benchmark schemes. Compared with the MA design that ignores Eve, it requires fewer antennas to achieve a given ergodic secrecy sum rate and allocates less power to the AN." | unqualified AN-power claim false vs. the FPA with Eve-aware AN for N ≥ 14 and A ≤ 2λ; true vs. the rate-oriented MA in all sweeps |
| I233 (G22) | main.tex:62, 80 | "decomposing … along/into components" → "projecting … onto each ZF direction and onto the AN subspace" | ZF directions are not mutually orthogonal |
| I254 (O4) | main.tex:80 | high-SNR AN claim: "in the high-SNR regime with equal power among the LUs" | assumption of (33) |
| I221 (G37) | main.tex:80, 461 | "on the scale/order of a wavelength … has many local maxima" → "oscillates (with each t_n) and can have many local maxima" | periods range up to ≈10λ for Eve near LU 1 |
| I224 (G3) | main.tex:208 (Fig. 2) | brace: "t and powers fixed" → "t and powers updated once" (parallel to the CI brace) | the brace spans the optimization and movement |
| I236 (G28) | main.tex:253 | "achieves" → "approaches" (N_CI ≫ 1) | achievability is asymptotic |
| I225 (G5) | main.tex:293 | "the spatial distribution of the isotropic AN does not depend on the CSI of Eve, so that the AN also impairs …" | q depends on Eve's statistical CSI |
| I237 (G30) | main.tex:319 | "no tractable closed-form expression" | special-case closed forms exist |
| I226 (G6) | main.tex:346 | concentration condition "if the LoS components of the LUs and Eve are strong (see Appendix A and the proof of Proposition 1)" | App. A covers only the conditional (Eve-side) variance |
| I243 (G48) | main.tex:352, 664 | "invariant to a positive scaling of the columns" | complex scaling changes the phase of w̄_m |
| I255 (O5) | main.tex:381, 653; 642, 648 | "AN power received by Eve"; "secrecy-aware/Eve-aware positioning" → "the proposed positioning" | terminology consistency, no coined labels |
| I216 (G7) | main.tex:388; 644 | "if κ_1 > 0 and κ_e > 0, then c_1 increases …"; M = 1: "so that its position update retains the UPA initialization" | monotonicity conditions; tie handling (rate_oriented_positions.m) |
| I220 (G36) | main.tex:437 | "for μ_m(ν) > 1, (37) is the positive root …, whereas p_m⋆(ν) = 0 otherwise" | no positive root for μ_m ≤ 1 |
| I217 (G9) | main.tex:454 (Alg. 1) | refinement "in the interval spanned by the best grid point and its neighbors" | endpoint case as in power_opt.m/search1d (q⋆ at q = 0 at low SNR) |
| I238 (G39) | main.tex:508 | "… and selecting the feasible candidate closest to this point" | complete selection rule |
| I239 (G40) | main.tex:537 | "…for (P3). It terminates when …" | "which" attached to (P3) |
| I218 (G13) | main.tex:560, 596 | Fig. 4 caption: "2×4 and 3×4 UPA initializations for N = 8 and 12, respectively"; text: "the average objective value … attains more than 95% and 99% of its total increase within three and 15 iterations, respectively" | fig4_convergence.m uses a 3×4 UPA for N = 12; individual runs need up to 40–50 iterations |
| I227 (G8) | main.tex:588, 624; functions/plot_fig5.m; results/fig5b_an_fraction.png | "high-SNR limits" → "high-SNR predictions" (caption, text, legend "High-SNR prediction, (33)"); Fig. 5(b) replotted from fig5_snr.mat (Fig. 5(a) pixel-identical) | (33) assumes equal power among the LUs |
| I240 (G41), I241 (G42) | main.tex:571, 575 | "Unless otherwise specified, the results …"; rate-oriented MA: "positions are optimized to maximize … without considering Eve" | 20-realization grid check; subject–verb |
| I229 (G12) | main.tex:592 | "The sum of the approximate wiretap rates in (27) agrees …, which confirms the accuracy of (27) …" | Fig. 3 shows sum rates |
| I230 (G14) | main.tex:598 | curvature "estimated numerically on a fine grid"; "the median of its curvature is about 12 times that of the δ_n accepted …" | sampled estimate; ratio of medians (11.87) |
| I222 (G43) | main.tex:618 | "less than half … for P/σ² ≥ 5 dB" | ratio 0.60 at 0 dB, ≤ 0.47 for 5–30 dB |
| I223 (G44), I256 (O6) | main.tex:622 | "The gains … over the rate-oriented MA and the FPA are not limited to an Eve close to LU 1. If … independently …, these gains are still 10.3% and 21.8% at 20 dB, respectively."; 0.1 rad: "the ESSR of the proposed design decreases by 9.73%, and its gain over the rate-oriented MA reduces to 4.4%" | claim scope; selective reporting; extra_random_eve_M3, extra_eve_aod_error |
| I251 (O1), I219 (G15), I242 (G46), I252 (O2) | main.tex:640, 642 | "for 1.5λ ≤ A ≤ 6λ, where A = (N/2−1)D_min = 1.5λ is the smallest …"; A = 1.5λ: "achieves an ESSR comparable to that of the proposed design (0.9% higher on average)"; "grows with the dimension"; "over the FPA with Eve-aware AN" | ambiguous "which"/"this benchmark"; +0.151 (SE 0.095) not significant |
| I253 (O3) | main.tex:646 | "As explained below for Fig. 8(b), the FPA with Eve-aware AN falls 2.8% below the FPA for κ = −10 dB." | "In this case" two sentences away |
| I244 (G49) | main.tex:674 | "a fraction χ of I_N − Π only" | Π is not a projector |
| — | ma_secrecy_matlab/verify_numbers.m; review/verify_numbers_rev8.txt | text strings (99% within 15, 21.8%, comparable at 1.5λ); new lines: gain ratio ≤ 0.47 for SNR ≥ 5 dB and 0.60 at 0 dB; 9.73% at 0.1 rad | rule 3 |
| I228, I232, I234, I235, I245–I250, I257 | — | not adopted (reasons in ISSUES.md); G2, G17 (I214, I231) reserved for the author | judgment criteria: no new ambiguity, no unintroduced content, standard wording |
| — | — | build: 0 errors, no undefined references, no overfull boxes; 16 pages (references [24]–[32] on p. 16) | — |
