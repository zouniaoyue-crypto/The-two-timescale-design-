# Rev-8 analysis: figure guidelines and items 2.1–2.7

**Status: analysis only.**

- `main.tex`, the production code, and the stored results are unchanged.
- The figure proposals below are rendered on the stored rev-7 data by a separate prototype script, `review/experiments/rev8a_figstyle/proto_figs.m`.
- The previews are in the same folder: `p_fig4` … `p_fig8`, and `preview_all.png` for all of them.
- §3 gives the unified plan and the decisions to confirm.

---

## 1. Macro-level figure guidelines

### 1.1 Legends inside the plot area (Figs. 5, 7, 8)

Feasible for every panel, with small axis adjustments. In the previews, no legend covers a curve.

| Panel | Legend position and layout | Axis change needed |
|---|---|---|
| Fig. 4 | lower right, 3 rows | none |
| Fig. 5(a) | upper left, 1 column × 5 rows | the 20-dB inset moves from the upper left to the empty lower right |
| Fig. 5(b) | top, 2 columns × 3 rows (5 schemes + prediction marker) | y-axis 0–0.8 (was 0–0.6) |
| Fig. 6 | upper left, 2 × 2 (unchanged) | none |
| Fig. 7(a) | top, 2 columns × 3 rows | y-axis 14–26 (was 14–24) |
| Fig. 7(b) | lower right, 1 column × 5 rows | none |
| Fig. 8 (one panel, §2.3) | lower left, 2 columns × 3 rows | y-axis 12–22 |

Effects on `main.tex` and the code:

- The shared legend strip (`legend_main_schemes`) above Figs. 5, 7, and 8 is removed. This also saves about 0.25 in of height per figure.
- Every subfigure becomes self-contained.

### 1.2 Palette and marker redesign

I tested the current colors and four alternatives with the data-visualization validator: CVD separation under protanopia and deuteranopia, a normal-vision floor, and contrast on white. **All pairs** were checked, because curves can cross anywhere. The alternatives were Paul Tol "vibrant", a tab10-like set, and two custom sets.

| Candidate (proposed, rate-oriented MA, AS, sparse FPA) | Result |
|---|---|
| **current** brick red B03A2E, steel blue 2E6DB4, teal 2A9D8F, ochre C7852B | **passes everything**: worst CVD ΔE 12.0, worst normal-vision ΔE 16.8, all ≥ 3:1 on white |
| Tol vibrant CC3311, 0077BB, 009988, EE7733 | fails the normal-vision floor (blue–teal 14.6); orange below 3:1 on white |
| tab10-like C8102E, 1F77B4, 2CA02C, 9467BD | fails CVD: purple–blue ΔE 1.7 for protanopes |
| two custom muted sets | fail the chroma floor and the CVD or normal-vision floors |
| three hues + two grays for the fixed arrays | fails: the mid-gray collapses with teal for deuteranopes (ΔE 1.4) |

**Conclusion.** The four scheme hues are already a validated set, and a different set would look different without being better. One defect was found: the FPA's mid-gray 6E6E6E sits only ΔE 12.9 from the steel blue under normal vision (floor 15). Charcoal 3D3D3D fixes this: worst pair 16.8, CVD ≥ 9.8, contrast 10.9:1.

**What the redesign should change is the visual grammar.** The real problems are semantic.

- Fig. 4 uses red and blue for SNR, which mean *schemes* in Figs. 5–8.
- Purple is used for the Monte Carlo curve.
- Colored auxiliary lines appear in Fig. 5(b).

Proposed rule set, written once in `fig_palette.m` and `scheme_style.m` and applied to Figs. 4–8:

| Channel | Meaning |
|---|---|
| Color | scheme identity only: proposed brick red (the only warm accent); rate-oriented MA steel blue; AS teal; sparse FPA ochre; FPA charcoal |
| Line style | array type: solid = MAs; dash-dot = AS; dashed = fixed arrays; dotted = equal power (Fig. 6) |
| Marker | scheme: ○ proposed, □ rate-oriented MA, △ AS, ▽ sparse FPA, ◇ FPA. Hollow by default; **filled = equal power** |
| Weight | proposed 1.4 pt; benchmarks 1.0 pt (hierarchy without a second accent color) |
| Black | reserved for analytical or auxiliary marks (× = high-SNR prediction, §2.6) and text |
| Fig. 4 | all Algorithm 2 curves in the proposed red (it is the proposed algorithm), N by line style, SNR groups by direct text labels, "MM only" in charcoal dotted, no markers |

