# Revision plan rev-7: solution method and simulation validation

**Status:** proposal for your review. Nothing has been changed in `main.tex`, the MATLAB code, or the stored results. Each decision item (D1–D9) waits for your approval; once the combination is settled, the simulation section and all figures are regenerated in one pass.

**Sources.**

- Zheng et al., arXiv:2410.05912 (`ZhengTCOM2025`). Equation and figure numbers below are those of the arXiv version in the repository.
- Hu et al., IEEE TVT, vol. 74, no. 3, 2025 (`HuTVT2025`).
- Chen et al., arXiv:2604.23663 (`ChenArxiv2026`), for its benchmarks and Eve placement.

All numbers about our design come from the stored results in `ma_secrecy_matlab/results/`; no new simulation was run. Line and equation numbers refer to `manuscript/main.tex` and `main_preview.pdf` at commit 764ae78.

---

## Summary of recommendations

| ID | Question | Recommendation | Main alternative |
|---|---|---|---|
| D1 | (2.1) Which MM method | Keep our Stage-2 MM: descent-lemma quadratic minorizer, backtracking, closed-form projection. Do not adopt the MM–SCA surrogate of Zheng et al. | Switch Stage 2 to a Zheng-type surrogate with closed-form curvature, solved by CVX |
| D2 | (2.2, 2.3) Derivation depth | Add four items: (a) an explicit Lipschitz bound and finite termination of the backtracking; (b) a new exact single-LU result (optimal positions null Eve's LoS correlation); (c) the optimal AN power q as displayed equations; (d) a complexity/runtime comparison | Add only (c) |
| D3 | (3) AoD offset Δ | Keep the "Eve near an LU" scenario and the single-LU sweep (Fig. 7), reinterpret Δ through D2(b), add a random-Eve robustness check, and remove the secondary Δ discussion | Remove the Δ sweep and keep only the default scenario |
| D4 | (4) Ergodic approximation vs direct surrogate | Keep "deterministic approximation first". Optionally add the Monte Carlo ESSR along the iterations in Fig. 4, as in Zheng et al.'s Figs. 3–4 | — |
| D5 | (5) Sample size | 100 AoD drops × 10³ channel realizations for Figs. 5–7; keep 10⁴ for Fig. 3 | 50 drops × 10³ |
| D6 | (6.1) Rate-oriented MA | Keep it: it is the closest prior design, and it isolates the Eve-aware positioning | — |
| D7 | (6.2) Power allocation and Fig. 8 | Remove Fig. 8 and Sec. V-G; build the power allocation into the benchmarks as a 2 × 2 design {MA (opt t), FPA} × {opt p, q; equal p, q}; display the optimal q | Keep Fig. 8 with a better-introduced x-axis |
| D8 | (6.3) AS vs APS | Keep AS (as in Chen et al.) and add one sentence of rationale; do not plot APS | Add an APS curve |
| D9 | (6.4) Benchmark suite | Seven-scheme suite with the figure assignment of §7.4 | — |
| D10 | (7.1) Subsections of Sec. V | Merge the seven subsections into four, grouped by purpose: setup; accuracy and convergence; performance vs. SNR; impact of system parameters (§8.1) | Three subsections |
| D11 | (7.2) Rician factor | Add one figure: ESSR vs. (a) the common Rician factor κ = κ_m = κ_e and (b) Eve's Rician factor κ_e, with the benchmark suite. It replaces the removed Fig. 8 (§8.2) | Panel (a) only, as in Zheng et al.

---

## 1. MM refinement: ours vs. Zheng et al. (question 2.1)

### 1.1 What the two methods do

**Zheng et al., ZF case (their Sec. IV), in four layers:**

1. **Jensen lower bound (37):** R^lb_ZF,m = log₂(1 + p_m β_m (N−M) / (σ² [Σ⁻¹(t)]_mm)). This is identical to our (20); we state this in Sec. III-B.
2. **Element-wise Woodbury, (44)–(48):** [Σ⁻¹(t_n)]_mm = (ḡ_nᴴ X_{n,m} ḡ_n) / (ḡ_nᴴ Y_n ḡ_n), a ratio of quadratic forms in the steering vector ḡ_n(t_n) of antenna n. It uses ḡ_nᴴ ḡ_n = M.
3. **Lemma 1, an MM step:**
   - A first-order Taylor bound on the jointly convex quadratic-over-linear function, plus a λ_max(X_{n,m}) majorization.
   - The result, (55), is log₂(1 + η_m (χ + Σ_u |q_u| cos(2π t_nᵀ a_u/λ − ∠q_u))).
4. **SCA step:**
   - A second-order Taylor bound on that cosine sum, with the closed-form curvature ξ_{m,n} = (4π²/λ²) λ_max(Ξ), (61)–(63).
   - This gives a convex QCP (P5.n), solved by CVX.
   - Complexity is O(L ln(1/ε) N^4.5).
   - Their Sec. V reports convergence "within 500 iterations" (Fig. 4).

**Ours (Sec. IV-B):**

1. The same Jensen approximation for the LUs, (20), plus our new Eve approximation, (25)–(27).
2. A rank-one structure, (38)–(40): F(t_n) costs O(M²) per candidate position.
3. **Stage 1:** a grid search over |G| = 1681 points (spacing λ/10). The current position is one of the candidates.
4. **Stage 2:** MM with the descent-lemma minorizer (46).
   - It uses the exact gradient (45), derived in App. C.
   - The curvature δ_n is found by backtracking.
   - The subproblem is solved in closed form by projection onto the polygon formed by C and the linearized distance constraints (47).
   - The update is (48), and monotonicity is shown in (49).

Stage 2 is the MM form of a projected gradient step with backtracking [Beck 2017]. Hu et al. solve the same kind of [Σ⁻¹]_mm objective with exactly this method: "projected gradient ascent with backtracking line search", their (11). Our position update is therefore standard. What is specific to our paper is Stage 1 together with the O(M²) rank-one evaluation, and the secrecy objective.

### 1.2 Pros and cons

| | Zheng-type MM–SCA (closed-form curvature) | Ours (descent lemma with backtracking) |
|---|---|---|
| Rigor and "depth" impression | Every constant is explicit; the derivation looks deep, and MA reviewers know it | The curvature is not written out; a reviewer may ask about the Lipschitz constant and termination (fixable, D2(a)) |
| Fit to our objective | Needs a separate restructuring of each term; the Eve term needs several extra bounding layers (§2.2) | Applies directly to the full secrecy objective with its exact gradient |
| Tightness of the surrogate | Loose: each λ_max majorization loosens it | Tight up to the local curvature found by backtracking |
| Convergence speed | Slow: about 500 iterations even for their simpler sum-rate objective | Fast: 95.8% of the total increase within 3 AO iterations (Fig. 4) |
| Cost per subproblem | Convex QCP solved by CVX (interior point, solver overhead per call) | Closed-form projection, O(N³) |
| Global exploration | None (local method) | Stage 1 grid search escapes local maxima |
| Length of the text | About +2–3 pages for our objective | Current length (+0.5 page with D2(a)) |

### 1.3 Recommendation (D1)

**Keep our method.** Four reasons:

- It applies to the secrecy objective without additional bounds.
- Its decisive element, the global grid search, has no counterpart in Zheng et al. or Hu et al.
- Its subproblem has a closed-form solution.
- The reviewer concern it raises, a curvature that is not explicit, is closed by D2(a) at low cost.

Switching would lengthen the paper, slow the algorithm, and leave the results essentially unchanged (§2.4).

---

## 2. Feasibility of Zheng et al.'s derivation for our objective, and predicted impact (question 2.2)

### 2.1 LU term: feasible as is

With the Sherman–Morrison form (40) and κ_Σ ≜ Σ_m κ_m = ‖l_n‖², which is constant, we can write

ω_m(t_n) = (l_nᴴ X_m l_n) / (l_nᴴ Y l_n), with Y = Γ_n⁻¹ + I_M/κ_Σ and X_m = [Γ_n⁻¹]_mm Y − Γ_n⁻¹ e_m e_mᵀ Γ_n⁻¹.

This is exactly the ratio structure of Zheng et al.'s (46)–(47). Their Lemma 1 and their (59)–(63) therefore carry over to log₂(1 + p_m η_m(t_n)) without change.

### 2.2 Eve term: feasible, but long and loose

Our objective also contains −log₂(1 + p_m η_e,m(t_n)), which enters with a negative sign. Minorizing it requires a global *upper* bound on

η_e,m = (κ_e c_m + 1) / (q(κ_e d + N − M) + ζ_e⁻¹).

Through (40) and v = r_n + l_n e^{j2π t_nᵀ a_e/λ} from (39), the quantities c_m(t_n) = (|[Ωv]_m|² + N[Ω²]_mm)/ω_m and d(t_n) = (N−M)(N − vᴴΩv)/(N − M + N tr Ω) are ratios of quartic and squared-quadratic trigonometric forms. Five nested steps would be needed:

1. A tangent upper bound of log(1 + x) in η_e,m.
2. A quadratic upper bound of −log(B), using B ≥ q(N−M) + ζ_e⁻¹.
3. A majorizer of c_m: quadratic-over-linear convexity plus a λ_max majorization, applied twice (for |[Ωv]_m|² and for [Ω²]_mm).
4. A minorizer of d, which involves the two ratios vᴴΩv and tr Ω.
5. A Hessian bound for the resulting cosine sum, which has frequencies a_i − a_j and a_e − a_i.

**Verdict:** mathematically feasible. It costs about 2–3 pages, including a new appendix and several new constants. The surrogate would be considerably looser than Zheng et al.'s, which already needs about 500 iterations.

### 2.3 A closed-form curvature for the whole objective (no restructuring)

Also feasible. Every derivative is bounded because:

- Φ ⪰ N I_M, so ‖Ω‖ ≤ 1/N;
- ω_m ≥ 1/(N(κ_m+1));
- ‖l_n‖² = κ_Σ;
- |a_{m,u}| ≤ 1.

For example, with the default parameters (N = 8, M = 3, κ_m = 10 dB, distances in λ) the elementary bounds give, for the LU term alone,

|∂²/∂u∂v log₂(1 + p_m η_m)| ≤ (k²/ln 2) (|∂²ω_m|/ω_m + 3(|∂ω_m|/ω_m)²) ≈ 1.2 × 10⁶ per user, with k = 2π.

The bound does not depend on the SNR, but it is several orders of magnitude above the curvature met in practice: F changes by O(1) bps/Hz over a fraction of a wavelength. Used as a fixed step size 1/δ it would stall the MM. Used as a cap for the backtracking it is useful; see D2(a).

### 2.4 Predicted impact on the simulations

The three scenarios compared below:

- **S0:** keep the current method (recommended).
- **S1:** Zheng-type surrogate in Stage 2, keeping Stage 1.
- **S2:** Zheng-type local AO (MM–SCA), without Stage 1.

| | S0 | S1 | S2 |
|---|---|---|---|
| Final ESSR | baseline | ≈ unchanged | lower |
| Convergence (AO iterations) | ≈3 to reach 95%, ≈15 to reach 99% | ≈ unchanged; each Stage-2 call slower | hundreds of iterations |
| Cost of a Stage-2 iteration | O(M²) gradient + O(N³) projection | one CVX/QCP solve | one CVX/QCP solve |
| Time per drop (Octave, 3 initializations) | ≈ 4.2 s | ≈ 10³–10⁴ solver calls, i.e., minutes to tens of minutes | similar, plus hundreds of AO iterations |
| Manuscript change | small | large (new surrogate, new appendix) | large, and the grid-search contribution is lost |

Evidence behind each column:

- **S0:** final ESSR, convergence counts and time per drop come from Fig. 4 data and the grid check (`fig4_convergence.mat`, `extra_grid_check.mat`, 20 drops).
- **S1:**
  - The final ESSR is insensitive to the grid resolution: halving the spacing changes it by 0.011%. Stage 2 therefore refines within a grid cell, so its surrogate cannot change the outcome noticeably.
  - The 10³–10⁴ solver calls per drop are an estimate: 15 AO iterations × 8 MAs × up to 20 MM iterations × 3 initializations.
- **S2:**
  - The "MM only" curve of Fig. 4 (N = 8, 20 dB, average of 100 drops) reaches 17.63 vs. 18.91 bps/Hz at iteration 15 (−6.7%) and 18.17 vs. 18.94 at iteration 50 (−4.1%), and is still rising.
  - Zheng et al.'s Fig. 4 needs about 500 iterations.
  - Their stated complexity is O(L ln(1/ε) N^4.5).

---

## 3. Macro-level assessment and room for improvement (question 2.3)

### 3.1 Likely reception

**Strengths a TCOM/TWC reviewer will see:**

- A clear two-timescale protocol.
- A tractable ZF + null-space AN structure with long-term (p, q).
- A new closed-form Eve approximation that captures the Eve–LU LoS correlation (Fig. 3: within 0.052 bps/Hz).
- Physically interpretable mechanisms (Sec. III-D).
- A monotone algorithm with a complexity analysis.
- Fast convergence.

**Likely criticisms:**

- (i) "The position update is a standard gradient-type method."
- (ii) "The AN power is found by a grid search; is there anything analytical about q?"
- (iii) "The convergence statement covers the objective value only."
- (iv) "Is the default scenario (Eve close to LU 1) chosen to favor MAs?"
- (v) Benchmark fairness and completeness (§7).

None of these requires changing the framework.

### 3.2 Improvements within the current framework (D2)

| Item | What | Where | Effort | Answers |
|---|---|---|---|---|
| D2(a) | Closed-form upper bound L̄_n on the Lipschitz constant of ∇F(t_n), using the chain of §2.3; statement that δ_n ≤ 2L_n and that the backtracking stops after at most ⌈log₂(L̄_n/δ₀)⌉ + 1 trials; one sentence that the loss of the grid search is O(s²) in the grid spacing s (descent lemma around an interior maximizer), consistent with the 0.011% check | App. C (new paragraph), one sentence in Sec. IV-B | 0.5 page | (i), (iii) |
| D2(b) | **New exact single-LU result** (Proposition 2), below | Sec. III-D 2), Fig. 7 | 0.5 page + 1 curve | (iv); adds depth |
| D2(c) | **Optimal q made explicit**: (1) a displayed stationarity condition of F⋆(q) from the envelope theorem; (2) the high-SNR optimum displayed as an equation; (3) the predicted high-SNR AN fraction 1 − α⋆, computed at the optimized designs, shown in Fig. 5(b) | Sec. IV-A, III-D 3), Fig. 5(b) | 0.3 page | (ii); also your request in 6.2 |
| D2(d) | Complexity/runtime comparison: orders for ours, Zheng et al. (CVX) and Hu et al. (PGA), plus the measured CPU time per frame of Algorithm 2 | Sec. IV-C or V-C | needs timing runs | (i) |
| D2(e) (optional) | Statement that Stage 2 converges to KKT points of (P3.2.n), via inner-approximation MM theory | Sec. IV-C | needs new references, which you must approve (CLAUDE.md rule 4) | (iii) |

