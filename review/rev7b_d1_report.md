# Rev-7b report: D1 verification, D2 recommendation, benchmark and figure plan, and final selection

**Status.**

- The D1 small-scale verification is complete (§1).
- Following your message of 2026-11-24 ("please, as an expert, help me make the selection and continue with all the subsequent revision tasks … make your own decision"), I made the remaining choices. They are listed in §4 with the reason for each, and are executed from rev-7c onward.
- The D1 experiment code is a set of copies that call the production functions read-only. It is in `review/experiments/rev7b_d1/` with its raw results, logs, and the check scripts quoted below.

---

## 1. D1: S0 vs. S1, quick verification

### 1.1 Setup

**Scenario.**

- Default setup: N = 8, M = 3, A = 4λ, κ_m = κ_e = 10 dB, Δ = 0.1 rad, P_tot/σ² = 20 dB.
- 10 drops with the production seeds. Every variant sees the same channels and starts from the same UPA initialization.
- Algorithm 2 settings as in production: grid λ/10, N_MM = 20, ε_in = 10⁻⁶, ε = 10⁻⁴, N_AO = 50.
- Every variant runs Algorithm 1 for (p, q) after each position sweep.
- The final designs are evaluated by Monte Carlo with 10³ channel samples (D5).

| Variant | Stage 1 (grid search) | Stage 2 (local refinement) |
|---|---|---|
| **S0** | yes | current MM: descent-lemma minorizer, curvature by backtracking, closed-form projection (production code, reproduced to 6 decimals) |
| Stage 1 only | yes | none |
| **S1-best** | yes | MM with a *fixed* curvature equal to the largest Hessian norm of F over the region (numerical oracle). An analytical bound can only be larger, so this is the **most favorable** fixed curvature |
| **S1-Zheng** | yes | **Zheng-type surrogate:** LU terms by Zheng et al.'s Lemma 1 and their closed-form cosine-sum curvature ((50)–(63) of arXiv:2410.05912, transferred exactly); Eve terms by a second-order Taylor bound with the oracle curvature (favorable to S1); concave subproblem solved by a convex solver (Octave `sqp`, standing in for CVX) |
| S1-Zheng, no Stage 1 | no | as S1-Zheng |
| S0, no Stage 1 | no | as S0 (the "MM only" curve of Fig. 4) |

**Validity checks (all passed; `check_zheng_surrogate.m`, 5 drops × 8 antennas):**

- The Zheng-type LU surrogate equals the LU rate at the expansion point: largest difference 7 × 10⁻¹⁵.
- Its gradient matches central finite differences: relative error 8 × 10⁻⁹.
- It never exceeds the true LU rate at 4000 random positions in C; the smallest gap is 0.72 bps/Hz.
- No MM step of any variant decreased the objective.

### 1.2 Results

10 drops, mean over the drops. Differences are paired with respect to S0, with standard errors in parentheses.

| Variant | Mean F (approximate ESSR) | ΔF vs. S0 | Monte Carlo ESSR | ΔESSR vs. S0 | AO iterations | MM iterations | Solver calls | Time per drop* |
|---|---|---|---|---|---|---|---|---|
| **S0** | 18.907 | — | 20.667 | — | 10.1 | 263 | 0 | **0.82 s** |
| Stage 1 only | 18.913 | +0.006 (0.039) | 20.678 | +0.011 (0.041) | 6.9 | 0 | 0 | 0.30 s |
| S1-best (oracle curvature) | 18.935 | +0.028 (0.036) | 20.698 | +0.032 (0.040) | 10.2 | 351 | 0 | 0.84 s |
| **S1-Zheng** | 18.924 | +0.017 (0.040) | 20.677 | +0.010 (0.046) | 9.8 | 682 | 682 | **13.5 s** |
| S1-Zheng, no Stage 1 | 17.923 | **−0.984 (0.209)** | 19.613 | **−1.054 (0.218)** | 44.9 | 6321 | 6321 | 132.5 s |
| S0, no Stage 1 | 18.181 | −0.726 (0.144) | 19.892 | −0.775 (0.148) | 23.9 | 1046 | 0 | 1.75 s |

\* Octave, one initialization; the time of the curvature oracle is excluded. Production uses three initializations, so all times scale by about ×3.

**Curvature and step size of the Stage-2 updates:**

