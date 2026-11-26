# Rev-8c report: candidate comparisons, simulation–insight audit (item 4), benchmark suite (item 5)

Numbers come from `review/experiments/rev8c_candidates/analysis.txt` and `review/verify_numbers_rev8.txt`. All runs use the current code with 100 drops and S = 10³.

The candidate figures are in `manuscript/main_candidates.pdf`, a separate copy of the paper; `main.tex` is unchanged by them. In that copy:

- the new text is blue and tagged [C1]–[C4];
- Figs. 3–8 keep their numbers, and the candidates are Figs. 9–13.

## A. Candidate figures and suggestions

| | Figure | Key results | What is new | Suggestion |
|---|---|---|---|---|
| C1 | Fig. 11: ESSR vs number of LUs M (N = 8, 20 dB) | **M = 1:** the rate-oriented MA equals the FPA exactly (4.22 bps/Hz), while the proposed design reaches 7.48 (+77.2%). The FPA puts 84% of the power into AN; the proposed design puts 50%. **Over the rate-oriented MA:** the gain stays at 2.47–3.39 bps/Hz for all M. **Over the FPA / sparse FPA:** the gains rise to 64.4% / 47.4% at M = 6, and the FPA's ESSR even drops from M = 5 to M = 6. | The only numerical support in Section V for the abstract's "even for a single LU". The curves are not uniformly ordered: two benchmarks coincide at M = 1, and the gain over the FPA is U-shaped. | **Keep, as a figure.** |
| C4 | Fig. 9, or Fig. 10 (Fig. 6 with the no-AN curves added) | **Without AN:** the ESSR saturates at 13.85 bps/Hz at 30 dB; the slope from 25 to 30 dB is 0.05 bps/Hz per dB, versus 0.99 with AN. **Value of the AN:** +58.9% at 20 dB and +121.1% at 30 dB. **Positions alone:** +30.5% to +31.2% over the FPA for SNR ≥ 5 dB. **Crossing:** the MAs without AN beat the FPA with AN for SNR ≤ 15 dB, but not at higher SNR. | Crossing curves. Shows that the gains of the positions and of the AN add up, which matches the high-SNR analysis (slope M with AN, about 0 without). | **Keep, merged into Fig. 6** (Fig. 10 layout): no extra figure, about 4 sentences. |
| C2 | Fig. 13: ESSR vs error in Eve's AoD at the BS | **Proposed design's loss:** below 0.5% up to 0.02 rad, 2.95% at 0.05 rad, 9.73% at 0.1 rad. **Still best at 0.1 rad:** +4.4% over the rate-oriented MA (0.79 ± 0.13 bps/Hz). **Benchmarks:** lose at most 1.82%. | The robustness evidence reviewers expect for a design based on statistical CSI of Eve. | **Keep as two sentences.** The figure is optional, since the benchmark curves are flat. |
| C3 | Fig. 12: ESSR vs Eve's large-scale fading β_e | **Proposed design:** −2.2% over β_e = −10 → 10 dB, versus −5.7% for the rate-oriented MA and −10.8% for the FPA. **Gains grow:** from 11.1% to 15.3% over the rate-oriented MA, and from 21.1% to 32.8% over the FPA. **Reason:** as ζ_e grows, the wiretap rate in (27) depends only on the leakage-to-AN ratio, which the MAs reduce. | Eve close to the BS costs the proposed design little. | **One or two sentences, no figure.** The shape repeats Fig. 8. |

**Page estimate:** C1 as a figure, C4 merged into Fig. 6, and C2/C3 as text add about half a page, giving about 15 pages. The review copy with all five figures is 16 pages.

## B. Item 4: analytical insights without a simulation echo

1. **How the positions achieve the gain (high priority).**
   - **Claim:** the abstract's central claim is that "the MAs reduce the information leakage and increase the AN received by Eve" (III-D 1).
   - **Gap:** Section V shows only the resulting ESSR and AN fraction. No figure or table reports, for the optimized positions:
     - the LoS correlation between Eve and LU 1, ρ₁(t);
     - the information leakage, c_m(t) or ξ_m(t);
     - the AN power at Eve, d(t) or ψ(t);
     - the leakage-to-AN ratio, Ξ_m(t).
   - **Not covered by C1–C4.** Reviewers often ask to see that the optimized positions behave as the analysis predicts. Two examples: ρ₁ ≈ 0 for the proposed design, against ρ₁ ≥ 0.94 for the FPA; and the reduction of Ξ.
   - **Suggestion:** one small table at the default point (FPA / rate-oriented MA / proposed) with the average ρ₁, ξ₁, ψ and Ξ, or a CDF of ρ₁ over the drops.
   - **Cost:** one rerun at the default point that stores the positions, about 15 min.
2. **Region size needed to null the LoS correlation (medium).**
   - **Claim (III-D 2):** gives a sufficient and an infeasibility condition on A, and concludes that "the region size required … increases as Eve approaches the LU in direction".
   - **Gap:** Fig. 7(a) varies A only at the fixed 0.1 rad offset, and the offset sweep was removed in rev-7. **Not covered by C1–C4.**
   - **Suggestion:** for M = 1, plot the fraction of drops with ρ₁ ≈ 0 (or the ESSR) versus A for two offsets, e.g. 0.05 and 0.2 rad. Alternatively, one sentence with the fraction of drops at A = 4λ that satisfy the sufficient condition.
   - This is the paper's only design guideline on the size of the movable region.