Purple and dark gray leave the main figures; they stay only in the supplementary scripts. The previews show the result on the real data.

---

## 2. Items for verification and analysis

### 2.1 Residual mentions of Δ = 0.1 rad

**Where it appears:**

- V-A, the scenario definition, with the symbol Δ and the note that "Δ is an offset in the elevation–azimuth coordinates";
- the captions of Figs. 3, 5, 6, 7, and 8;
- no figure image contains it.

**Recommendation:**

- Define the scenario once in V-A without the symbol: "θ_e = θ₁ + 0.1 cos φ̃ and φ_e = φ₁ + 0.1 sin φ̃ (rad), i.e., Eve's AoDs deviate from those of LU 1 by 0.1 rad in a random direction of the (θ, φ) plane; then ρ₁ ≥ 0.94 for the FPA". Δ is no longer a variable, so the symbol and its note can go.
- Remove "Δ = 0.1 rad" from all five captions.

**Related cleanups:**

- Adopt one caption rule: a caption states only the swept parameter and the parameters that differ from the V-A defaults. For example, Fig. 7: "(a) … with N = 8 and (b) … with A = 4λ"; N = 8, M = 3, A = 4λ, and 20 dB are no longer repeated everywhere.
- Delete the unused macro `\Derr` from `notation.tex`. It is a leftover of the removed AoD-error study.
- The code keeps `prm.Delta`, which defines the scenario.

### 2.2 Fig. 4

**Recommendation (preview `p_fig4_convergence.png`):**

- remove the Monte Carlo curve, and the V-B 2) sentences and caption clause that describe it;
- return the y-label to "Objective value of (P3)";
- use the grammar of §1.2: four Algorithm 2 curves in one color, with N by line style;
- show the two SNR groups by direct labels ("P_tot/σ² = 20 dB", "10 dB"), not by color;
- reduce the legend to three entries: Algorithm 2 for N = 8, Algorithm 2 for N = 12, MM only.

**Effects:**

- The figure answers one question, convergence, and the eye finds the SNR groups by position.
- No rerun is needed: the stored data are unchanged.
- This reverses D4, so I144 is reopened.

### 2.3 Is Fig. 8(a) redundant?

**What each panel shows:**

- **(a) common κ = κ_m = κ_e.** All schemes coincide in Rayleigh fading (spread < 0.04 bps/Hz at κ = −10 dB), because positions act only through LoS components. Gains grow with κ, to 19.3% over the rate-oriented MA and 49.4% over the FPA at 20 dB. This is the generic "positioning needs LoS" message, which Zheng et al. also show for rates.
- **(b) κ_e with κ_m = 10 dB.** This isolates the **Eve-aware** part of the gain. Over the rate-oriented MA it grows from 1.0% at κ_e = −10 dB to 17.0% at κ_e = 20 dB, while the gain from LU decorrelation persists. This dimension is specific to secure transmission and unique to this paper.

The curve shapes are indeed similar: the proposed design rises and the benchmarks fall in both panels. The distinct message of (a) fits in one sentence with two numbers.

**Recommendation:**

- Keep **(b) only**, as a one-column Fig. 8 (preview `p_fig8_essr_kappae.png`).
- State (a) in the text: "With a common Rician factor, the ESSRs of all the schemes differ by less than 0.04 bps/Hz at κ = −10 dB, whereas the gains grow to 19.3% and 49.4% at κ = 20 dB." The numbers come from `fig8_rician_a.mat`, so they stay traceable.
- This saves about one third of a page.
- *Alternative:* keep (a) only. It meets the reviewer's generic expectation, but it loses the paper-specific insight, so I do not recommend it.

### 2.4 Eve-aware AN (Remark 1)

**Analysis:**

