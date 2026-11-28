# Rev-10a: Diagnostic review in Review mode (ieee-wireless-writing)

**Basis:** `manuscript/main.tex` at rev-9b (commit `3d32e13`) and `manuscript/main_preview.pdf` (15 pages). The review takes the perspective of an IEEE TWC/TCOM reviewer and academic editor.

**No manuscript changes.** The item IDs [R1]–[R13] are new for this round; they are unrelated to the R-numbers of the rev-9a report. They are logged in `review/ISSUES.md` as I199–I211.

**Severity:**

- **Major:** likely to trigger a major-revision request.
- **Moderate:** a reviewer would probably comment, or the problem-solving thread has a visible gap.
- **Minor:** local wording, figure–text, feasibility statement, or grammar.

## Summary

- **No Major issue.** The problem-solving thread is complete:
  - every modeling assumption is used downstream;
  - every transformation is labelled as a restriction, bound, approximation, or exact step;
  - the hardness is diagnosed precisely;
  - each analytical insight has a simulation counterpart.
- **Two Moderate gaps in the thread:**
  - the benefits that motivate the two-timescale design in Section I are realized by the protocol but never stated there [R4];
  - the known statistical CSI of Eve is the only simplifying assumption the conclusion does not revisit [R12].
- **One Moderate pacing issue:** three Section V paragraphs of about 300 words each carry two topics [R7].
- **Ten Minor items:** wording, figure–text, feasibility, motivation order, and objective grammar.

---

## I. Macro-level analysis

### 1. Audit of the problem-solving logical thread

#### 1.1 Storyline as it stands

| Stage | Content (section) | Verdict |
|---|---|---|
| Pain point | Eve close in direction to an LU under dominant LoS: a fixed array cannot separate them, so precoding and AN lose effectiveness [Mukherjee2014, HuSPL2024]; MAs reshape the channel correlations (I ¶1) | ✓ physical observation, citation-backed |
| Gap | MA-PLS designs reposition the antennas in every CI from instantaneous CSI (operational complexity, CSI over the region, outdated CSI); two-timescale MA designs ignore Eve, and their ZF approximations give no single-user gain (I ¶2–3) | ✓ converges to "remains unexplored" |
| Objective | antenna positions and long-term power allocation from the statistical CSI of the LUs and Eve; ZF + null-space AN in each CI (abstract, I ¶4) | ✓ |
| Modeling for the problem | far-field LoS phases and spatially uncorrelated NLoS, so the positions act only through the LoS components (II-A); frames and CIs (II-B); worst-case Eve, ergodic secrecy rate achieved by coding over CIs (II-C) | ✓ every quantity is used later; one benefit left implicit [R4] |
| Formulation and hardness | (P1); no closed-form ergodic rates, per-realization precoders, objective nonconcave in t through the LoS phases, nonconvex minimum-distance constraints; roadmap (II-D) | ✓ explicit; feasibility not stated [R3] |
| Restriction | ZF + null-space AN with long-term (p, q): (P2), a lower bound on (P1) (III-A) | ✓ why and what stated |
| Analysis | LU rate: Jensen bound and Wishart approximation, with a t-independent LoS gap (III-B); Eve rate: exact conditional moments, moment replacement, c_m and d with the exactness limits of Proposition 1 (III-C) | ✓ deep; motivation order in III-B [R5] |
| Insight | LoS decorrelation mechanisms; single-LU optimum ρ₁ = 0; high-SNR slope M and α⋆ (III-D) | ✓ every insight echoed in V |
| Surrogate | (P3), with what the approximations cost (III-E) | ✓ |
| Solution | difficulty and two favourable properties (IV); secrecy water-filling and a grid over q (IV-A); grid search with rank-one updates, then MM with an exact projection (IV-B); monotone objective, complexity, once-per-frame execution (IV-C) | ✓ mainstream tools, bounded claims |
| Validation | accuracy and convergence (V-B); performance with mechanism evidence and ablations (V-C); system parameters (V-D) | ✓ follows the skill's macro flow |
| Conclusion | consistent with V (gains, κ_e trend, AN power, antennas) | ✓; Eve-CSI loop open [R12] |