**Details of D2(c).**

(1) The stationarity condition, obtained from the envelope theorem with the water-filling (36), is

Σ_m p_m⋆ η_e,m ψ / ((qψ + ζ_e⁻¹)(1 + η_e,m p_m⋆)) = (N − M) ν ln 2.

It reads: the marginal leakage reduction per unit of AN power equals the water level. Because F⋆(q) may have several stationary points, Algorithm 1 keeps its grid search, which is now motivated by this equation.

(2) The high-SNR optimum is

q⋆ = (√Ξ / (1 + √Ξ)) · P_tot/(N − M), from α⋆ = 1/(1 + √Ξ),

which is currently inline in line 398. For unequal Ξ_m, the optimal α solves M/α − M/(1 − α) = Σ_m (Ξ_m − 1)/(1 + α(Ξ_m − 1)).

(3) The stored AN fractions (0.27 for the proposed design and 0.47 for the FPA at 20–30 dB) suggest Ξ ≈ 0.14 and Ξ ≈ 0.8. This is to be checked during regeneration.

**Details of D2(b), single LU (M = 1). New, exact, and directly tied to Δ:**

- *Optimality.* For M = 1, η₁ does not depend on t. By (30)–(31), ξ₁ increases with ρ₁(t) and ψ decreases with ρ₁(t). Hence the approximate secrecy rate decreases strictly in ρ₁(t) for every (p, q), and any feasible t with ρ₁(t) = 0 is optimal for (P3). The maximum is then c₁ = 1/(κ₁+1) with d at its maximum, and the remaining optimization is one-dimensional in q.
- *Existence (sufficient).* Let b ≜ a_e − a₁. Place N/2 antenna pairs, the two antennas of each pair separated by λ/(2‖b‖) along b, so that each pair sums to zero. For N even this is feasible in the square C if λ/(2‖b‖) + (N/2 − 1)λ/2 ≤ A.
- *Necessity.* The phases 2π t_nᵀ b/λ must span at least π. Hence ρ₁ = 0 is impossible if λ/(2‖b‖) > √2 A.

