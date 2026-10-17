# Seed issues (pre-review of main_preview_8.pdf)

Found in a first read. Derivations I re-checked and found correct: (12), Lemma 1 / (18),
(21), (26)–(27), (28)–(29), (35), (44)–(45), (47), (49)–(50), N+3 lines, |G| = 1681.
Merge these into `review/ISSUES.md`; verify each before acting. Severity: H / M / L.

## A. Integrity (do first)
- A1 [H] References were produced by an AI tool. Verify every entry (authors, title, venue,
  vol/no/pages/year), especially [13]–[17], and that each cited claim matches the source:
  "[16, Remark 2]" (no MA gain for a single user), "[19, Lemma 1]" (ratio-of-means
  approximation), "[26, Lemma 5.7]" (descent lemma), "[13], [15]" (Eve statistical CSI known).
  Make [14]/[15] arXiv formats consistent.
- A2 [H] Novelty claim "the two-timescale design of MA-enabled secure transmission remains
  unexplored": search 2025–2026 work (movable/fluid antenna + two-timescale or statistical CSI
  + secrecy/AN). If a close work exists, the Intro and contributions must change.
- A3 [H] Trace every number in Sec. V to a results file: 31%, 0.94, ~15 iterations, 0.5%
  standard error, 40%/14%/<1%, 1.6, 0.5 vs 1.5, 27.1, 14, 3%, 18.73 vs 17.93, 10%/18%.

## B. Rigor
- B1 [H] Lemma 1, Proposition 1 and Lemma 3 assert approximations ("≈"). A lemma cannot state
  an approximation. Present the approximations as derivations; keep as formal statements only
  the exact parts (exact for Rayleigh, asymptotically exact, range in [0, ‖b‖²]).
- B2 [M] Lemma 1 restates [16], [19] → inline cited result, not a lemma (my style preference).
- B3 [M] (7): say "an achievable ergodic secrecy rate" consistently and cite the exact result
  in [20]/[21] supporting achievability without Eve's instantaneous CSI.
- B4 [M] Convergence: only convergence of the objective value is shown; make sure no sentence
  implies convergence to a stationary/KKT point.
- B5 [M] Remark 3, (29): closed form holds only for Θ_m = Θ, ∀m, and is based on the
  approximate rates — state both explicitly.
- B6 [L] Sec. V-A: "d_g less than one third of the shortest phase period" — since
  ‖a_j − a_i‖ ≤ 2, the period is ≥ λ/2 and λ/10 is at most one fifth; state the tighter bound.
- B7 [L] Footnote 1 (i.i.d. NLoS at D_min = λ/2 in a 2D region) — likely reviewer question;
  add a citation or one-line justification.
- B8 [L] "t̂_n typically lies in the basin of a globally optimal solution" — heuristic; keep
  hedged and point to Fig. 4 (MM-only) as evidence.

## C. Notation (one symbol, one meaning)
- C1 Q: grid size (Alg. 1) vs Q = [w̄_m, U] (App. A).
- C2 W: short-timescale policy (P1) vs random matrix W (Lemma 3); make the policy calligraphic.
- C3 G(q) (Sec. IV-A) vs grid 𝒢, 𝒢_n (Sec. IV-B).
- C4 ε (AoD error ε_e) vs ϵ (tolerances ϵ, ϵ_in): two epsilon glyphs, two meanings.
- C5 Δ (angular separation) vs bold Δ^(k)_{n,i} (position difference).
- C6 μ: Gaussian mean (Notation) vs singular values μ_i (App. B).
- C7 c: grid point vs c_m(t); d(t) vs d_g, D_min; L(t) vs Lipschitz L_n; I_N vs iteration
  counts I_o, I_b, I_in, I_max; J (backtracking trials) vs j.
- C8 P_I(q) (power) next to P^⊥(t) (projection) and P_tot; subscript "I" never defined.
- C9 Exotic/ambiguous glyphs: ς (fading spread), ϖ, ϑ, ϱ, Υ, o_m (reads as zero).
- C10 Argument convention: η_m(t) vs η_m, η_{e,m}(q) vs η_{e,m}; state once when arguments
  are dropped.
- C11 Check the Notation paragraph covers every operator used (⪯, ≺, ∅, \, ∪, w.r.t.) and
  drops unused ones.

## D. Text ↔ figure consistency and typesetting
- D1 Sec. V-C says convergence "within about 15 iterations"; Fig. 4 shows ~3–5. Reconcile.
- D2 Sec. V-E "sparse FPA outperforms rate-oriented MA for N ≥ 12": curves look equal at
  N = 12 in Fig. 6(b); check data.
- D3 Sec. V-G "below 1% at 20 dB": no 20 dB curve in Fig. 7(b); add it or write "(not shown)".
- D4 Sec. V-H numbers are text-only; a small table (TIN Eve / AoD error / independent AoDs)
  reads better.
- D5 Fig. 7(a), M = 1: rate-oriented objective is constant in t, so its result depends on
  tie-breaking among initializations; state that it keeps the UPA.
- D6 Punctuation: (23) ends with "." before "and v(t) ≜ ..."; (47) ends with "," before a new
  sentence; "Lemma 1 ( [16], [19])" spacing.
- D7 Figures: same scheme = same color/marker in Figs. 3–7; colorblind-safe; fonts ≈ 8 pt
  after scaling; vector PDF; legends not covering data; consistent axis labels/units.

## E. Simulations reviewers will likely ask for (decide which to add)
- E1 [H] One-timescale (instantaneous-CSI, per-CI repositioning) MA design as an upper bound,
  plus a movement/CSI-overhead comparison vs frame length N_CI — the paper's motivation is
  overhead, but it is never quantified.
- E2 [H] Approximation-based design vs a sample-average/stochastic optimization (e.g. SSCA as
  in [18]): ESSR and runtime, to validate optimizing the closed form.
- E3 [M] Runtime table vs N, M, |𝒢|, plus sensitivity to d_g.
- E4 [M] Imperfect LU CSI (pilot estimation error).
- E5 [M] κ_e varied separately from κ_m (κ_e → 0 removes Eve's spatial information, Remark 1).
- E6 [L] ESSR vs M with N fixed; error bars or stated standard error on main curves.

## F. IEEE formatting
- F1 Index Terms in alphabetical order.
- F2 Abstract: one paragraph, ≤ 250 words, no equations/citations; currently long — tighten in
  supervisor style.
- F3 Contributions paragraph: starts with "In this paper" (now "To bridge this gap"); consider a
  short itemized list; remove overlap with the abstract.
- F4 "widely studied for intelligent reflecting surfaces [18]" — one citation for "widely
  studied"; add one or two (approved) references or soften.
- F5 "w.r.t." in running text → "with respect to".
- F6 BibTeX with IEEEtran.bst + IEEEabrv; consistent author-name and month formats.

## G. Decisions for me / my advisor (do not apply without approval)
- G1 Theorem count (Lemmas 1–3, Props. 1–2, Remarks 1–4). Proposal: Lemma 1 → inline citation;
  Lemma 3 → derivation inside App. B; keep Lemma 2 and Prop. 1 (core novelty); Prop. 2 →
  either keep or present as "the optimal power allocation is given by (35)" in text.
- G2 Which of E1–E6 to add, given time and page budget.