#### 1.2 Section-by-section gap diagnosis

- **Abstract.**
  - Task-direct structure: system and task → objective → difficulty ("nonconvex stochastic problem") → transformation and insight → algorithm → result.
  - Only the role of each algorithmic component is implicit [R1].
- **Introduction.**
  - Every factual claim carries a citation, and prior work is grouped by CSI assumption and timescale rather than listed one by one.
  - The novelty claim is qualified, and the contributions map to the two gaps (repositioning overhead → two-timescale design; no Eve and no single-user gain → Eve-dependent approximation).
  - One generalization over the literature rests on a single reference [R2].
- **System model and formulation.**
  - Top-down order (topology → geometry and channels → signals → metric → problem → hardness → roadmap).
  - The assumption on Eve's statistical CSI is offloaded to a footnote, and every defined quantity serves the formulation or the analysis.
  - Two gaps:
    - **[R4]** The protocol (one movement per frame, CSI only at the current positions) is exactly what answers the Section I pain points, but the text does not say so; the reader must infer how the motivation is met.
    - **[R3]** Feasibility of the region and minimum-distance constraints is assumed silently, although Fig. 7(a) starts exactly at the smallest A for which the initial array fits.
- **Analysis (III).**
  - Each step says why it is taken, what it yields, and whether it is exact (restriction → bound → approximation → exactness limits → surrogate cost).
  - No disconnect remains after rev-9b. One local order issue: III-B defines **B**, **L**(t) and (17) before saying why they are needed [R5].
- **Algorithm (IV).**
  - Strategy-first openings and a precise hardness diagnosis ("nonconvex in general, because F_m is not jointly concave in p_m and q").
  - The two subproblems are not phrased mechanically alike.
  - Claims stay within their proof boundary: KKT optimality only for the convex (P3.1) at fixed q; convergence of the objective value only.
  - Initialization, stopping rules, complexity and per-frame deployment are all covered. **No gap.**
- **Simulations (V).**
  - The macro flow follows the skill: accuracy and convergence → mechanisms and bounds → performance → parameters.
  - The benchmarks state what each retains or removes and the fairness conditions.
  - Discussions explain mechanisms with numbers (ρ₁, ξ₁, ψ, α⋆) rather than only trends.
  - Issues are presentation only:
    - no opening statement of the evaluation goals [R6];
    - three overloaded paragraphs [R7];
    - two figure–text details [R8], [R10];
    - one long colon-joined sentence [R9].
- **Conclusion.**
  - Consistent with Section V.
  - One sentence nests two qualifications [R11].
  - The future-work list closes every simplifying assumption except the known statistical CSI of Eve [R12].
- **Appendices.** Correct and complete. Three "due to + relation" constructions [R13].

**Assumption–conclusion loops**

| Assumption (where) | Closed? |
|---|---|
| Spatially uncorrelated NLoS (II-A) | ✓ future work ("spatially correlated NLoS components") |
| Single single-antenna Eve (II-A) | ✓ future work ("multiple multi-antenna eavesdroppers") |
| Perfect CSI of the LUs (II-B) | ✓ future work |
| **Known statistical CSI of Eve** (II-B, footnote) | ✗ not revisited [R12] |
| κ_e → 0 removes the Eve-related mechanisms (III-D 1) | ✓ V-D 3): gain over the rate-oriented MA 1.0% at κ_e = −10 dB |
| Single LU (III-D 2) | ✓ Fig. 8(a), M = 1 |
| High-SNR α⋆ (III-D 3) | ✓ Fig. 5(b): limits within 0.013 |
| LoS gap of (20) (III-B) | ✓ V-B 1): 1.99 bps/Hz versus the limit 2.03 |
| Quality of the surrogate (III-E) | ✓ V-B 1): rankings preserved |