For A = 4λ and N = 8 this gives a transition window of 0.09 ≲ ‖b‖ ≲ 0.2 (‖b‖ ≈ Δ for moderate angles).

The stored Fig. 7 data matches this. The proposed design rises up to Δ ≈ 0.2 and then saturates: 8.692, 8.693 and 8.694 bps/Hz at Δ = 0.3, 0.4 and 0.5, identical to three decimals. This is the level predicted for ρ₁ = 0. The gain over the FPA then decreases because the FPA's own correlation falls with Δ.

During implementation, this is to be verified on the stored designs (ρ₁ at the solutions) and the saturation level shown as a dashed line in Fig. 7.

**Not recommended:**

- switching the LU approximation (Zheng et al. and Hu et al. use the same one);
- stochastic SCA or sample-average approximation (§5.3);
- metaheuristics such as PSO.

---

## 4. The AoD offset Δ (question 3)

### 4.1 Role in the paper

Δ parameterizes the scenario that the introduction uses as the motivation (line 74, with [Mukherjee2014, HuSPL2024]): Eve in a direction close to that of an LU, with a dominant LoS path, where an FPA cannot separate Eve. It appears in the default setup (V-A, Δ = 0.1 rad, ρ₁ > 0.94 for the FPA), in the sweep of Fig. 7 (M = 1), and in the V-F text (M = 3 trend). Chen et al. also place Eve at a fixed angular offset from the user: 30° in azimuth.

