# Rev-9a: Modeling–derivation review (IEEE modeling and derivation guidelines)

Scope: `manuscript/main.tex` as of commit `b1005b9` (rev-8g), read along the thread problem modeling → transformation → analysis → algorithm. Sections I–IV, the appendices, and the parts of Section V that close the loop on the analysis (V-B 1), V-C) were reviewed.

**No manuscript changes were made.** Line numbers refer to the current `main.tex`. Every recommendation is labelled:

- **wording**: same meaning, presentation only.
- **decision**: adds, removes or sharpens a technical statement, so it needs your approval (CLAUDE.md rule 2).

---

## 1. Overall assessment

The modeling–solution chain is coherent and technically sound. The paper already follows most of the guidelines:

- the difficulty of (P1) is named right after it is formulated (l. 276), and that of (P3) at the start of Section IV (l. 415);
- every transformation is labelled as a restriction, a bound or an approximation;
- the algorithm rests on revealed structure: secrecy water-filling, the rank-one update, and the single-LU optimum;
- all subproblems are mainstream: KKT/water-filling, and MM with an exact projection.

**Derivations re-checked (no errors found):**

- the conditional moments in App. A;
- the root (37) of the KKT quadratic;
- the interior stationarity condition (38) for q;
- the high-SNR expansion (32), the closed form α⋆ = 1/(1+√Ξ), and strict concavity in α (verified for all Ξ_m ≥ 0);
- c_m(t), d(t) and the calibration factor χ in App. B, and both limits of Proposition 1;
- the bounds (21) on η_m;
- the N+3 lines enumerated in the projection;
- the monotonicity chain (51).

**Where the paper falls short of the guidelines:**

1. One approximation step does not say **how large its loss is**: the LU rate (20) only "underestimates in the LoS-dominant regime". Its loss has a closed-form limit that is independent of t, and the stored data confirm it (R1). This also explains, analytically, why the approximation preserves the ranking of the designs, which the paper now argues only empirically (R2).
2. Four passages exist mainly **to defend** (R3–R6).
3. A few **precision and flow** issues in the model and notation (R7–R13).

### Chain map

| Step | Where | Nature | Stated? |
|---|---|---|---|
| Observation: Eve close in direction to an LU under LoS, so an FPA cannot separate them; MAs reshape the LoS correlations | I, ¶1 | motivation | ✓ |
| Positions affect the statistics only via LoS (i.i.d. NLoS) | II-A, l. 190 | modeling assumption | ✓ (once, where used) |
| (P1): stochastic, two timescales | II-D | formulation, then difficulty and strategy | ✓ (short-term variables implicit, R7) |
| (P1) → (P2): ZF + null-space AN, long-term (p, q) | III-A | restriction (lower bound) | ✓ why and what |
| LU rate: Jensen (18), then Wishart (20) | III-B | bound, then approximation | exact for Rayleigh ✓; **size of the loss missing (R1)** |
| Eve rate: conditional moments (EX)/(EY) | III-C, App. A | exact | ✓ |
| Moment replacement (24) | III-C | approximation | ✓ (accurate when X, Y concentrate) |
| c_m, d with calibration | III-C, App. B | approximation | exactness limits in Prop. 1 ✓; **why calibrate: appendix only (R8)** |
| Insights: mechanisms, single LU, high SNR / α⋆ | III-D | structure, scaling | ✓ (verified in V) |
| (P2) → (P3) | III-E | approximation, [·]⁺ dropped exactly | **no summary of what the surrogate costs (R2)** |
| Difficulty of (P3) and two favourable properties | IV, l. 415 | structure first | ✓ (exemplary) |
| (P3.1): secrecy water-filling and 1-D search over q | IV-A | exact for given q; grid search over q | ✓ |
| (P3.2.n): grid search, then MM with projection | IV-B | global exploration, then convex inner approximation | ✓ |
| Monotone objective, bounded, converges; complexity | IV-C | guarantee | ✓ (one defensive caveat, R4) |

