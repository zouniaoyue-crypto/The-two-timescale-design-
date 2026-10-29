# Validation of the merged manuscript

Environment: Claude Code on the web, TeX Live (pdflatex, xelatex), GNU Octave 8.4 (MATLAB not
available). All checks below were executed on the final files of this branch unless marked
otherwise. Issue IDs refer to `review/ISSUES.md`.

## 1. Build

| Check | Command | Result |
|---|---|---|
| Manuscript | `cd manuscript && pdflatex -interaction=nonstopmode main.tex` (2–3 runs) | 14 pages; 0 overfull boxes; 0 undefined references or citations; no multiply defined labels |
| Layout | `main.log`, page renderings | one `Underfull \vbox (badness 10000)` on p. 11 (about 5 pt extra paragraph gap below Figs. 5–6, I44, cosmetic). Equation numbers of (36) and (38c) sit on their own line (wide displays) |
| Visual check | pages rendered with `pdftoppm` | pp. 6, 7, 8, 11, 12, 13, 14 inspected after the last edit; other pages inspected during the merge |
| Code readme | `cd manuscript/ma_secrecy_matlab && xelatex readme.tex` (2 runs) | 14 pages; 0 overfull boxes |
| Displays | scan of all `equation`/`align` blocks | each display ends with `,` or `.`, or the sentence continues after it (I30) |

## 2. Data chain

| Check | Data | Result |
|---|---|---|
| v1 vs v2 result files | `results/*.mat` of 01_original and 02_revised, matched by scheme name | identical within Monte Carlo noise; the v1 files are kept |
| Merged code vs stored results | `extra_grid_check` (default spacing) vs `fig5_snr.mat`, proposed design, 20 dB, drops 1–20 | per-drop ESSR identical (max abs. difference 0) |
| Figures | `plot_fig3`, `plot_fig7` on the stored results | Figs. 3 and 7 replotted (legend "closed form"; axes "AoD offset Δ", "Fading spread S"); Figs. 4–6 unchanged |

## 3. Executed code checks (Octave)

`check_implementation` (N = 6, M = 3):

| Item | Result |
|---|---|
| analytical gradient (App. C) vs central differences | max rel. error 1.26e-7 (subset of LUs 1.21e-7) |
| rank-one evaluation (`objective_F_n`) vs `objective_F` | max error 1.24e-14 |
| secrecy water-filling (Prop. 2) | power used 70/70; spread of ∂f/∂p over active LUs 7.6e-16; inactive LUs satisfy ∂f/∂p(0) ≤ ν |
| Algorithm 2 | objective nondecreasing in modes `full`, `epa`, `fix` |
| closed form vs Monte Carlo (this small case) | LU 5.87/5.17, 5.90/5.25, 4.59/4.06; Eve 1.45/1.47, 0.343/0.421, 0.381/0.575 bps/Hz |

`verify_numbers` (every number quoted in Section V, recomputed from `results/*.mat`):

| Sec. | Quantity | Recomputed | Text |
|---|---|---|---|
| V-A | FPA LoS correlation \|h̄₁ᴴḡ\|/N at Δ = 0.1, min over 100 drops | 0.9439 | exceeds 0.94 |
| V-A | ESSR change for grid spacing λ/20 (20 drops) | +0.0107% | 0.01% |
| V-A | standard error of the proposed ESSR at 20 dB | 0.545% | 0.55% |
| V-B | max \|Eve rate error\| vs SNR / vs Rician factor | 0.0524 / 0.0128 | 0.052 / 0.013 |
| V-B | approximate vs actual ESSR at 20 dB | 18.985 / 20.749 | 18.98 / 20.75 |
| V-B | actual − approximate ESSR at 20 dB over the schemes with AN | 1.5245–1.7650 | 1.52–1.76 (corrected, I39) |
| V-C | monotone trajectories; iterations to 99% of the average increase | yes; 15 (10–15 over the four settings) | within 15 |
| V-D | gain over rate-oriented MA / FPA at 20 dB | 14.79% / 31.18% | 14.8% / 31.2% |
| V-D | AN power fraction, proposed / FPA, 20 dB | 0.270 / 0.471 | 0.27 / 0.47 |
| V-E | proposed (N = 4) − FPA (N = 12) | +0.52 (paired SE 0.15) | outperforms |
| V-E | proposed (N = 8) − rate-oriented (N = 16) | +0.23 (paired SE 0.08) | outperforms |
| V-E | sparse FPA − rate-oriented, N = 10/12/14/16 | −0.06 (SE 0.21) / +0.11 (SE 0.20) / +0.32 (SE 0.19) / +0.44 | for N ≥ 14 |
| V-G | gain of the proposed PA over EP (optimized α), 0/10/20 dB, S = 20 dB | 40.3% / 13.9% / 0.78% | 40% / 14% / below 1% |
| V-H | TIN Eve: max increase of the schemes with AN (10/20/30 dB) | 1.534 | at most 1.53 |
| V-H | TIN Eve at 20 dB: proposed / rate-oriented | 0.494 / 1.471 | 0.5 / 1.5 |
| V-H | w/o AN at 30 dB: TIN / worst-case Eve | 27.14 / 13.85 | 27.1 / about 14 |
| V-H | AoD error: max decrease of the benchmarks; proposed at 0.05 rad | 1.82%; 2.97% | less than 2%; 3% |
| V-H | AoD error 0.1 rad: proposed / best benchmark | 18.726 / 17.931 | 18.73 / 17.93 |
| V-H | independent AoDs, M = 3: gain over rate-oriented / sparse FPA | 10.3% / 17.9% | 10% / 18% |
| V-H | independent AoDs, M = 1: AS relative to proposed | −2.1% | close |