### 4.2 Stored data: secrecy gain of the proposed design

| Eve direction | M = 1: gain over the FPA (= rate-oriented MA) | M = 3: gain over the rate-oriented MA |
|---|---|---|
| Δ = 0.02 rad | 9.1% | 2.4% |
| Δ = 0.05 rad | 36.1% | 8.8% |
| Δ = 0.1 rad (default) | 77.1% | 14.8% |
| Δ = 0.2 rad | 79.3% | 14.0% |
| Δ = 0.5 rad | 32.6% | 10.7% |
| random, independent of the LUs (Δ = ∞) | 13.1% | 10.2% (FPA: +21.7%) |

Sources: `extra_single_user.mat`, `extra_angle_offset.mat`, `extra_random_eve_M1.mat`, `extra_random_eve_M3.mat`.

### 4.3 Reviewer view

The scenario is necessary: it is where the paper's mechanism, Eve-aware LoS decorrelation, matters most and where FPAs and rate-oriented designs fail. The parameterization is the weak point. An "offset in the (θ, φ) plane in a random direction" looks ad hoc, and showing only Δ = 0.1 rad invites a cherry-picking remark. The random-Eve numbers above (still +10–13%) remove that concern.

### 4.4 Options

| | What | Pros | Cons |
|---|---|---|---|
| A | Keep as is | no work | parameter looks ad hoc; no analytical anchor |
| **B (recommended)** | Keep the default scenario and Fig. 7 (M = 1); add D2(b) so that Δ has a predicted threshold and a predicted saturation level; add one robustness sentence with a random Eve direction; delete the M = 3 trend sentence (2.4/14.8/10.7%); move the "elevation–azimuth coordinates" remark to a footnote | Fig. 7 becomes a validation of an exact result; focus on the main mechanism | one curve and one sentence more in Fig. 7 / V-F |
| C | Remove the Δ sweep (drop Fig. 7) and keep only the default scenario plus the random-Eve sentence | shortest | loses the only figure that isolates Eve-aware positioning (rate-oriented MA = FPA for M = 1) |

---

## 5. Zheng et al.'s Figs. 3–4 and comparison with our approach (question 4)

### 5.1 What the two curves are

Zheng et al. use two layers:

- **Layer 1:** a deterministic closed-form approximation of the ergodic rate. For MRT, (15) is an approximation and not a bound ("lies between the upper and lower bounds"). For ZF, (37) is the Jensen lower bound.
- **Layer 2:** a local surrogate in t_n (SCA for MRT; Lemma 1 plus a Taylor bound for ZF). It is tight at the expansion point t_n^ℓ.

**"Ergodic sum rate" curve:** the true ergodic sum rate obtained by Monte Carlo at the positions of iteration ℓ. Sec. V calls it the "actual values".

**"Surrogate function" curve:** the objective the algorithm actually maximizes. Layer 2 coincides with layer 1 at each expansion point, so this curve is, in effect, the layer-1 closed-form approximation evaluated at the iterates.