### 2. Global writing quality diagnosis

#### 2.1 Language and pacing

- **Terminology and tone.**
  - Terminology is standard and stable: ESSR, information leakage, AN power received by Eve, LoS correlation, secrecy water-filling, rank-one update, rate-oriented MA.
  - Acronyms are defined once and used consistently.
  - The tone is restrained: claims are bounded ("near-optimal", "suitable surrogate", "guaranteed to converge"), and exceptions are reported (A = 1.5λ).
- **Hard-error scan** (skill §4 and the CLAUDE.md word list):
  - no AI clichés;
  - no comma + "that" and no "superior than";
  - no "in order to" and no "it is worth noting";
  - no stacked "Moreover/Furthermore";
  - the only hits are three "due to + mathematical relation" constructions [R13].
- **Author's voice.** The active "we", "it can be verified that", and varied connectors are natural and should be kept. No stylistic rewriting is proposed.
- **Pacing.** The one weakness is in Section V:
  - three paragraphs of 280–330 words, each combining two topics and 10–20 numbers [R7];
  - two sentences with nested clauses [R9], [R11].

#### 2.2 Section-level paradigm check

| Convention (skill) | Status |
|---|---|
| Introduction and contributions grounded in citations, not subjective assertions | ✓ ([R2] is the only generalization to check) |
| Contributions close the loop with the gaps (what + how + value) | ✓ |
| Notation defined once; only what is used | ✓ |
| Defensible assumptions in footnotes; similarity to prior forms clarified ((20) vs. [Zheng]; (27) vs. [Zhang, Zheng]) | ✓ |
| Hardness diagnosed precisely and roadmap previewed (II-D, IV) | ✓ |
| Four-step motivation loop for derivations | ✓, except the order in III-B [R5] |
| Symmetric subproblems not copy-pasted | ✓ |
| Closing elements of the algorithm section (initialization, stopping, complexity, deployment) | ✓ |
| Simulation section opens with its evaluation goal | ✗ [R6] |
| Fair benchmarks with retained/removed features stated | ✓ |
| Overview–breakdown–takeaway per figure, with mechanisms | ✓; pacing [R7] |
| Conclusion as synthesis, future work grounded in the text | ✓; [R11], [R12] |

#### 2.3 Figure–text consistency and layout (`main_preview.pdf`)

- **What holds:**
  - Figures appear in the order they are cited, and every float sits at the top of the page at or after its first mention.
  - Captions match axes and legends: Fig. 3 markers and lines; Fig. 4 colours and line styles; the dotted limits of Fig. 5(b); the labels of Figs. 6–8.
  - Pages 11–12 each carry two full-width figures, which is dense but usual for TCOM.
- **Two details:**
  - **[R8]** The inset of Fig. 5(a) is not mentioned in the caption or the text.
  - **[R10]** The text says the FPA with Eve-aware AN outperforms the rate-oriented MA for N ≥ 12, whereas Fig. 7(b) shows the crossing between N = 8 and 10.
- No other substantive layout issue.

---

## II. Detail-level revision checklist