### Checklist (from the skill)

| Item | Verdict |
|---|---|
| Motivation in two sentences without a stack of technologies | ✓ Intro ¶1 gives the physical observation (spatial separability lost under LoS when Eve is close to an LU). No change proposed. |
| Difficulty named right after the formulation | ✓ for (P1) and (P3). |
| Each step says why, what, and exact or approximate | Mostly ✓. Missing: the loss of (20) (R1), the surrogate cost at (P3) (R2), and the reason for the calibration (R8). |
| Anything there only to defend | R3–R6. |
| Structure, closed forms, equivalences rather than routine algebra | ✓ Strong. R1 adds a scaling law. Routine derivative algebra could move to App. C (R14). |
| Mainstream algorithm with convex subproblems | ✓ AO/BCD; water-filling (KKT); MM with an exact projection; Stage-1 grid search for global exploration. |

---

## 2. Recommendations

### Priority 1: depth of the derivation chain (decision)

**R1. Give the closed-form, position-independent loss of the LU-rate approximation (III-B, l. 332; V-B 1), l. 596).** *Decision*

- **Now:** III-B says (20) "underestimates the ergodic rate in the LoS-dominant regime, as shown in Section V-B". V-B 1) explains the cause in prose: the Wishart step overestimates E{[(HᴴH)⁻¹]_{m,m}} by a factor approaching N/(N−M). The analysis therefore lives in the simulation section, and its consequence is not drawn.
- **Derivation:** assume the LoS components of the LUs are linearly independent and let κ₁ → ∞ with fixed ratios κ_m/κ₁, as in Proposition 1.
  - H(t) converges to its LoS component, a deterministic matrix, so the Jensen gap in (18) vanishes.
  - Meanwhile η_m(t) → ((N−M)/N) · β_m / (σ_m² [(H̄ᴴH̄)⁻¹]_{m,m}), i.e., (N−M)/N times the exact effective gain.
  - Hence R_m − R̂_m → log₂(N/(N−M)) in the high-SNR regime, **for every such t**.
- **Verified** (`fig3_accuracy.mat`, Fig. 3(b), 20 dB; N = 8, M = 3; limit M·log₂(N/(N−M)) = 2.03 bps/Hz):

  | κ (dB) | −5 | 0 | 5 | 10 | 15 | 20 |
  |---|---|---|---|---|---|---|
  | MC − (20), sum over LUs (bps/Hz) | 0.50 | 0.83 | 1.38 | 1.77 | 1.93 | 1.99 |

- **Why it matters:** the step's loss becomes a scaling law, as the guidelines ask ("how large the loss is"). It also gives an analytical reason why (20) does not distort the position design: the gap tends to a constant that does not depend on t.
- **Draft for III-B** (replaces "and underestimates the ergodic rate in the LoS-dominant regime, as shown in Section~\ref{sec:sim_acc}."):

  > In the LoS-dominant regime, \eqref{eq:Rm} underestimates the ergodic rate by a gap that does not depend on $\bt$. Specifically, if the LoS components of the LUs are linearly independent, $\bH(\bt)$ converges to its LoS component as $\kappa_1\to\infty$ with fixed ratios $\kappa_m/\kappa_1$, so that the gap in~\eqref{eq:lujensen} vanishes, whereas the Wishart approximation overestimates $[(\bH^{\mathrm H}(\bt)\bH(\bt))^{-1}]_{m,m}$ by the factor $N/(N-M)$. Hence, $R_m-\hat R_m(\bt,p_m)$ approaches $\log_2(N/(N-M))$ in the high-SNR regime.

- **V-B 1)** then replaces its explanatory sentence with a check of the prediction: "…and the gap grows with the Rician factor toward $M\log_2(N/(N-M))=2.03$~bps/Hz predicted in Section~\ref{sec:lu}, e.g., $1.99$~bps/Hz for $\kappa=20$~dB."
- **Records:** add two lines to `verify_numbers` (the gap at the largest κ and the limit).
- **Cost:** about +3 lines in III-B and −1 line in V-B 1).