The evidence is in their Fig. 4 (MA-ZF, N = 6, M = 5):

- The surrogate curves (≈ 20.5 and ≈ 21.6 bps/Hz) lie ≈ 12 and ≈ 9 bps/Hz below the Monte Carlo curves (≈ 32.6 and ≈ 30.9, read from the figure), for κ = 100 and κ = 6 respectively.
- This is the looseness of the Jensen bound itself. In the LoS-dominant limit it is M log₂(N/(N−M)) = 5 log₂ 6 ≈ 12.9 bps/Hz, and the gap shrinks for the smaller κ.
- A layer-2 gap would instead vanish at convergence.

For MRT, their Fig. 3, the two curves almost coincide, because layer 1 is an approximation rather than a bound ("a minor gap between the surrogate and actual values").

So the surrogate curve corresponds to the initial ergodic approximation (layer 1), as seen through the tight layer-2 surrogate. It is not a separate quantity.

### 5.2 Comparison with our paper

| | Zheng et al. | Ours |
|---|---|---|
| Stochastic objective | Replaced by a closed form: Jensen bound for ZF, approximation for MRT | Replaced by a closed form: the same Jensen approximation for the LUs, plus a new approximation for Eve (ratio of means with trace matching, App. B) |
| Local surrogate | MM (Lemma 1) + second-order Taylor with closed-form curvature, then CVX | Global grid search + descent-lemma MM with backtracking, closed-form projection |
| Convergence plot | Monte Carlo rate and surrogate vs. iterations (Figs. 3–4) | Objective of (P3), i.e., layer 1, vs. iterations (Fig. 4) |
| Accuracy check | Gap visible in Figs. 3–4 | Separate accuracy figure (Fig. 3) and gap/ranking statement (V-B) |

Both papers therefore follow the same pipeline: *approximate first, then build a local surrogate*. Zheng et al. do not construct a surrogate directly from the stochastic objective. They state that the sample-based stochastic alternative "incurs high computational complexity depending on the scale of the channel samples" (their Sec. II-C).

### 5.3 Why we approximate first

The truly different alternative is a surrogate built on channel samples: stochastic SCA or sample-average approximation, cited in our Sec. IV-C as [ZhaoTWC2021]. It is less suitable here:

1. **Complexity.** Its cost grows with the number of samples, and every grid candidate in Stage 1 would need S samples × O(NM²), instead of O(M²).
2. **Insight.** The closed forms ω_m, c_m and d give the mechanisms of Sec. III-D, the single-LU result of D2(b), and the AN analysis of D2(c). A sample-based objective gives none of them.
3. **Accuracy.** Fig. 3 and V-B show that the approximation preserves the ranking of the designs for P_tot/σ² ≥ 10 dB.

**Recommendation D4:** keep our approach. Optionally, adopt Zheng et al.'s visualization: add the Monte Carlo ESSR along the iterations to Fig. 4 for one setting. It shows that improving the deterministic objective improves the true ESSR, and it costs a moderate re-run of Fig. 4 only.

---

## 6. Sample size (question 5)

**Current setup:** 100 random AoD drops × 5 × 10³ channel realizations per drop and scheme (10⁴ in Fig. 3). Channel samples and drops are shared by all schemes (paired comparisons).

**Conventions.**

- Zheng et al. do not state their Monte Carlo sizes (random user distances and angles).
- Hu et al. use one fixed geometry and an unstated number of samples.
- 10³ channel realizations per geometry is the common choice in TWC/TCOM papers.

**Where the uncertainty comes from (stored data).**

- At 20 dB, the standard error of the average ESSR of the proposed design over the drops is 0.55% (0.11 bps/Hz). The largest paired standard error between two schemes is 0.22 bps/Hz.
- Both come from the drop-to-drop variation (different AoDs), not from the channel sampling.
- With 10³ samples per drop, the Monte Carlo error is of order 0.05 bps/Hz per drop and about 0.005 bps/Hz after averaging over 100 drops. This is an estimate: instantaneous secrecy-sum-rate standard deviation of about 1.5 bps/Hz. It is two orders of magnitude below the drop-induced error, and it shrinks further in paired differences because the samples are shared.

**Recommendation D5:**

- 100 drops × 10³ channel realizations for all performance figures.
- Keep 10⁴ for Fig. 3, which reports approximation errors down to 0.013 bps/Hz. Fig. 3 involves only the proposed design, so it is cheap.
- Keep 100 drops. With 50 drops, all standard errors grow by √2 (paired: 0.22 → 0.31 bps/Hz); the proposed-vs-benchmark gaps (≥ 2.3 bps/Hz at 20 dB) would still be clearly resolved, but differences among the benchmarks would not.
- During regeneration, one SNR point is run with both 10³ and 5 × 10³ samples to confirm the prediction (change < 0.01 bps/Hz).

V-A would then read conventionally: "averaged over 100 random AoD realizations, each with 10³ channel realizations (10⁴ in Fig. 3)".

---

## 7. Benchmarks (question 6)

### 7.1 Rate-oriented MA (D6)

It is the two-timescale MA design of Zheng et al., the closest prior work. Its positions maximize the approximate ergodic sum rate of the LUs and ignore Eve. In our implementation it then uses our power allocation, Algorithm 1. It is the only benchmark that isolates the paper's central claim, the gain of Eve-aware over Eve-unaware positioning.