| ID | Category | Severity | Location | Original excerpt | Issue diagnosis (per skill) | Revision approach |
|---|---|---|---|---|---|---|
| [R1] | Academic Writing | Minor | Abstract, l. 62 | "Then, we develop an alternating optimization algorithm that combines secrecy water-filling with a grid search and majorization–minimization for each antenna position." | The role of each component is implicit; the sentence reads as if water-filling were combined with the position search. Skill §2.1 asks to state how the difficulty is tackled; the supervisor rule asks to state what the algorithm is used for. | "Then, we develop an alternating optimization algorithm, where the power allocation is obtained by secrecy water-filling and each antenna position is updated by a grid search followed by majorization–minimization." (main clause = step, subordinate clause = detail) |
| [R2] | Academic Writing | Minor | I ¶2, l. 76 | "…whereas most MA-enabled PLS designs assume that this delay is negligible or tolerable~\cite{YuArxiv2025}." | A generalization over the literature ("most designs") rests on a single reference (skill §2.2, citation Iron Law). Reviewers check such quantifiers. | Check that [YuArxiv2025] makes this statement. If it does, keep the sentence. If not, write "existing MA-enabled PLS designs typically assume …", or cite the already-referenced designs that make the assumption. No new references. |
| [R3] | Solution Logic | Minor | II-A, l. 176; (11c)–(11d) | "To mitigate mutual coupling, any two MAs must be separated by at least a minimum distance $D_{\min}$, and the residual coupling is neglected." | The region and minimum-distance constraints can conflict for small A, but feasibility is never stated (skill §2.3, feasibility boundaries). Fig. 7(a) starts at A = 1.5λ, exactly where the 2×(N/2) initial array fits. | One clause after (P1) or in V-A: "(P1) is feasible if the N MAs fit in C with pairwise distances of at least D_min, e.g., if A ≥ (N/2−1)D_min for even N, so that a 2×(N/2) UPA with spacing D_min fits in C." For N = 8, D_min = λ/2, this gives A ≥ 1.5λ. |
| [R4] | Solution Logic | Moderate | II-B, l. 225 (protocol) | "At the beginning of each frame, the BS optimizes … and then moves the MAs to the optimized positions. In each CI of the frame, the BS estimates the channels of the LUs at these positions …" | Section I motivates the two-timescale design by per-CI repositioning, CSI acquisition over the whole region, and outdated CSI. The protocol removes all three, but the text never says so, which leaves the pain-point → model loop implicit (skill §1: every transition has an explicit purpose). | Add one sentence after the protocol description: "Hence, the MAs are moved once per frame rather than in each of the $N_{\mathrm{CI}}$ CIs, and the CSI of the LUs is acquired only at the current antenna positions rather than over the entire movable region." This is true by construction and adds no new claim. A per-CI-repositioning upper bound in V would need new code and is not recommended now. |
| [R5] | Solution Logic | Minor | III-B, l. 315–319; (17)–(18) | "Let $\tilde\beta_m\triangleq\ldots$ … define $\bB$ and $\bL(\bt)$. From (2), the channel matrix … can be written as (17). By (14), the ergodic rate … is determined by the distribution of $[(\bH^{\mathrm H}\bH)^{-1}]_{m,m}$ …" | The decomposition (17) appears before its motivation (skill §2.4-A, four-step loop: motivation → tool → property → next action). | Open III-B with the motivation and Jensen's bound (18). Then introduce **B**, **L**(t) and (17) where the Wishart approximation needs them: "For Rician fading, the expectation in (18) has no closed form. Writing $\bH(\bt)=(\bL(\bt)+\Htl)\bB^{1/2}$ with …, we approximate …". Labels renumber automatically. |
| [R6] | Academic Writing | Minor | V, l. 546–566 | Section V starts with Figs. 3–4 and "Unless otherwise specified, we set …" | No statement of what the section evaluates (skill §2.5: open with the evaluation objective). | One sentence before V-A: "In this section, we evaluate the accuracy of the approximations and the convergence of Algorithm 2, compare the proposed design with the benchmarks, and examine the impact of the system parameters." |
| [R7] | Academic Writing | Moderate | V-B 1), l. 591; V-C, l. 615; V-D 3), l. 639 | Three paragraphs of about 330, 290 and 330 words | Each paragraph combines two topics and 10–20 numbers, so the overview–breakdown–takeaway of each topic is buried (skill §2.5 pacing). | Paragraph breaks only, no new text: in V-B 1) before "For the FPA with Eve-aware AN, the gap reduces …"; in V-C before "For the FPA, the Eve-aware AN increases …"; in V-D 3) before "Fig. 8(b) isolates …". Also move "and by 2.8% at κ = −10 dB" into the common-κ part, so that each paragraph refers to one figure. |
| [R8] | Academic Writing | Minor | Fig. 5 caption, l. 587 | "(a) ESSR and (b) optimized AN power fraction … versus the transmit SNR. The high-SNR limits in (b) are evaluated by (33) …" | The inset of Fig. 5(a), which enlarges the 20 dB window where the rate-oriented MA and the FPA with Eve-aware AN lie 0.7 bps/Hz apart, appears in neither the caption nor the text (figure–text consistency). | Add to the caption: "The inset in (a) enlarges the curves around 20 dB." |
| [R9] | Academic Writing | Minor | V-C (Fig. 5(b)), l. 617 | "The saturation levels agree with the high-SNR limits $1-\alpha^\star$ by (33), which are evaluated with … and shown by dotted lines for the proposed design and the FPA: although (33) assumes equal power among the LUs, these limits exceed …" | About 60 words with a relative clause and a colon-joined concessive clause; hard to parse. | Split at the colon: "… for the proposed design and the FPA. Although (33) assumes equal power among the LUs, these limits exceed the AN power fractions at 30 dB by at most 0.013 for all the schemes." |
| [R10] | Solution Logic | Minor | V-D 1), l. 635; Fig. 7(b) | "Consequently, it outperforms the rate-oriented MA for $N\ge12$" | Fig. 7(b) shows the Eve-aware AN curve above the rate-oriented MA already at N = 10 (19.17 vs. 18.89 bps/Hz; difference within two standard errors). The stated threshold does not match what the reader sees. | Either "for $N\ge10$" (matches the plotted averages) or "overtakes the rate-oriented MA between N = 8 and N = 10". Both are covered by `verify_numbers`. |
| [R11] | Academic Writing | Minor | Conclusion, l. 644 | "… outperforms the rate-oriented MA design, with a gain that grows with the Rician factor of Eve, and the FPA, even with Eve-aware AN unless the movable region is very small, while reducing …" | Two qualifications ("even …", "unless …") are nested inside a list. The claim is correct but hard to parse. | Split without changing the claim: "… outperforms the rate-oriented MA design, with a gain that grows with the Rician factor of Eve, while reducing the AN power and the number of antennas required for secure transmission. It also outperforms the FPA, even if the AN is steered toward Eve, unless the movable region is very small." |
| [R12] | Solution Logic | Moderate | Conclusion, l. 644 (future work); II-B, l. 223 (assumption) | "Extending this design to multiple multi-antenna eavesdroppers, spatially correlated NLoS components, and imperfect CSI of the LUs, …" | The design hinges on the known statistical CSI of Eve, in particular its AoDs. It is the only simplifying assumption the conclusion does not revisit (assumption–conclusion loop; skill §1, claims within the evidence boundary), and TCOM reviewers are likely to raise it. | Minimal: add "errors in the statistical CSI of Eve" to the future-work list. Stronger, but you excluded it in rev-8d: one sentence in V-C with the rev-8c AoD-error result, re-verified with `verify_numbers`. |
| [R13] | Academic Writing | Minor | App. B, l. 669, 675, 681 | "which yields (26) due to $\gb^{\mathrm H}\bPi\gb=\bv^{\mathrm H}\bOm\bv$"; "$\in[0,N]$ due to $\|\gb\|^2=N$"; "equals $(1-M/N)\bI_N$ due to $\tr(\PHp)=N-M$" | "due to" is followed by a mathematical relation, i.e., a clause (skill §3.2, hard error). "due to (46)" and "due to (48)", which are noun references, are fine. | Replace these three "due to" by "since". |

### Suggested selection

- **Recommended:** [R3], [R4], [R5], [R7], [R8], [R10], [R12], [R13].
  - These close the logic loops, fix pacing, align figures and text, and remove hard grammar errors.
  - They add only one new statement, the feasibility condition in [R3], which follows directly from the geometry.
- **Optional (style):** [R1], [R2] (after checking [YuArxiv2025]), [R6], [R9], [R11].
