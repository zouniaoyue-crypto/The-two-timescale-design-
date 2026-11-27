# Rev-8f: analysis of the benchmark suite and revision plan (no manuscript changes yet)

Evidence used:

- `review/experiments/rev8e_benchmarks/analysis.txt`: full Monte Carlo results of the current suite, 100 drops.
- `review/experiments/rev8f_benchmarks/pilot_output.txt`: pilot for the APS code check and the FPA with Eve-aware AN.
  - The FPA numbers are **approximate ESSRs F** of (P3), not Monte Carlo values.
  - For the five schemes of Fig. 5, the approximation underestimates the actual ESSR by an almost constant 1.6–1.8 bps/Hz at 20 dB, so comparisons in F are indicative.

## 1. Eve-nulling MA → remove (agreed)

**Why it is weak as a published benchmark:**

- It is a heuristic of our own, with no counterpart in the literature.
- Its objective, the LoS correlation with Eve, ignores both the LUs' correlation and the power. A reviewer can dismiss it as a straw man built to lose.
- Its value was internal: it split the two groups of mechanisms. Table-style evidence (ρ₁, ξ₁, ψ) already supports that point in V-C.

**What is lost and how it is covered:**

- The M = 1 check of III-D 2) (Eve-nulling = proposed) is lost. Fig. 8(a) still shows the rate-oriented MA = FPA at M = 1, against +77.2% for the proposed design.
- The "neither group suffices" sentence goes. The mechanism numbers for the FPA, the rate-oriented MA and the proposed design stay.

**Action:**

- Remove it from `main_schemes`, the figures, V-A, V-C, V-D and the conclusion.
- Keep the code as supplementary.

## 2. APS → configuration and code verified; discard (your second path)

**Configuration matches Hu et al. (TVT 2025, Sec. IV):**

| Aspect | Hu et al. | Ours |
|---|---|---|
| Candidate locations | Antenna span quantized into discrete locations with spacing 0.5λ | λ/2 grid over C |
| Search | "The optimal location of each antenna is exhaustively searched from these locations" | Per-antenna exhaustive search, alternating |
| Objective | Their derived ergodic sum rate, i.e., the same objective as their proposed scheme | The objective of (P3), the same as ours |

**Code check** (`pilot_output.txt`; `evaluate_schemes.m`, case `APS`):

- All positions lie exactly on the λ/2 grid (distance 0), are distinct and keep the λ/2 minimum spacing.
- Stage 2 is disabled (`mmMaxIter = 0`).
- The initializations are snapped to the grid.
- Per drop, APS never exceeds the proposed design.

**Why it is so close here but not in Hu et al.:**

- Hu et al. use a one-dimensional array: N = 10 antennas in a span of L = 6–8λ, i.e., only 13–17 locations for 10 antennas. Discretization removes most of the freedom, hence their "certain gap".
- Our region is two-dimensional: 81 grid points for N = 8, and Stage 1 of Algorithm 2 is itself a grid search. APS is therefore Algorithm 2 without its refinement:

  | Sweep | Gap to the proposed design |
  |---|---|
  | SNR | 0.5–1.5% |
  | Region size A | ≤ 0.7% |
  | Number of MAs N | 2.6% at N = 4, vanishing at N = 16 |
  | Number of LUs M | 0–3.5% |

**Decision:** the configuration and code are correct and the performance is nearly identical, so **discard APS**.

- *Optional (not recommended):* a single sentence noting that restricting the MAs to a λ/2 grid costs at most 3.5% (useful for discrete actuators). It adds no curve, but it is a secondary message.

## 3. Eve-aware AN → recommend adding **"FPA with Eve-aware AN"** (not "MA with Eve-aware AN")

**Definition:** the BS keeps the λ/2 UPA but steers the AN toward the LoS component of Eve within the null space:

- AN covariance: Σ = (N−M) q P⊥ḡḡᴴP⊥ / (ḡᴴP⊥ḡ). It uses the same power as the isotropic AN and causes no interference to the LUs.
- The approximation (27) and Algorithm 1 apply with ψ replaced by ψ_dir = (N−M)(κ_e d + 1) ≥ ψ (the derivation of the removed Remark 1).

**Why it fits the suite:**

- **It is the conventional way a fixed array exploits the statistical CSI of Eve.** "Why move antennas if the BS can steer AN toward Eve?" is the first question a reviewer in AN-aided PLS will ask, and this benchmark answers it directly.
- **It completes a clean 2 × 2 structure.** The spatial information of Eve is exploited

  | | via the positions | via the AN | not at all |
  |---|---|---|---|
  | MAs | Proposed | — | Rate-oriented MA [Zheng] |
  | FPA | — | FPA with Eve-aware AN | FPA |

  Each benchmark then isolates one question.