Other executed checks: Fig. 4 data (`fig4_convergence.mat`, N = 8, 20 dB): grid search + MM ends
4.4% above MM only on average (95/100 drops); the average curves reach 95% of their increase after
2 vs 32 iterations; two random initializations end within 0.14% of the UPA initialization
(statements in the code readme). Remark 2: the rewritten (28) and the residual
(c₁ − 1)/((N−1)(κ₁+1)+1) agree with the previous expressions in 2×10⁵ random cases
(N ∈ [2, 64], κ₁ ∈ [10⁻³, 10³]); the largest residual found is 0.247 ≤ 1/4.

## 4. Static derivation checks

- Jensen step (eq:lujensen): log₂(1 + a/x) is convex in x > 0, so the bound direction is correct; the central-Wishart step is an approximation and is stated as such.
- Eve rate: unconditional variances include the κ_e²Var{X̄_m}, κ_e²Var{Ȳ} terms (law of total variance); the rate is concave in X and convex in Y, so the moment replacement is neither an upper nor a lower bound.
- App. B: Woodbury gives I_N − Π = (I_N + LLᴴ/N)⁻¹, hence the range [0, N] of d; exactness for κ_m = 0; asymptotic exactness as K = κK₀, κ → ∞, needs linearly independent LoS vectors.
- Remark 2: w̄₁w̄₁ᴴ + P⊥(t) = I_N for M = 1 gives X̄₁ + Ȳ = N; |c₁ + d − N| ≤ κ₁/(κ₁+1)² ≤ 1/4.
- (49)–(51): the linearized minimum-distance constraint equals (t_n⁽ᵏ⁾ − t_i)ᵀ(2t_n − t_n⁽ᵏ⁾ − t_i) ≥ D²_min, a lower bound of ‖t_n − t_i‖² tight at t_n⁽ᵏ⁾.
- (48): ∂F/∂u_n with η̇_e,m = κ_eη_e,m(ċ_m/ξ_m − qḋ/(qψ + σ̄²_e)) matches `grad_F_n.m` (gradient check above).
- Grid spacing: ‖a_j − a_i‖ ≤ 2 gives a shortest phase period of λ/2, so λ/10 is at most one fifth of it.
- (P3): F ≤ approximate ESSR at any feasible point because x ≤ [x]⁺; convergence is stated for the objective value only.

## 5. References

| Check | Result |
|---|---|
| ChenArxiv2026 | DOI 10.1109/TWC.2026.3688454 resolved to IEEE Trans. Wireless Commun. (2026), title and authors agree; vol./pages from v2 not verifiable, so not cited |
| XieArxiv2026 | arXiv:2601.14755 resolved; title and authors agree |
| [16, Remark 2], [16, Sec. IV-A]; content of [15] | checked against the text of the reference PDFs during the merge |
| [19, Lemma 1], [26, Lemma 5.7] | not checked against the sources |
| Other 22 entries | bibliographic data carried over from v1; automatic re-verification failed (lookup service timed out; OpenAlex search rate-limited, HTTP 429) — unverified |
| Novelty search 2025–2026 (S-A2) | not completed (I35) |

## 6. Unresolved items (for the author)

- I33: small table for the robustness numbers of V-H (kept as text, as decided in Round 12).
- I34: additional simulations E1–E6 from the seed list (not run).
- I36: vector (PDF) figures; PNG figures are used. MATLAB export: `exportgraphics(gcf, 'file.pdf', 'ContentType', 'vector')`.
- I35: novelty search and full reference verification.
- Author names, affiliations, e-mail addresses (placeholders in `main.tex`, lines 43–45) and a funding acknowledgment, if any.