3. **Secrecy water-filling structure and per-LU fairness (medium).**
   - **Claim (IV-A):** the optimal allocation switches off any LU with η_e,m ≥ η_m. With Eve close to LU 1, fixed arrays are likely to switch LU 1 off or leave it a low secrecy rate, while the MAs keep it served.
   - **Gap:** Section V reports only sum rates. **Not covered by C1–C4.**
   - **Suggestion:** one sentence, or a small bar chart of the per-LU secrecy rates (LU 1 vs LUs 2–3) and the fraction of drops in which LU 1 is switched off, for each scheme.
   - Fairness is a common reviewer question for sum-rate designs.
4. **Two-timescale cost–benefit (medium–low).**
   - **Gap:** there is no comparison with a design that moves the antennas in every channel interval using instantaneous CSI of the LUs. Reviewers of two-timescale designs often ask how much performance the statistical-CSI design gives up, and how much movement overhead it saves.
   - **Not covered by C1–C4.** See item 5 (optional upper bound).
5. **Run time (low).**
   - **Gap:** IV-C gives the complexity order, and V-B gives the iteration ratio against the surrogate of [Zheng] (2.6 times as many iterations). The measured run-time ratio is also stored (17.4 times slower than Stage 2, `extra_mm_compare.mat`), but the text does not quote it.
   - **Suggestion:** one sentence with this ratio, or a run-time comparison against a heuristic optimizer (item 5).

**Already echoed:**

| Insight | Where it is shown |
|---|---|
| κ_e → 0 leaves only LU decorrelation | Fig. 8: gain over the rate-oriented MA is 1.0% at −10 dB |
| High-SNR slope M and α⋆ | Figs. 5 and 6 |
| Single LU | C1 |
| Robustness to errors in Eve's AoDs | C2 |
| Eve's distance from the BS | C3 |
| Positions and AN gains add up | C4 |
| Accuracy of the approximations and preserved rankings | Fig. 3 |
| Convergence and the value of Stage 1 | Fig. 4 |

## C. Item 5: benchmark suite

**Diagnosis of the current benchmarks**

- **Rate-oriented MA [Zheng] + Algorithm 1: keep.** It is the closest prior work, on the same hardware but unaware of Eve, so it isolates the value of the Eve-aware design. It also behaves differently from the other benchmarks: it equals the FPA at M = 1 and falls as κ_e grows.
- **AS over a compact candidate array (N of 2N ports at λ/2 spacing):** weak and uninformative here.
  - Its aperture is fixed, so it is flat in A (Fig. 7(a)) and always lies between the FPA and the rate-oriented MA.
  - The AS benchmark reviewers in the MA / fluid-antenna literature expect selects ports spread over the same movable region (a "discrete MA" with a switching network). It is stronger and grows with A. It also quantifies continuous positioning against a switched array that needs many more elements.
  - An older supplementary run with Oct. 2026 code (`extra_as_region.mat`, 16 candidates spanning the region) placed it between the rate-oriented MA and the proposed design, rising with A. It must be rerun with the current code before any number is used.
- **Sparse FPA:** its message is valid (aperture alone is not enough; grating lobes), but it is the fifth curve with the same ordering. It is most useful where aperture is the variable (Fig. 7).
- **FPA:** keep as the reference.
- **Equal power:** keep (Fig. 6), ideally together with the no-AN variant (C4).

**Recommended suite**

| Figure | Schemes | What each comparison isolates |
|---|---|---|
| Figs. 5, 7, 8 and C1 | Proposed, rate-oriented MA, **AS over the movable region** (λ/2 ports, swap search), FPA; sparse FPA in Fig. 7 only | Eve-awareness; continuous vs discrete positions; aperture (Fig. 7); baseline. Four curves per figure instead of five. |
| Fig. 6 | {Algorithm 1, equal power, no AN} × {MAs, FPA} | Power allocation and AN, with crossing curves |
| Fig. 4 or a table | Algorithm 2 vs **PSO** on the same objective (the most common heuristic for MA position optimization), ESSR and run time; the [Zheng] surrogate result stays in the text | Algorithm efficiency |
| Optional, one setting | Upper bound with positions re-optimized in every CI from the instantaneous CSI of the LUs | Loss of the two-timescale design vs movement overhead |

**Expected effect:** comparisons that cross or converge rather than one fixed ranking:

- region-wide AS approaching the proposed design for large A;
- no-AN curves crossing the FPA with AN;
- rate-oriented MA equal to the FPA at M = 1;
- an upper bound above the proposed design.

**Estimated cost**

| Change | Effort |
|---|---|
| Region-wide AS | One extra scheme in the Fig. 5, 7, 8 and C1 sweeps, about 2–3 h in four parallel sessions |
| PSO benchmark | New code plus runs, about half a day |
| Instantaneous-CSI bound | New code and heavy computation; better limited to N = 8, 20 dB, about 20 drops |

## D. Decisions needed

1. Which of C1–C4 to keep, and in what form (A).
2. Whether to add the item-4 echoes: the mechanism table (B1) and per-LU fairness (B3); the region-size threshold (B2) is optional.
3. Whether to change the benchmark suite (C).