- **Reviewers would ask for results.** Remark 1 makes a quantitative claim: ψ_dir − ψ = (N − M − 1)κ_e d ≥ 0, so directional AN "yields a higher approximate ESSR". It then rejects that design for qualitative reasons (sensitivity to AoD errors, no protection against unknown eavesdroppers, attribution to the MAs). A careful reviewer will ask to quantify both the gain and the robustness, and the paper has no such results.
- **It does not fit the benchmark comparisons.** Directional AN changes the AN, not the positions, so it is not a positioning benchmark. With accurate statistical CSI of Eve it would lie **above** the proposed curve, which reads as "a benchmark beats the proposed design". Justifying isotropic AN would then need a new robustness figure (ESSR vs. AoD error of Eve, and an unknown second eavesdropper). That costs new code, new runs, and a figure, and it shifts the focus from MAs to AN design.

**Recommendation:**

- Replace Remark 1 by one sentence in III-A, where the isotropic AN is introduced, keeping the three reasons without the quantitative comparison. For example: "Although the statistical CSI of Eve could also steer the AN toward its LoS component, the isotropic AN requires no CSI of Eve in each CI, also impairs eavesdroppers unknown to the BS, and ensures that the secrecy gain obtained from the statistical CSI of Eve can be attributed to the MAs."
- Add "joint design of the AN covariance" to the future work in the conclusion.
- Remark 1 is referenced nowhere else, so the change is self-contained and saves about 12 lines.
- The ψ_dir derivation stays available for a response letter.

### 2.5 Value of III-D 3) "High-SNR behavior and AN power"

**Core conclusions and the figures they correspond to:**

| Conclusion | Shown in |
|---|---|
| (i) The high-SNR slope of the approximate ESSR is M for any t, so positions only shift the constant term | Fig. 5(a): the absolute gain over the FPA levels off at 4.93, 5.09, 5.14 bps/Hz at 20, 25, 30 dB |
| (ii) The optimal information–AN split α⋆ depends on positions only through Ξ_m(t), the leakage-to-AN ratio, via (33). The MAs decrease Ξ_m and thus need less AN | Fig. 5(b): AN fraction 0.27 vs. 0.47 (FPA) at 20 dB. The predictions 1 − α⋆ match all five schemes within 0.01 at 30 dB (0.286/0.276, 0.450/0.442, 0.449/0.441, 0.416/0.408, 0.490/0.486). Fig. 6: equal power costs the MAs 1.79–1.94 bps/Hz but the FPA only 0.64–0.72 at 20–30 dB |

**Reviewer's view:**

- (i) is a standard degrees-of-freedom argument. It has little novelty but is useful because it explains a feature of Fig. 5(a).
- (ii) is MA-specific and quantitatively validated, so it has moderate value.