- Without it, a reviewer would ask whether the gain comes from MAs per se.
- For M = 1 it coincides with the FPA, which is Zheng et al.'s own Remark 2.

**Keep it.** If you prefer, rename it to "MA (sum-rate t [6], opt p, q)".

### 7.2 Power allocation audit and Fig. 8 (D7)

**Current configuration** (verified in `evaluate_schemes.m` and `power_opt.m`):

| Scheme | Positions | Power allocation |
|---|---|---|
| Proposed | Algorithm 2 (Eve-aware) | Algorithm 1: secrecy water-filling for p + grid search for q ("opt p, q") |
| Rate-oriented MA | sum-rate positions [Zheng] | Algorithm 1 after the positions |
| AS | swap search on the approximate ESSR (q on a 21-point grid) | Algorithm 1 for the selected subset |
| Sparse FPA, FPA | fixed | Algorithm 1 |
| Fig. 8: EP, optimized α | Algorithm 2 under EP | p_m = αP/M, q = (1−α)P/(N−M), α by 1-D search |
| Fig. 8: EP, α = 0.5 | Algorithm 2 under EP | α = 0.5 fixed [Chen] |

So every benchmark in Figs. 5–7 already uses optimal (p, q) for its own positions. The comparisons isolate the positions, and the gain of the power allocation appears only in Fig. 8 (V-G).

**Fig. 8 assessment.**

- Its x-axis S is a new parameter used nowhere else.
- In the default (homogeneous) setup, the per-user power allocation brings little: −1.2% for EP with optimized α at 10 dB.
- At 0 dB, EP with optimized α is even +1.1% *above* the proposed allocation in Monte Carlo (4.425 vs. 4.379 bps/Hz). This is an artifact of optimizing the approximation, and a reviewer would query it.

**Recommendation D7:**

1. **Remove Fig. 8 and Sec. V-G.** Build the power allocation into the benchmark design, Zheng-style, so that the main SNR figure shows a 2 × 2 design:

   | | opt p, q (Algorithm 1) | equal p, q |
   |---|---|---|
   | MA, positions by Algorithm 2 | **Proposed** | MA (opt t, equal p, q) |
   | FPA | FPA (opt p, q) | FPA (equal p, q) |

   **Definition of "equal p, q":** p_m = q = P_tot/N, uniform power over all N spatial streams, with no power optimization.
   - The label is literal and has no tuning parameter.
   - It equals α = M/N, so it is implemented with the existing `fix` mode by setting `alphaFix = M/N`.
   - For MA (opt t, equal p, q), Algorithm 2 designs the positions under this power, like Zheng et al.'s "MA-ZF (opt t)" with equal power.
   - *Alternative:* α = 0.5, as in Chen et al.
   - *Predicted:* 10–30% below the proposed design, depending on the SNR (stored α = 0.5 data at S = 0: −9.4% at 10 dB, −28.7% at 0 dB). The AN fraction is 0.625 against the optimized 0.27 at 20 dB.
   - EP with optimized α is not recommended as a curve, because of the inversion at 0 dB.
2. **Show the optimal q explicitly:** see D2(c), a displayed condition plus the high-SNR closed form, both validated in Fig. 5(b).
3. **Heterogeneous LUs (optional):** one sentence with the stored numbers, without introducing S. For example: with large-scale fading coefficients of the LUs of [0, −10, −20] dB, the per-user power allocation improves the ESSR over equal power with optimized splitting by 40%, 14% and 0.8% at 0, 10 and 20 dB (`extra_pa_spread_*`, `fig7_pa_hetero.mat`). Otherwise drop it.

Zheng et al.'s FPA benchmarks optimize the power with instantaneous CSI. In our framework every scheme uses the long-term power allocation, which keeps the CSI the same across schemes. An instantaneous-CSI FPA would mix the two timescales, so it is not recommended.

### 7.3 AS vs. APS (D8)

**APS in Hu et al.** ("alternating position selection"): each antenna is moved, alternately, to the best of the discrete positions on a λ/2 grid of the span, by exhaustive search. It is a discretized MA. In our framework it equals Algorithm 2 with Stage 1 on a λ/2 grid and no Stage 2.

**AS in our paper,** as in Chen et al. (their benchmark "AS"): select N out of 2N fixed antennas, a 4 × (N/2) UPA at λ/2. This is a different, movement-free reconfigurable architecture with the same number of RF chains, and antenna selection is a classical PLS technique.

**Rationale for AS:**

1. It is the benchmark of the closest secure-MA paper, Chen et al., together with the λ/2 UPA and the full-aperture UPA, our sparse FPA. Our suite mirrors theirs.
2. It compares MAs with a practical alternative hardware, not with a variant of our own algorithm.
3. APS mainly measures grid resolution. We already show that it hardly matters: halving the λ/10 grid changes the ESSR by 0.011%, and Fig. 4 shows the effect of Stage 1.

**Recommendation:** keep AS and add one sentence in V-A: "AS is a classical PLS technique that reconfigures the array without antenna movement, and is used as a benchmark in [Chen]." Do not add an APS curve. Optionally, state one number for "Stage 1 with a λ/2 grid and no Stage 2" in V-C.

### 7.4 Proposed benchmark suite and figure assignment (D9)