| | Curvature (median, IQR) | Step length (median) |
|---|---|---|
| S0: curvature accepted by backtracking | 8 (4–16) | 0.0033λ |
| S1-best: largest true curvature over the region | 11.6 (6.1–19.3) | 0.0021λ |
| S1-Zheng: curvature of the Zheng-type surrogate at the expansion point | **137 (130–211)** | **0.0006λ** |
| S1-Zheng, no Stage 1 | 192 | 0.0010λ |

### 1.3 Answers to your three questions

**Q1. Does S1 (Zheng-type surrogate with closed-form curvature, solved by CVX) have advantages over S0?** No, in none of the three respects.

- **Performance.** All two-stage variants reach the same objective and the same Monte Carlo ESSR, within ±0.03 bps/Hz (≤ 0.15%). None of the differences is statistically significant (standard errors ≈ 0.04).
  - Even Stage 1 alone is indistinguishable from S0 (+0.006 ± 0.039). The performance comes from the global grid search, not from the choice of the local surrogate.
- **Convergence speed.**
  - With Stage 1, both methods need the same number of AO iterations (≈ 10).
  - The Zheng-type surrogate is a much looser minorizer: its curvature is ≈ 17× the one S0's backtracking accepts (137 vs. 8). Its steps are therefore ≈ 5.5× shorter, and it needs 2.6× more MM iterations, each one a solver call.
  - In Octave this costs 13.5 s per drop instead of 0.82 s (×16).
  - With CVX in MATLAB the overhead is larger. *Estimate, not measured:* at 0.1–0.5 s per CVX call, the 682 calls per drop (up to 1670) take 1–6 min per drop and initialization.
  - On your remark that the MM-only curve converges within a few dozen iterations: our MM-only variant needs 23.9 AO iterations on average. The Zheng-type MM-only variant reaches the cap of 50 AO iterations in 8 of 10 drops, because of its shorter steps. So a Zheng-type Stage 2 converges more slowly, not faster.
- **Theoretical rigor.** Equal, with one caveat against S1.
  - Both are valid minorize–maximize schemes with a monotone objective.
  - The closed-form curvature of S1-Zheng covers only the LU terms, where Zheng et al.'s Lemma 1 transfers directly. For the Eve terms the experiment had to use a numerical oracle. A genuinely closed-form Eve curvature would need the long derivation of plan §2.2 and would only be larger, which means even slower.
  - S0 reaches the same level of rigor with D2(a) (finite termination of the backtracking and a bounded curvature), in two sentences.
- **Why S0 matches the best case.** A fixed curvature can match S0 only if it is as tight as the true maximum over the region (S1-best ≈ S0). No analytical bound comes close: the Zheng-type surrogate reaches ≈ 137 effectively, and the elementary norm-chain bound of plan §2.3 is ≈ 10⁶.

**Q2. With a Zheng-type surrogate, is the two-stage architecture still needed?** Yes, even more than with S0.

- Without Stage 1, S0 loses 3.8% (−0.73 ± 0.14 bps/Hz).
- Without Stage 1, the Zheng-type surrogate loses 5.2% (−0.98 ± 0.21 bps/Hz in F, −1.05 ± 0.22 bps/Hz in the Monte Carlo ESSR). It reaches the cap of 50 AO iterations in 8 of 10 drops and needs 6321 solver calls (133 s) per drop.
- A local surrogate, of either type, cannot leave the local maxima near the initial positions, because F oscillates on the scale of a wavelength. Its shorter steps make the Zheng-type surrogate worse at this, not better.

**Q3. Iteration counts and runtime of S1 for our secrecy objective (Eve term included).**

| | S1-Zheng (with Stage 1) | S1-Zheng (without Stage 1) |
|---|---|---|
| AO iterations | 9.8 per drop (range 4–24) | 44.9 (range 13–50; cap reached in 8 of 10 drops) |
| MM iterations = solver calls | 682 per drop (range 224–1670), ≈ 70 per AO iteration | 6321 (range 1769–7952), ≈ 141 per AO iteration |
| Time per drop and initialization (Octave `sqp`) | 13.5 s (4.6–35.0), vs. 0.82 s for S0 | 132.5 s (38.6–178.5), vs. 1.75 s for S0 without Stage 1 |

### 1.4 Conclusion

**S0 is superior overall.** It matches S1 in performance, is about 16× faster, needs no solver, and its rigor gap is closed by D2(a).