**It becomes a genuinely valuable insight with one sentence that is currently missing.** For M = 1 and Rayleigh fading of Eve (κ_e = 0), Ξ = 1 and (33) gives α⋆ = 1/2. This is the equal information–AN split that Zhou and McKay [Zhou2010, already cited] found near-optimal for non-colluding eavesdroppers ([arXiv 1006.5938](https://arxiv.org/abs/1006.5938)). The MAs move α⋆ away from 1/2: 0.71 with the optimized positions vs. 0.51 for the FPA at 30 dB. The classic rule of thumb therefore does not carry over to MA systems, which also explains why Fig. 6 penalizes equal power far more for the MAs.

**Recommendation:**

- Keep III-D 3), shortened: one sentence for (i), (33) for (ii).
- Add the Zhou–McKay sentence.
- Make the V-C discussion of Fig. 5(b) and Fig. 6 refer back to it explicitly.
- The likely objection is that the analysis uses equal user power while Algorithm 1 uses water-filling. It is answered by the agreement within 0.01, which the text should state.

### 2.6 Auxiliary lines in Fig. 5(b)

**Recommendation (preview `p_fig5b_an_fraction.png`):**

- Replace the two colored dotted lines by black × markers at 30 dB for **all five** schemes, with one legend entry "High-SNR prediction, (33)".
- This is the standard way to overlay an analytical result: explained by the legend, in a color reserved for analysis.
- It validates (33) for every design, not just two.
- The V-C text then echoes §2.5: "the AN power fractions saturate at the levels predicted by (33) (× in Fig. 5(b))".
- *Minimal alternative:* no marks, with the numbers stated in the text only.

### 2.7 Stage-2 variant: S0 vs. S1-best vs. S1-Zheng

All three keep the Stage-1 grid search and differ only in the **Stage-2** local refinement, so this is a Stage-2 choice.

**What S1-best is.** At each antenna and each AO iteration, S1-best uses MM with a **fixed** curvature. That curvature is the largest spectral norm of the Hessian of F with respect to t_n, found **numerically**: central finite differences (step 0.005λ) at all 1681 points of the λ/10 grid, i.e., 15,129 evaluations of F. I built it in rev-7b as an oracle: the best case that *any* fixed, globally valid curvature could achieve. It was never meant as a candidate algorithm.

| | S0 (current) | S1-best | S1-Zheng |
|---|---|---|---|
| Curvature | local, found by backtracking (median 8) | global maximum, computed numerically (median 11.6) | closed form for the LU terms (Zheng et al., Lemma 1); the Eve terms need a numerical or new bound; effective median ≈ 137–190 |
| Objective (10 drops) | reference | +0.028 ± 0.036 (not significant) | +0.017 ± 0.040; 100 drops: −0.05% ± 0.06% |
| MM iterations | 263 | 351 (1.3×) | 682 (2.6×) |
| Time per drop (Octave) | 0.82 s | 0.84 s + 1.5 s oracle ≈ 2.3 s | 13.5 s (17× with 100 drops) |
| Guarantee | minorization checked at every step; finite termination (IV-B) | **not guaranteed**: a maximum sampled on a grid is not a Lipschitz bound, since the curvature between grid points can be larger | valid for the LU part; Eve part only with a new, looser bound |
| Analytical content | analytical gradient (App. C) and termination bound | **none**: the curvature is a number from a search | the closed form belongs to Zheng et al. |

**Assessment of your two premises:**

- **S1-Zheng: agree.** Its LU bound is Zheng et al.'s derivation, it brings no performance gain, and it is 2.6× slower in iterations and 17× in time. Exclude it as a method. The one-paragraph comparison in V-B can stay as the reason why we do not use it.
- **S1-best: the premise does not hold.** It yields no analytical insight, because its curvature is numerical. Any *analytical* fixed curvature would be at least as large, hence slower. The only ones available are the Zheng-type bound (≈ 12× S0's accepted value) and the norm-chain bound (≈ 10⁶).
- S1-best is also slower than S0, costs an extra oracle step about 9× larger than the grid search, and loses the monotonicity guarantee.

**Recommendation: keep S0.**

---

## 3. Unified plan (after your confirmation)

**Code (plot functions only; no new simulation runs needed):**

1. New grammar and palette (§1.2) in `fig_palette.m` and `scheme_style.m`.
2. In-panel legends and axis adjustments (§1.1); remove the legend strip.
3. Fig. 4 without the Monte Carlo curve (§2.2).
4. Fig. 5(b) × markers (§2.6).
5. Fig. 8 as one panel (§2.3).
6. Update `replot_all`, `verify_numbers` (drop the Monte Carlo lines; add the 30-dB predictions for all five schemes), and the readme.

**Text:**

1. V-A scenario without Δ, and the caption rule (§2.1).
2. Remark 1 → one sentence in III-A, plus future work (§2.4).
3. III-D 3): shortened, plus the Zhou–McKay link (§2.5).
4. V-B 2): remove the Monte Carlo sentences.
5. V-C: echo the high-SNR insight in Figs. 5(b) and 6.
6. V-D 2): Fig. 8 → κ_e only, with the common-κ sentence.
7. Remove `\Derr`.

**Checks:** build (expected back to 14 pages), `verify_numbers`, records, commit.

**Decisions to confirm:**

| # | Decision | Recommendation |
|---|---|---|
| 1.1 | In-panel legends with the axis changes of §1.1 | yes |
| 1.2 | Keep the four validated hues, FPA → charcoal, new grammar (Fig. 4 single-hue, black = analytical) | yes |
| 2.1 | Remove the symbol Δ and the caption repeats; one caption rule | yes |
| 2.2 | Fig. 4 redesign without the Monte Carlo curve | yes |
| 2.3 | Fig. 8: keep (b) only + one sentence for (a) | yes (alternative: (a) only) |
| 2.4 | Remark 1 → one sentence + future work | yes |
| 2.5 | Keep III-D 3), shortened, with the Zhou–McKay link | yes |
| 2.6 | × markers with a legend entry (or text only) | × markers |
| 2.7 | Stage 2: S0 | S0 |