**R2. State once, at (P3), what the surrogate costs, and use Proposition 1 there (III-E, after l. 410).** *Decision*

- **Now:** after (P3) the text explains only why [·]⁺ can be dropped. Proposition 1 is never used after it is stated; it is referenced only in its own appendix. The reader must collect the accuracy of (20) and (27) from III-B, III-C and V-B.
- **Draft (two sentences, after the [·]⁺ sentence):**

  > Problem (P3) differs from (P2) only by the approximations~\eqref{eq:Rm} and~\eqref{eq:Re}. In the LoS-dominant regime, the gap of~\eqref{eq:Rm} approaches a constant that does not depend on $\bt$, and $c_m(\bt)$ and $d(\bt)$ in~\eqref{eq:Re} become exact by Proposition~\ref{prop:eve}, so that (P3) is a suitable surrogate of (P2) for the antenna position design, as confirmed in Section~\ref{sec:sim_acc}.

- **Effect:** closes the exact-or-approximate bookkeeping at the point where the deterministic problem appears, and gives Proposition 1 a role in the main argument. This sentence depends on R1.

### Priority 2: remove defensive content (guideline §1)

**R3. Delete the backtracking-bound sentence (IV-B, l. 503, the `\rev` sentence "Let $L$ denote a Lipschitz constant … $\delta_n\le\max\{\delta_0,2L\}$").** *Wording*

- The preceding clause already states that the test "holds once δ_n reaches the Lipschitz constant". Finite termination is therefore immediate, and the cited [Beck2017] covers the rest.
- The bound re-proves a standard result.
- Deleting it also removes the clash between the italic L (Lipschitz constant) and the bold **L**(t).
- Saves about 3 lines.

**R4. Delete the stationarity caveat in the convergence paragraph (IV-C, l. 544: "Note that this guarantee concerns the objective value only and does not imply convergence to a stationary point of (P3).").** *Your call*

- The preceding sentence already says precisely "the objective value is guaranteed to converge".
- The caveat only pre-empts a reviewer objection.
- If you prefer to keep the limitation visible, fold it into one clause: "…the objective value, rather than the iterates, is guaranteed to converge."

**R5. Delete the footnote on multiple non-colluding Eves (IV-A, l. 436).** *Decision*

- It is a generalization placed in the power-allocation paragraph.
- Its last clause ("η_{e,m}(q) is replaced by its maximum over the Eves") makes F nonsmooth, which Stage 2 (gradient, descent lemma) does not handle. The footnote therefore over-reaches.
- The conclusion already lists multiple multi-antenna eavesdroppers as future work.
- If you want to keep a pointer, move it to III-C after (27) and keep only "\eqref{eq:cm}–\eqref{eq:Re} apply to each of multiple non-colluding single-antenna Eves."

**R6. Trim the isotropic-AN rationale (III-A, l. 292).** *Wording*

- Keep the two operational reasons; drop the experimental-attribution clause, which defends the evaluation rather than the model. The new benchmark in V-A answers that question directly.
- **Draft:**

  > \rev{Although the AN could also be steered toward the LoS component of Eve (see Section~\ref{sec:sim_setup}), the isotropic AN does not depend on the CSI of Eve and also impairs eavesdroppers unknown to the BS.}

### Priority 3: precision and flow (wording)

**R7. Make the two timescales visible in (P1) and punctuate it (II-D, l. 266–276).**

- (P1) lists {w_m} and **Σ** as if they were single variables. They are adapted to every realization of **H**(t), and the power constraint holds in every coherence interval (CI). The prose above (P1) says this, but the formulation does not.
- **Draft** (one sentence after (P1); also end (P1) with a period, since (P1) is the only displayed problem without final punctuation):

  > where $\{\bw_m\}$ and $\bSig$ are functions of $\bH(\bt)$, i.e., they are optimized for each realization of $\bH(\bt)$, and~\eqref{eq:P1pow} holds in every CI.