- The two-stage architecture is necessary for either surrogate.
- Stage 2 adds nothing measurable to the average ESSR (Stage 1 only: +0.006 ± 0.039). It is still worth keeping, at about 0.5 s per drop:
  - it returns continuous, locally improved positions instead of grid points;
  - D2(a) applies to it.
- The manuscript already presents Stage 2 as a refinement of the grid search (abstract, IV-B), so no wording change is needed.

---

## 2. D2 in light of D1 (S0) and D3 (option C: Δ sweep removed)

| Item | Recommendation | Where | Cost |
|---|---|---|---|
| **D2(a)** finite termination of the backtracking | **Include (priority 1)** in the short form: a uniform Lipschitz constant L exists (C² objective on a compact set); hence the backtracking stops after at most 1 + ⌈log₂(L/δ₀)⌉⁺ trials and every accepted δ_n ≤ max{δ₀, 2L}. The explicit closed-form L̄ of plan §2.3 is omitted: it is ≈ 10⁶, too loose to be informative, and its derivation for the Eve terms would take half a page | IV-B (two sentences) | ≈ 4 lines |
| **D2(c)** optimal q made explicit | **Include (priority 1)**, already decided under D7. It has three parts, given below the table. | III-D 3), IV-A, Fig. 5(b) | ≈ 0.3 page |
| **D2(d)** comparison with the Zheng-type surrogate | **Include, light form (priority 2):** one sentence in V-B (objective difference, MM-iteration ratio, numerical solver per iteration) from a supplementary run with 20 drops, `extra_mm_compare.m` | V-B | ≈ 3 lines; ≈ 10 min run |
| **D2(b)** single-LU result | **Keep as a brief remark** in the existing paragraph III-D 2) (no Proposition environment, no figure). It has three parts, given below the table. It is exact and needs no simulation | III-D 2) | ≈ 5 lines |
| D2(e) KKT convergence statement | **Skip**: it needs new references and adds little once D2(a) is in | — | — |

**Details of D2(c).**

1. A displayed stationarity condition for q⋆, obtained from the envelope theorem.
2. The generalization of α⋆ to unequal Ξ_m. The sum of the constant terms is strictly concave in α, so α⋆ is the unique root of M/α − M/(1−α) = Σ_m (Ξ_m − 1)/(1 + α(Ξ_m − 1)). It reduces to 1/(1+√Ξ) for equal Ξ_m.
3. The predicted high-SNR AN fraction 1 − α⋆, shown in Fig. 5(b).

A test on 10 drops at 30 dB (`check_an_prediction.m`):

- The prediction matches the AN fraction of Algorithm 1 within 0.01: 0.289 vs. 0.279 for the proposed design, 0.496 vs. 0.492 for the FPA.
- Using the mean of Ξ_m in 1/(1+√Ξ) would be off by 0.07–0.11. This is why the general root is used.

**Details of D2(b).**

1. ρ₁ = 0 is optimal for every (p₁, q).
2. A sufficient region condition for an even N: λ/(2‖a_e − a₁‖) + (N/2 − 1)D_min ≤ A, with D_min ≤ λ/(2‖a_e − a₁‖).
3. A necessary condition: λ/(2‖a_e − a₁‖) ≤ √2 A.

The required aperture grows inversely with the separation between Eve and the LU.

---

## 3. D6/D7/D9: benchmark list, figure assignment, and legend labels

### 3.1 Final benchmark list: seven schemes, with the equal-power variants in one figure only

Only two schemes get an equal-power variant (the proposed MA and the FPA), which forms the 2 × 2 power-allocation design. The other benchmarks keep the optimized (p, q), so their positions are compared on equal terms.

| # | Scheme (legend) | Positions | Power | What it isolates | Figures |
|---|---|---|---|---|---|
| 1 | Proposed | Algorithm 2 (Eve-aware) | Algorithm 1 (opt p, q) | — | 5, 6, 7, 8 |
| 2 | MA, equal power | Algorithm 2 under equal power | p_m = q = P_tot/N | gain of the power allocation | 6 only |
| 3 | Rate-oriented MA [6] | sum-rate positions | Algorithm 1 | gain of Eve-aware positioning (D6: keep) | 5, 7, 8 |
| 4 | AS [Chen] | N of 2N antennas | Algorithm 1 | MA vs. antenna selection | 5, 7, 8 |
| 5 | Sparse FPA [Chen] | full-aperture UPA | Algorithm 1 | positions vs. aperture | 5, 7, 8 |
| 6 | FPA | λ/2 UPA | Algorithm 1 | MA vs. FPA | 5, 6, 7, 8 |
| 7 | FPA, equal power | λ/2 UPA | p_m = q = P_tot/N | baseline with neither optimization | 6 only |