| # | Scheme (label) | Positions | Power | What it isolates |
|---|---|---|---|---|
| 1 | Proposed: MA (opt t, opt p, q) | Algorithm 2 | Algorithm 1 | — |
| 2 | MA (opt t, equal p, q) | Algorithm 2 under equal power | p_m = q = P/N | gain of the power allocation |
| 3 | Rate-oriented MA (opt p, q) [Zheng] | sum-rate positions | Algorithm 1 | gain of Eve-aware positioning |
| 4 | AS (opt p, q) [Chen] | N of 2N | Algorithm 1 | MA vs. antenna selection |
| 5 | Sparse FPA (opt p, q) [Chen, FPA-F] | full-aperture UPA | Algorithm 1 | positions vs. aperture |
| 6 | FPA (opt p, q) | λ/2 UPA | Algorithm 1 | MA vs. FPA |
| 7 | FPA (equal p, q) | λ/2 UPA | p_m = q = P/N | conventional baseline (neither) |

| Figure | Curves |
|---|---|
| Fig. 5(a) ESSR vs. SNR | 1–7 |
| Fig. 5(b) AN power fraction vs. SNR | 1, 3–6, plus the high-SNR prediction 1 − α⋆ (D2(c)) |
| Fig. 6(a) ESSR vs. A, Fig. 6(b) ESSR vs. N | 1, 3–6 (equal-power variants add nothing here) |
| **new** Fig. 7 (D11): ESSR vs. (a) κ = κ_m = κ_e and (b) κ_e with κ_m = 10 dB | 1, 3–6 |
| Fig. 8 (now Fig. 7): ESSR vs. Δ, M = 1 | 1, 3 (= 6), 4, 5, plus the saturation level of D2(b) |
| current Fig. 8 (power allocation vs. S) | removed (D7) |

If D11 is not adopted, the Δ figure keeps the number 7.

**Styling for seven curves:**

- Color and marker identify the position design (red ○ proposed positions, blue □ rate-oriented, teal △ AS, ochre ▽ sparse FPA, gray ◇ FPA).
- Line style identifies the power allocation: solid for opt p, q; dotted with filled markers for equal p, q.
- Schemes 2 and 7 are thus read immediately as the equal-power versions of 1 and 6.

**Expected values at 20 dB:**

- From stored data: 20.75 / 18.08 / 17.24 / 17.75 / 15.82 bps/Hz for schemes 1/3/4/5/6.
- Predicted: schemes 2 and 7 roughly 10–30% below schemes 1 and 6, respectively.

**Runtime of the regeneration (rough estimate):**

- About 4–6 h in Octave with 4 parallel sessions (about 4 h for the current set according to the readme).
- Scheme 2 adds one more Algorithm-2 run per point, while the sample reduction (D5) and the removal of Fig. 8 save time.
- The Rician-factor figure (D11) adds about 1.5–2.5 h.
- MATLAB is faster.

---

## 8. Structure of Section V and Rician-factor analysis (question 7)

### 8.1 Subsection structure (D10)

| Current subsection | Figure | Paragraphs |
|---|---|---|
| V-A Simulation setup and benchmarks | — | 4 + benchmark list |
| V-B Accuracy of the closed-form approximations | Fig. 3 | 1 |
| V-C Convergence behavior of Algorithm 2 | Fig. 4 | 1 |
| V-D ESSR and AN power versus transmit SNR | Fig. 5 | 2 |
| V-E Impact of the region size and the number of MAs | Fig. 6 | 2 |
| V-F Impact of the AoD offset | Fig. 7 | 1 |
| V-G Benefit of the long-term power allocation | Fig. 8 | 2 (removed under D7) |

**Reviewer view.**

- Three subsections consist of one figure and a single paragraph, which fragments the section.
- Simulation sections in TCOM/TWC are usually grouped by purpose into three or four subsections: setup; validation of the analysis and the algorithm; performance comparison; impact of the system parameters.
- Neither Zheng et al. (Sec. V) nor Hu et al. use subsections at all.
- Our Sections III-D and IV-B already use italic run-in headings ("1) …:"), and the same device can structure merged subsections.

**Recommendation D10: four subsections.**

| New subsection | Content | Figures |
|---|---|---|
| V-A Simulation Setup and Benchmarks | Parameters; Monte Carlo sizes (D5); the seven schemes with the 2 × 2 power-allocation design (D7, D9); AS rationale (D8) | — |
| V-B Accuracy and Convergence | 1) Accuracy of the approximations, with the qualified ranking statement; 2) convergence of Algorithm 2, with the local-MM comparison and the optional Monte Carlo curve (D4) | Figs. 3, 4 |
| V-C Secrecy Performance Versus Transmit SNR | ESSR of the seven schemes: positioning gains (1 vs. 3–6) and power-allocation gains (1 vs. 2, 6 vs. 7), which replace V-G; AN power and the optimal q (D2(c)) | Fig. 5 |
| V-D Impact of System Parameters | 1) Region size and number of MAs; 2) Rician factors (D11); 3) angular separation between Eve and a single LU, which validates Proposition 2 (D3, D2(b)) | Figs. 6, 7 (new), 8 |

**Alternative:** three subsections, merging V-C and V-D into one "Performance Comparison". That subsection would hold four figures, so it is not recommended.

### 8.2 ESSR versus the Rician factor (D11)

**Why it should be added:**