- **The pilot shows informative, non-monotone behaviour** (approximate ESSR, 100 drops):

  | Setting | FPA | FPA + Eve-aware AN | Rate-oriented MA | Proposed |
  |---|---|---|---|---|
  | 10 dB | 6.25 | 7.37 | 7.78 | 9.73 |
  | 20 dB (default) | 14.21 | 16.31 | 16.51 | 18.98 |
  | 30 dB | 23.93 | 26.16 | 26.30 | 28.87 |
  | κ_e = −10 dB | 16.55 | 16.65 | 18.05 | 18.26 |
  | κ_e = 0 dB | 15.58 | 16.33 | 17.27 | 18.50 |
  | κ_e = 20 dB | 13.74 | 16.35 | 16.34 | 19.15 |

  - The Eve-aware AN lifts the FPA by about 15% at 20 dB and keeps it flat in κ_e, while the plain FPA degrades.
  - It still stays 10–32% (approx.) below the proposed design, with the gap growing with κ_e. The reason is that AN cannot reduce the information leakage ξ_m, whereas the positions can.
  - It meets the rate-oriented MA at κ_e = 20 dB, which gives a crossing.
- **It supports the III-A rationale for the isotropic AN:** even a fixed array that spends Eve's statistical CSI on the AN in every channel interval falls well short of the MAs with an isotropic AN.

**Why not "MA with Eve-aware AN":** since ψ_dir ≥ ψ, it would lie above the proposed curve, reading as "a benchmark beats the proposed design". It belongs to the future work already listed (joint design of the AN covariance and the positions).

**Risk:** a reviewer may ask "why not MA + Eve-aware AN?". The III-A sentence (no CSI of Eve needed per channel interval, protection against unknown eavesdroppers, attribution of the gain to the MAs) and the future-work clause answer it. No robustness study is needed for this benchmark.

**Cost:**

- Code (~1–2 h):
  - a ψ_dir option in `rate_coeffs`;
  - the directional AN covariance in `mc_rates` for the exact Monte Carlo evaluation;
  - scheme `FPA_ean`.
- Runs: ~10 min, since only the FPA is involved and there is no position optimization. The other schemes are added with `extra_add_schemes.m` on the same drops.
- One accuracy check of (27) with ψ_dir against Monte Carlo, in `verify_numbers`.

## 4. Fig. 6 → split into (a) and (b); standardize the labels

**Problem:** six curves in one panel.

- "MA, equal power" and "MA, no AN" cross near 10–15 dB.
- The three FPA curves overlap below 10 dB.

**Plan:** Fig. 6 becomes a two-panel figure*, with the same SNR axis and four curves and a 2 × 2 legend per panel:

| Panel | Question | Curves |
|---|---|---|
| (a) | Power allocation | Proposed, MA with equal power, FPA, FPA with equal power |
| (b) | AN | Proposed, MA without AN, FPA, FPA without AN |

**Labels** use the pattern "‹array› with/without ‹feature›": "MA with equal power", "MA without AN", "FPA with equal power", "FPA without AN", "FPA with Eve-aware AN".

**Space:** the figure grows by about one third of a column. Removing the Eve-nulling and APS text frees more than that, so about 15 pages are expected.

## 5. Reorganized suite (recommended)

| Figure | Schemes | Question each benchmark answers |
|---|---|---|
| Figs. 5, 7, 8 | Proposed; Rate-oriented MA [Zheng]; FPA with Eve-aware AN; FPA | MA without Eve-awareness / Eve-awareness without MA / neither |
| Fig. 6(a) | {Algorithm 1, equal power} × {MA, FPA} | Value of the long-term power allocation |
| Fig. 6(b) | {isotropic AN, without AN} × {MA, FPA} | Value of the AN; complementary gains |

**Styles:**

- FPA with Eve-aware AN: teal dashed △, in the fixed-array line style. This reuses the teal freed by APS.
- All legends: two columns.

**Fallback** if you prefer no Eve-aware AN: Figs. 5, 7, 8 with {Proposed, Rate-oriented MA, FPA} and Fig. 6(a)(b) as above. This is defensible (Zheng et al. use a similar set) but thinner.

## 6. Revision steps after your approval

1. **Code:**
   - Remove MA_null and APS from `main_schemes`, keeping them in the supplementary code.
   - Add `FPA_ean`: ψ_dir in `rate_coeffs`, the directional AN in `mc_rates`, and a style.
   - Split `plot_fig6` into (a) and (b), and rename the labels.
2. **Runs:**
   - `extra_add_schemes` for `FPA_ean` on all sweeps (~10 min).
   - Accuracy check of (27) for the Eve-aware AN.
3. **Text:**
   - V-A: the benchmark list, with the Eve-aware AN definition and ψ_dir in one or two sentences.
   - V-C: Fig. 5 discussion and the Fig. 6(a)(b) paragraphs.
   - V-D: A, N, M and κ_e paragraphs.
   - Conclusion.
   - Remove all Eve-nulling and APS sentences.
4. **Records and output:** `verify_numbers`, readme, ISSUES/CHANGELOG, then build (no errors, undefined references or overfull boxes), commit, and send the PDF.

## Decisions needed

1. Remove the Eve-nulling MA and APS: yes (as you proposed).
2. Add "FPA with Eve-aware AN": recommended / fallback without it.
3. Split Fig. 6 into (a) equal power and (b) without AN, with the new labels: recommended.
