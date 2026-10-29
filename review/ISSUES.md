# Issues (shared state) — merge of 01_original (Claude) and 02_revised (GPT/Codex)

Sources: v1 = `CLAUDE_COMPARISON/01_original` (= this branch before the merge), v2 = `02_revised`,
S = `review/SEED_ISSUES.md`. Status: open / fixed / kept / needs-decision / unverified.
Evidence key: D = derivation, C = code, R = results file, P = reference PDF, X = executed check.

| ID | Sev | Location | Finding | From | Evidence | Decision | Status |
|---|---|---|---|---|---|---|---|
| I1 | H | III-B/C, App. B | Lemma 1, Prop. 1, Lemma 3 assert "≈"; Lemma 1 restates a known result | S-B1/B2, both | CLAUDE.md math style | Lemma 1 → cited derivation; Prop. 1 states only exact properties; App. B lemma → derivation | fixed |
| I2 | M | III-C | Moment replacement was motivated by *conditional* concentration only; unconditional variances add κ_e²Var{X̄}, κ_e²Var{Ȳ}; replacement is neither upper nor lower bound | v2 | D (law of total variance; log concave in X, convex in Y) | concise correct justification, accuracy shown in V-B | fixed |
| I3 | L | III-C | Asymptotic exactness needs linearly independent LoS vectors of the LUs | v2 | D, App. B proof | state condition | fixed |
| I4 | L | III-B | Separate the exact Jensen bound from the central-Wishart replacement | v2 | D | adopt (inline) | fixed |
| I5 | M | Rem. 2 | M=1: exact X̄₁+Ȳ=N; approximations deviate by κ(C/N−1)/((κ+1)((N−1)(κ+1)+1)), \|·\| ≤ κ/(κ+1)² ≤ 1/4 | v2 + own bound | D (verified algebra) | identity X̄₁+Ȳ=N + exact residual (c₁−1)/((N−1)(κ₁+1)+1) ∈ [−1/4,1/4]; (28) written as affine in c₁ | fixed |
| I6 | L | IV-B | "t̂ₙ typically lies in the basin of a global optimum" / "basins densely sampled" unsupported; F is rational in the phase terms | S-B8, v2 | D; X grid check | reword; cite grid-refinement check | fixed |
| I7 | L | IV-B/C, Alg. 2 | Stopping tests in code use increase/max{1,\|F\|}, text says "fractional increase" | v2 | C (ao_optimize, position_sweep) | align text | fixed |
| I8 | M | IV-C | State objective-value convergence only (no stationarity/global optimality) | S-B4, v2 | D | one clause | fixed |
| I9 | L | V | Δ is an offset in (θ,φ) coordinates, not a physical angle | v2 | C gen_scenario | call it "AoD offset", relabel Fig. 7(a) | fixed |
| I10 | L | V-A | "\|h̄₁ᴴḡ\|/N exceeds 0.94 for the FPA" | v1 | X needed | kept: min over the 100 drops is 0.9439 (verify_numbers.m) | fixed |
| I11 | L | V-A | Fig. 3 uses 10⁴ samples (code), text says 5×10³ for all | v2 | C fig3_accuracy | fix | fixed |
| I12 | L | V-A | AS ranks subsets with a 21-point q grid, refines only the winner | v2 | C as_select | describe | fixed |
| I13 | L | V-A | standard error 0.5% → 0.55% (0.113 bps/Hz) | v2 | R fig5_snr | recompute | fixed |
| I14 | M | all | Exotic/duplicate glyphs ς ϖ ϑ ϱ Υ oₘ, two epsilons, Q/W/G/c/Lₙ/Δ/μ/P_I clashes | S-C1–C9, both | text | rename (see CHANGELOG) | fixed |
| I15 | M | Abstract/Intro | Abstract chronological with "Since…" clause (v1) / hedged, list-like (v2); contributions must start "In this paper"; own-voice sentences | S-F2/F3, CLAUDE.md | text | rewrite (third version) | fixed |
| I16 | L | V-H | "ESSRs of all the schemes increase by at most 1.6" also covers w/o AN (13.3 increase) | v2 | R fig5_snr | "all schemes with AN" | fixed |
| I17 | L | Refs | Chen et al.: published in IEEE TWC 2026 (DOI 10.1109/TWC.2026.3688454 verified; vol./pages from v2 not verifiable) | v2 | lookup (OpenAlex) | cite with DOI, no unverified pages | fixed |
| I18 | L | II-B | [15] senses Eve's direction; it does not assume known statistical CSI | own | P chen.txt | cite [13] for the assumption, [15] in footnote | fixed |
| I19 | L | II-A fn. | i.i.d. NLoS at D_min ≥ λ/2 is an idealization, not implied by spacing | S-B7, v2 | D | concise wording | fixed |
| I20 | L | II-C | "an achievable ergodic secrecy rate" wording | S-B3 | text | adopt | fixed |
| I21 | L | (P3) | F ≤ approximate ESSR at any iterate (x ≤ [x]⁺) | v2 | D | one clause | fixed |
| I22 | L | V-B | quantify Eve-rate accuracy (max abs. error) | v2 | R fig3_accuracy | recompute | fixed |
| I23 | L | code | plot_fig7 scheme lookup by name; evaluate_schemes feasibility asserts; search1d keeps best of both grids | v2 | C, X | adopt (no output change) | fixed |
| I24 | — | v2 text | numerical-failure thresholds, rank-deficient policy, implementation-complexity caveats, repeated "does not establish" hedges, verbose Alg. 1/2 | v2 | — | reject (not paper content / over-hedging) | kept-v1 |
| I25 | L | V-G | EP benchmark positions: MM on Σ[·]⁺ uses the currently positive terms (minorizer) | v2 | C position_sweep plus-flag | one clause | fixed |
| I26 | L | V-C | "converges within about 15 iterations" vs curves flat after a few | S-D1, v2 | R fig4 itStop | "average curves achieve 99% of their total increase within 15 iterations" (10–15 over the 4 settings) | fixed |
| I27 | L | V-E | sparse FPA vs rate-oriented at N = 12 | S-D2 | R extra_num_antennas | "for N ≥ 14": paired differences +0.11 (SE 0.20) at N=12, +0.32 (SE 0.19) at N=14, +0.44 at N=16 | fixed |
| I28 | L | V-G | 20-dB PA numbers not plotted in Fig. 7(b) | S-D3 | R fig7_pa_hetero | "(not shown)" | fixed |
| I29 | L | V-F | M=1 rate-oriented keeps the UPA initialization | S-D5 | C rate_oriented_positions | state | fixed |
| I30 | L | (23),(47) | punctuation of displays | S-D6 | text | scan of all displays: each ends with , or . unless the sentence continues | fixed |
| I31 | L | IV-C | "less than one third of the shortest phase period" → ‖a_j−a_i‖ ≤ 2 gives at most one fifth | S-B6 | D (‖a‖ ≤ 1) | adopt | fixed |
| I32 | L | format | Index Terms alphabetical; "w.r.t." → "with respect to"; "widely studied … [18]" | S-F1/F4/F5 | text | adopt | fixed |
| I33 | — | V-H | small table for robustness numbers | S-D4 | conflicts with Round-12 decision to remove tables | keep text | needs-decision |
| I34 | — | V | new simulations E1–E6 | S-E/G2 | — | not added | needs-decision |
| I35 | — | Intro | novelty search 2025–2026 | S-A2 | OpenAlex rate-limited (HTTP 429) | not completed | unverified |
| I36 | — | figures | vector PDF figures | S-D7 | — | PNG kept unless export verified | needs-decision |
| I37 | L | Rem. 2, (28) | splitting (28) over two lines pushed one reference to p. 15; one-line form had its number on a separate line | own | D (algebra), X (2×10⁵ random cases) | equivalent one-line form d = A(N + 1/(κ₁+1) − c₁) | fixed |
| I38 | L | Rem. 3, (29) | equation number pushed to its own line | own | layout | two-line align | fixed |
| I39 | M | V-B | gap between actual and approximate ESSR at 20 dB stated as 1.53–1.77; recomputed 1.5245 (AS) – 1.7650 (proposed) | own (recomputation) | R fig5_snr.mat (essr, F) | 1.52–1.76 | fixed |
| I40 | L | V-A | grid-halving result (0.01%) not reproducible from the repository | own | X | extra_grid_check.m + results/extra_grid_check.mat (20.6009 → 20.6032 bps/Hz, +0.011%) | fixed |
| I41 | L | code, readme | comments/readme cite drifting equation numbers, Lemma 1/Prop. 1, varsigma, global search, I_max/I_in/I_b, ε_e, d_g; Fig. 3 legend names Lemma/Proposition; Fig. 7 axis labels | own | grep, .aux mapping | labels in comments; readme renumbered from main.aux; Figs. 3 and 7 replotted from stored results | fixed |
| I42 | L | readme | "approximate ESSR is a conservative estimate" overclaims | own | D (I2) | "lower in all tested cases; not a bound in general" | fixed |
| I43 | L | code | no script maps Section V numbers to results files | CLAUDE.md rule 3 | X | verify_numbers.m (prints recomputed value next to each number in the text) | fixed |
| I44 | L | layout p. 11 | Underfull \vbox (badness 10000): about 5 pt extra paragraph gap below Figs. 5–6 | own | main.log | cosmetic, accepted | open |