- If R17 is adopted, R7 becomes moot.

**R8. Say in the main text why d(t) is calibrated (III-C, l. 351).**

- The reason (to avoid counting the LoS-captured directions twice, which can make the estimate negative) appears only in App. B.
- **Draft insertion** after "by the identity $\tr(\PHp)=N-M$": ", which prevents the NLoS components from capturing the directions already captured by the LoS components,".

**R9. Define ρ_m(t) where the LoS correlations are introduced (III-D 1), after (29)).**

- ρ₁(t) is defined inside "2) Single LU", yet Section V uses it for M = 3. This suggests a single-LU quantity.
- **Draft** (in III-D 1); III-D 2) then simply uses ρ₁(t)):

  > Let $\rho_m(\bt)\triangleq|\hb_m^{\mathrm H}(\bt)\gb(\bt)|/N\in[0,1]$ denote the normalized LoS correlation between Eve and the $m$-th LU.

**R10. Reorder the AN-power paragraph (IV-A, l. 438–442): the method first, then the structure.**

- **Current order:** F⋆(q) → stationarity (38) and its interpretation → link to α⋆ → "As F⋆(q) is not necessarily unimodal, … grid search". The algorithmic decision comes last, after a derivation the algorithm does not use.
- **Proposed order:** (i) F⋆(q) and the interval; (ii) not necessarily unimodal, so a coarse-then-fine grid search (Algorithm 1); (iii) at an interior optimum, (38) shows that q⋆ balances the two uses of the power, with the high-SNR link to α⋆.
- Text unchanged except for connectors.

**R11. Replace the verbal concavity argument with the formula (IV-A, l. 430).**

- "…strictly concave because its second-order derivative is the difference between the squares of the right-hand and left-hand sides of this inequality divided by ln2" reads as a puzzle.
- **Draft:** "…and strictly concave, since $\ln2\,\partial^2F_m/\partial p^2=\eta_{\mathrm{e},m}^2/(1+\eta_{\mathrm{e},m}p)^2-\eta_m^2/(1+\eta_mp)^2<0$."

**R12. Remove the dummy variable z in the Jensen step (III-B, l. 318).**

- "$\log_2(1+p_m/(\sigma_m^2z))$ is convex in $z>0$" introduces a z that clashes with the AN vector **z**.
- **Draft:** "Since $\log_2(1+\gamma_m)$ in~\eqref{eq:snr} is a convex function of $[(\bH^{\mathrm H}(\bt)\bH(\bt))^{-1}]_{m,m}$, applying Jensen's inequality yields".

**R13. Resolve remaining notation clashes (one meaning per symbol).**

- App. B, l. 660: "for any deterministic $\mathbf A$" clashes with the side length A. Use **X**, the generic matrix of the Notation paragraph.
- IV-B, l. 475: **r**_n (bold r) clashes with the received signal r_m. Optional rename: **v**_{−n} for **r**_n and **Φ**_{−n} for **Γ**_n, i.e., "the parts of v(t) and Φ(t) that do not depend on t_n", which makes (40)–(41) self-explanatory.
- The italic L disappears with R3.
- No other clashes, undefined symbols, or epsilon or digit-like glyph problems found. The CLAUDE.md glyph rules are met.

### Priority 4: optional

**R14. Move the routine derivative displays (44)–(46) (dℓ/du, dv/du, dΩ/du) to Appendix C (IV-B, l. 487–493).** *Wording*

- Keep in IV-B: "the derivatives of ℓ_n, **v** and **Ω** follow from (40)–(41) (Appendix C)", the expressions for η̇_m and η̇_{e,m}, and the gradient (47).
- This is "routine algebra to an appendix" and shortens IV-B by about 8 lines. It does conflict mildly with your preference for showing derivations, so it is optional.

**R15. Make the rank-one explanation in V-B 1) a one-line derivation (l. 596, rev-8g sentence).** *Decision; exact statement*