- **Expected by reviewers.** In Zheng et al., the ergodic sum rate versus κ is one of the main results (their Figs. 7–8, κ from −5 to 30 dB). Reviewers of two-timescale MA papers expect it, because a statistical-CSI design acts on the channel only through the LoS components.
- **It makes our analytical results visible.** In our paper the Rician factors drive every analytical result:
  - Proposition 1: exact for κ_m = 0, with a limit for a growing κ₁;
  - the bound (21): positioning raises the effective LU gain by at most a factor κ_m + 1;
  - the three mechanisms of Sec. III-D.

  A κ sweep with the benchmarks turns these statements into visible trends. Fig. 3(b) currently sweeps κ only to check the accuracy for the proposed design, not to compare the schemes.
- **It adds a security-specific dimension that Zheng et al. cannot have: Eve's Rician factor κ_e.** By (27), if κ_e = 0 then Eve's approximate rate does not depend on t (ξ_m = 1 and ψ = N − M). The Eve-aware design then reduces to a rate-oriented design with optimized power, and its gain over the rate-oriented MA must grow with κ_e. This is a clean, verifiable prediction of our analysis.

**Predicted trends** (to be confirmed by the new runs):

- **(a) Common κ = κ_m = κ_e.**
  - In the Rayleigh limit (κ → −∞ dB), the channel statistics no longer depend on the antenna positions, because the NLoS components are spatially uncorrelated over C. All seven schemes therefore converge.
  - As κ grows, the MA gains grow, and the FPA degrades in the default scenario (Eve in the main lobe of LU 1).
  - The gains level off for large κ, consistent with the LoS limit of Proposition 1 and with (21).
- **(b) κ_e with κ_m = 10 dB.**
  - The proposed design and the rate-oriented MA coincide for small κ_e.
  - The Eve-aware gain grows with κ_e.

**Recommendation D11: add one figure with two panels.**

- ESSR versus (a) κ = κ_m = κ_e and (b) κ_e with κ_m = 10 dB, each over {−10, −5, 0, 5, 10, 15, 20} dB, at 20 dB transmit SNR.
- It shows the position schemes 1 and 3–6 with the optimized power; the equal-power variants add nothing here.
- It takes the place of the removed Fig. 8, so the page count stays about the same, and goes into V-D as item 2).
- New runs: 2 × 7 points × 100 drops × 5 schemes, about 1.5–2.5 h in Octave with 4 parallel sessions (rough estimate).
- Fig. 3(b) stays as the accuracy check.

**Alternatives:** panel (a) only, as in Zheng et al., which halves the run time; or panel (b) only, the novel dimension.

---

## 9. Implementation sequence (after approval)

1. **Code:**
   - Equal-power mode with α = M/N.
   - New schemes `FPA_eq` and `MA_eq` (the latter reuses `MA_fix`).
   - Sample size S = 10³ (10⁴ for Fig. 3).
   - Suite and styling per D9.
   - Saturation line (D2(b)), 1 − α⋆ markers (D2(c)), and, if approved, the Monte Carlo ESSR in Fig. 4 (D4).
   - Remove the Fig. 8 driver from `run_all`/`replot_all`.
   - Extend `verify_numbers.m` for every new number.
2. **Runs:** Figs. 5, 6(a), 6(b) and the Δ figure with the new suite and sample size; the new Rician-factor figure (D11); the random-Eve check (one point); Fig. 3 unchanged (or rerun if D2 changes the design); Fig. 4 if D4. You can run them in MATLAB with `run_all`; I give the exact commands and read back the result files.
3. **Text:**
   - IV-A: optimal q (D2(c)).
   - III-D 2): Proposition 2 (D2(b)).
   - App. C and IV-B: Lipschitz bound (D2(a)).
   - Sec. V regrouped into four subsections with run-in headings (D10).
   - V-A: setup, benchmarks, AS rationale, sample size.
   - V-C: the 2 × 2 power-allocation discussion, which replaces V-G.
   - V-D: Rician factors (D11) and Δ (D3).
   - Removal of Fig. 8, V-G, and the S-related sentences.
   - Conclusion and abstract checked for consistency.
4. **Checks:** build without errors, undefined references or overfull boxes; every Section V number traceable via `verify_numbers.m`; ISSUES/CHANGELOG updated.

**Unchanged:** the system model, the approximations (20) and (27), Algorithm 1's structure, the two-stage Algorithm 2, Figs. 1–4 (apart from D4), and the default parameters (N = 8, M = 3, A = 4λ, κ = 10 dB, Δ = 0.1 rad).

---

## 10. Decision checklist

| ID | Decision | Options |
|---|---|---|
| D1 | Stage-2 MM | keep (rec.) / switch to Zheng-type |
| D2 | Depth items | (a) Lipschitz bound / (b) single-LU proposition / (c) explicit q / (d) runtime / (e) KKT (needs refs): choose any |
| D3 | Δ | A keep / B reinterpret (rec.) / C remove sweep |
| D4 | Monte Carlo curve in Fig. 4 | yes / no |
| D5 | Sample size | 100 × 10³ and Fig. 3 10⁴ (rec.) / 50 × 10³ |
| D6 | Rate-oriented MA | keep (rec.) / rename |
| D7 | Fig. 8 | remove + 2 × 2 power-allocation benchmarks (rec.) / keep; equal power: p = q = P/N (rec.) / α = 0.5; heterogeneous sentence: keep / drop |
| D8 | AS vs. APS | keep AS + rationale (rec.) / add APS curve |
| D9 | Suite and figure assignment | as in §7.4 / modify |
| D10 | Subsections of Sec. V | four (rec.) / three / keep seven |
| D11 | Rician-factor figure | panels (a) + (b) (rec.) / (a) only / (b) only / none |