**Equal power** means p_m = q = P_tot/N: the same power on each of the N spatial streams (α = M/N), with no parameter.

### 3.2 Figure-by-figure assignment and crowding check

**Final layout (L-A′, eight figures as now).** This variant of L-A keeps the panel size of all other figures.

| Figure | Panel | Curves | Count |
|---|---|---|---|
| Fig. 3 (V-B) | (a) vs. SNR, (b) vs. κ: accuracy of the approximations (unchanged, 10⁴ samples) | LU and Eve, Monte Carlo and closed form | 4 + 4 |
| Fig. 4 (V-B) | convergence of Algorithm 2 | 4 settings + "MM only" + Monte Carlo ESSR for the default setting (D4) | 6 |
| **Fig. 5 (V-C)**, two panels with the shared one-row legend | (a) ESSR vs. SNR: positioning | 1, 3, 4, 5, 6 | 5 |
| | (b) AN power fraction vs. SNR | 1, 3, 4, 5, 6 + high-SNR predictions 1 − α⋆ for 1 and 6 (thin dotted) | 5 + 2 |
| **Fig. 6 (V-C, new, one column)** | ESSR vs. SNR: power allocation (2 × 2), legend inside the panel | 1, 2, 6, 7 | 4 |
| Fig. 7 (V-D; former Fig. 6) | (a) ESSR vs. A, (b) ESSR vs. N | 1, 3, 4, 5, 6 | 5 + 5 |
| **Fig. 8 (V-D, new, D11)** | (a) ESSR vs. κ = κ_m = κ_e, (b) ESSR vs. κ_e (κ_m = 10 dB) | 1, 3, 4, 5, 6 | 5 + 5 |

The former Fig. 7 (Δ sweep, D3) and Fig. 8 (power allocation vs. S, D7) are removed.

**Why L-A′ rather than the three-panel row of L-A.**

- A three-panel Fig. 5 needs panels about 2.3 in wide. All other panels are 3.5 in, and the 20-dB inset of Fig. 5(a) would no longer fit.
- Octave cannot render the correspondingly shorter figures (fig_style.m: figures lower than about 2.4 in).
- A separate one-column Fig. 6 keeps every panel at the IEEE column size. The curve counts are unchanged.

**Crowding.**

- No panel has more than five scheme curves.
- The only dense band is the existing one in Fig. 5(a): the rate-oriented MA, sparse FPA, and AS lie within 0.84 bps/Hz at 20 dB (stored data). It keeps its 20-dB inset.
- Fig. 6 is well separated. The predicted high-SNR equal-power loss is larger for the MA than for the FPA: 1.81–1.86 bps/Hz vs. 0.34–0.42 bps/Hz (`pred_equal_power.m`, from the stored AN fractions at 20–30 dB). The optimized positions lower Ξ, so the optimal AN share departs further from the equal split. This illustrates the synergy of the joint design, and the final run will confirm or correct it.

### 3.3 Legend labels: three candidate sets and the choice

Rules common to all sets:

- the same label for the same scheme in every figure;
- the colors, markers, and line styles of `scheme_style.m` stay (MA designs solid, fixed arrays dashed, AS dash-dotted);
- each equal-power variant has the color and marker of its counterpart, with a dotted line and filled markers.