- By the moments of App. A:
  - the AN power that a rank-one AN delivers to Eve has the relative variance (2κ_eȲ+1)/(κ_eȲ+1)²;
  - the isotropic AN has (2κ_eȲ+N−M)/(κ_eȲ+N−M)², which is smaller for N−M > 1, since (2a+c)/(a+c)² decreases in c.
- **Draft** (append after "…when the AN occupies a single dimension"):

  > (by the moments in Appendix~\ref{app:indep}, its relative variance $(2\kappa_{\mathrm e}\bar Y+1)/(\kappa_{\mathrm e}\bar Y+1)^2$ exceeds that of the isotropic AN)

**R16. Name the high-SNR AN-power insight among the contributions (Intro, l. 80).** *Decision*

- The α⋆ analysis is an analytical result verified in Fig. 5(b), but it appears neither in the contributions nor in the abstract (the abstract states only the simulation outcome "less AN power").
- **Draft clause** at the end of the first contribution: "…even for a single LU and reduce the AN power required in the high-SNR regime".
- Keep it if you want the analysis credited; skip it if the contributions paragraph should stay minimal.

**R17. Structural option: formulate directly with the ZF-AN scheme (II–III).** *Decision; not recommended*

- **Option:** move III-A into II-C (Fig. 2 and the abstract already present ZF + null-space AN as part of the scheme). Formulate the problem over (t, p, q) at once, so that the current (P2) becomes (P1). Section III then becomes purely analytical and ends with the approximate problem.
- **Pros:** removes a problem that is never solved (a "shallow" restriction step); Section III becomes one analytical thread.
- **Cons:**
  - renumbering of all problems in III–V;
  - loses the explicit general formulation and the lower-bound remark, which TCOM reviewers usually appreciate;
  - no gain in content.
- **Recommendation:** keep the current chain and apply R7.

### Considered and not recommended

- **A closed-form prediction of the constant high-SNR ESSR gain between two designs** (from (32) and α⋆). It would add depth but needs a new verification against stored designs and adds length. Per your earlier rule (derivations not verified later are removed), it is not worth it now.
- **Using α⋆ to initialize or narrow the q-grid of Algorithm 1.** It would show analysis feeding the algorithm, but Algorithm 1 costs only O(Q N_b M), so there is no practical gain, and it needs code changes.
- **Intro ¶1–¶3 and the abstract:** consistent with the supervisor's flow and the guidelines (≈152 words; problem → transformation → insight → algorithm → results). No change proposed beyond R16.

---

## 3. What not to change

- The opening of Section IV (difficulty plus "two favourable properties"): a model of the structure-first narrative.
- The compact LU-rate derivation (18)–(21), and the bounds (21) with their equality condition.
- The single-LU result (30)–(31) ("any feasible t with ρ₁(t) = 0 maximizes the approximate secrecy rate"): a clean structural result, verified in Fig. 8(a).
- Proposition 1 as the only formal environment. It states new, exact facts, as your math-style rule requires.
- The appendix organization (moments, approximations with proof, gradients).

---

## 4. Suggested implementation packages

| Package | Items | Type | Page effect |
|---|---|---|---|
| A (presentation) | R3, R6, R7, R8, R9, R10, R11, R12, R13 | wording | ≈ −0.1 page |
| B (derivation depth) | R1 (+ V-B 1) update, `verify_numbers`), R2 | decision | ≈ +0.1 page |
| C (removals) | R4, R5 | decision / your call | ≈ −0.05 page |
| D (optional) | R14, R15, R16 | wording / decision | R14 ≈ −0.1 page |
| E (structure) | R17 | decision | not recommended |

Recommended: **A + B + C**. The page count stays at 15.

## 5. Decisions needed

1. **R1 + R2:** add the closed-form loss of (20) and the surrogate summary at (P3) (recommended).
2. **R4:** delete the stationarity caveat (recommended), or keep it as a clause.
3. **R5:** delete the multi-Eve footnote (recommended), or move it to III-C in shortened form.
4. **R14–R16** (optional), and **R17** (not recommended).