| # | Set A: explicit, Zheng et al. style | **Set B: compact (chosen)** | Set C: star notation |
|---|---|---|---|
| 1 | Proposed (opt **t**, **p**, *q*) | **Proposed** | MA: **t**⋆, **p**⋆, *q*⋆ (proposed) |
| 2 | MA (opt **t**, equal **p**, *q*) | **MA, equal power** | MA: **t**⋆, equal **p**, *q* |
| 3 | Rate-oriented MA (opt **p**, *q*) | **Rate-oriented MA** | MA: **t**_rate, **p**⋆, *q*⋆ |
| 4 | AS (opt **p**, *q*) | **AS** | AS: **p**⋆, *q*⋆ |
| 5 | Sparse FPA (opt **p**, *q*) | **Sparse FPA** | Sparse FPA: **p**⋆, *q*⋆ |
| 6 | FPA (opt **p**, *q*) | **FPA** | FPA: **p**⋆, *q*⋆ |
| 7 | FPA (equal **p**, *q*) | **FPA, equal power** | FPA: equal **p**, *q* |
| Caption note | "opt: optimized by Algorithm 1 (**p**, *q*) or Algorithm 2 (**t**)" | "Equal power: p_m = q = P_tot/N; all other schemes use the power allocation of Algorithm 1" | "⋆: optimized; **t**_rate: positions of [6]" |
| Strip of the five main schemes (9 pt; text width 7.16 in) | 7.17 in: needs two rows | **4.53 in: one row** | 6.25 in: one row |
| Strip of all seven (rows 1–4 / 5–7) | 6.01 + 3.98 in | 4.17 + 3.04 in | 5.21 + 3.62 in |

Widths are from `legend_widths.m` (the metrics and column layout of `plot_legend_strip.m`).

**Choice: Set B.** The report first recommended Set A. Set B is better on reflection:

- In Figs. 5, 7, and 8, all schemes share "(opt **p**, *q*)", so Set A's suffix distinguishes nothing there and only lengthens the legend. Set A's five-scheme strip (7.17 in) also no longer fits in one row.
- Set B labels only what differs. It keeps the five existing labels unchanged and fits in one row.
- The two new labels, "MA, equal power" and "FPA, equal power", make the 2 × 2 design readable in Fig. 6 without the caption.
- Set C needs ⋆ superscripts, which MATLAB's TeX legend markup lacks as far as I know (\ast gives ∗ instead), and it introduces a new symbol **t**_rate.

---

## 4. Final selection (made under your delegation)

| ID | Selection | Reason |
|---|---|---|
| D1 | **S0** (keep the current Stage 2) | §1: same performance, ≈ 16× faster, no solver; Zheng-type is slower to converge and worse without Stage 1 |
| D2 | (a) short form in IV-B; (b) brief remark in III-D 2); (c) stationarity condition in IV-A, general α⋆ in III-D 3), prediction in Fig. 5(b); (d) one sentence in V-B from `extra_mm_compare`; (e) skipped | §2 |
| D3 | Option C (your decision) **+ the random-Eve sentence** for M = 3, rerun with the new suite and sample size | With the Δ sweep gone, the default scenario is the only one shown; one random-Eve point (+10.2% over the rate-oriented MA in the stored data) answers a cherry-picking remark |
| D4 | Approximate-first (your decision) **+ the Monte Carlo ESSR along the iterations in Fig. 4**, default setting only | Shows that the true ESSR rises with the objective (as in Zheng et al.'s Figs. 3–4) and makes the ≈ 1.8 bps/Hz gap of V-B visible; ≈ 5 × 10³ Monte Carlo evaluations, under 1 min |
| D5 | 100 drops × 10³ realizations; Fig. 3: 10⁴ (your decision) | Applied to every Monte Carlo result in Sec. V, including the grid check and the AS footnote check, which are rerun |
| D6 | Keep the rate-oriented MA (your decision) | §3.1 |
| D7 | Remove Fig. 8 and V-G (your decision); equal power **p_m = q = P_tot/N**; q⋆ explicit (D2(c)); **heterogeneous-LU sentence dropped**; legend **Set B** | The equal-power definition has no parameter; the 2 × 2 design already shows the power-allocation gain, and the heterogeneous sentence would bring back the parameter S |
| D8 | AS only, with one rationale sentence in V-A; no APS curve (your decision) | — |
| D9 | Seven schemes, layout **L-A′** (§3.2) | Keeps every panel at the column size; ≤ 5 scheme curves per panel |
| D10 | Four subsections: V-A Setup and Benchmarks; V-B Accuracy and Convergence; V-C Secrecy Performance Versus Transmit SNR (Figs. 5, 6); V-D Impact of System Parameters (1) region size and number of MAs, Fig. 7; 2) Rician factors, Fig. 8) | Plan §8.1, with the Δ item removed (D3) |
| D11 | Two panels, κ ∈ {−10, −5, 0, 5, 10, 15, 20} dB, 20 dB, schemes 1, 3–6 (your decision) | Plan §8.2 |
