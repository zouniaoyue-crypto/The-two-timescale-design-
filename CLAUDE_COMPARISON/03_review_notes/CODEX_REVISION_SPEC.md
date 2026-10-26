# CODEX AUTOMATED REVISION SPECIFICATION

## Section 0: Execution Protocol for Codex

### 0.1 Target, evidence, and scope

- Project root: `C:/Users/lenovo/Desktop/GPT/4/manuscript`.
- Path resolution: ticket paths beginning with `manuscript/` are relative to `C:/Users/lenovo/Desktop/GPT/4`; paths beginning with `main.tex` or `ma_secrecy_matlab/` are relative to the project root above. Resolve these two conventions before editing.
- Main source: `main.tex`; original source has 862 lines and SHA-256 `20705b223fd14ed53c88346283bd7e4c6ad4cfe502f1d1a97e4817275f701813`.
- Simulation source: `ma_secrecy_matlab/`; stored results: `ma_secrecy_matlab/results/`.
- Files outside this project are reference literature, not revision targets. Do not rewrite those files. Do not use the archived ZIP as the authoritative implementation.
- This specification is the deliverable. Implement its edits in a subsequent execution, preserving the original source and saved results in a versioned backup before mutation. Original line numbers are baseline locators, not final line numbers.
- Evidence classifications: **source-confirmed**, **stored-result-confirmed**, **analytical deduction**, and **requires execution**. Reading saved MATLAB v7 result files is not a fresh MATLAB run. Do not claim new numerical validation, compilation, measured runtime, or measured layout overflow unless the corresponding operation succeeds.
- Compilation baseline in this audit: `pdflatex` is not discoverable on PATH; the app's built-in compiler fails before TeX starts with Windows access-denied error 5. Therefore compilation and zero-overflow status are **unverified**, and proposed equation reflows are preventive unless a subsequent log confirms overflow. Preserve `main_preview.pdf` as an original preview, not evidence of a successful revised build.

### 0.2 Apply the revision plan

1. Read Sections 1--5 completely. Resolve every `[ORIGINAL]` block against the immutable source snapshot before editing; verify its file, occurrence count, context, and boundaries. All displayed original blocks are literal source, not regular expressions. Use exact text replacement, allowing only CRLF/LF normalization. Never use fuzzy matching to replace mathematical expressions.
2. Create a ticket manifest containing ticket ID, target file, original span, replacement hash, and status. Check for overlapping spans before mutation. If a later ticket addresses a formula inside a larger rewrite, compose the formula change into that rewrite and record both ticket IDs; never restore superseded prose or overwrite a mathematical repair with an older formatting-only replacement. Do not silently skip a ticket because its original text has already changed.
3. Execute Section 1 through Section 5 in order. Apply full-block replacements before broad normalization. Section 3's global notation table defines a finishing pass: register its rules while executing Section 3, then normalize the final combined source after Section 5, including all inserted LaTeX. This explicit dependency prevents a global symbol edit from invalidating later literal original blocks. Local formula replacements in Section 3 execute immediately.
4. Preserve all existing `\label{...}`, `\cite{...}` keys, and `\bibitem{...}` identifiers. A label may move with its equation; it must not disappear or be duplicated. Preserve citation support when reordering prose. Do not invent authors, affiliations, references, empirical results, error bounds, rank assumptions, convergence rates, or optimality guarantees. Keep placeholder author metadata unresolved and flag it in the execution report.
5. Keep the distinctions `(P1)` unrestricted policy, `(P2)` restricted ZF--AN design, and `(P3)` deterministic approximation. A feasible `(P2)` solution is feasible for `(P1)`; this does not establish optimality for `(P1)`. Convergence of values of `F` is not convergence of the exact ESSR, convergence of the iterates, a KKT result, or a global optimum.
6. Modify MATLAB only where a ticket specifies a concrete implementation repair. Preserve paired drops and independent evaluation seeds. Do not replace a physical model or estimator merely to improve a plotted result. Where an estimator inconsistency is disclosed, quantify it rather than silently introducing a new estimator.
7. Treat finite search outputs as candidates. A user power solution is optimal for fixed positions and fixed AN power to the stated bisection accuracy; the finite AN search and finite position grid are not globally optimal continuous solvers. Retain incumbents, endpoints, feasibility, and actual stopping rules.

### 0.3 Required checks after every section

Run the following from the project root after each Section 1--5, preserving a separate build log for each section:

```powershell
pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex
pdflatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex
```

The bibliography is inline; do not add a BibTeX step unless the project is intentionally migrated. The section passes only if both processes exit successfully and the final log has no undefined controls, references, citations, duplicate labels, or `Overfull \hbox` warnings. If a compiler, `IEEEtran.cls`, package, or figure is unavailable, record the dependency failure and keep the checkpoint **unverified**. Continue independent source work, but do not report a clean build. Do not suppress warnings with `\hbadness`, `\hfuzz`, `\sloppy`, reduced margins, smaller global fonts, or scaled whole equations. Repair the actual line, display, table, figure, or algorithm.

After Section 5 and the final normalization pass, run two more PDFLaTeX passes. Inspect the rendered two-column PDF at normal reading size: equations, both algorithms, figures, captions, bibliography, and first/last lines of every page. No figure-only preview substitutes for a compiled manuscript.

### 0.4 Mathematical, numerical, and reporting gates

- Build a closure ledger mapping every `(P1)`--`(P3)` variable and constraint to its update or explicit restriction. The audit-specific closure table is in Section 2.
- Use `check_implementation` as the existing numerical starting point; turn reported failures into assertions and include meaningful edge cases specified below. Check gradients away from clipping boundaries, original spacing and region constraints, nonnegative powers, total power, fixed-AN KKT residuals, rank-one/direct objective equality, and nondecreasing surrogate histories.
- Do not compare an instantaneous positive-part secrecy rate with the manuscript's positive part of the difference of two ergodic rates. Monte Carlo evaluation estimates the two expectations separately before applying the positive part.
- If code changes alter a scheme's output, regenerate every affected `.mat` and figure and update all dependent Abstract, Introduction, simulation, and Conclusion numbers. Until then, retain only claims supported by the existing audited data. Store the old result files separately rather than overwriting their provenance.
- Produce an execution report with completed tickets, exact source changes, compilation logs, tests actually run, updated result fingerprints, and unresolved dependencies. Do not mark the manuscript submission-ready while the compiler gate, changed-result gate, reference gate, or author metadata gate remains unresolved.

### 0.5 Audit-side preflight already completed

The 82 literal replacement blocks match unique spans in nine target files. Their source spans do not overlap. An in-memory application of the exact blocks retains all 124 original manuscript labels, produces 127 unique labels, and has no unresolved citation keys, unresolved cross-references, or unmatched LaTeX environments. Basic brace balance also passes. This validates patch addressing and structural consistency, not TeX compilation, the final token-normalization pass, numerical code execution, or two-column layout. The manuscript and MATLAB source files remain unmodified by this audit.

## Section 1: Optimization Logic Chain & Complete Rewrites (Abstract & Introduction)

### 1.1 Logic & Writing Diagnostic

**Source-confirmed / analytical deduction.** The original Abstract identifies the system, optimization target, and principal tools, but it moves from conditional independence directly to an unconditional closed-form rate approximation without identifying the additional moment closures. Its list of tools does not explain how screening produces a concave power subproblem or how spacing linearization produces a convex feasible polygon. “Optimal power allocation,” “global grid search,” and “converges monotonically” need separate scopes: the first is conditional on fixed AN power, the second optimizes a finite candidate set, and the third concerns the approximate objective values. The final sentence contains no reproducible quantitative comparison.

The final Introduction paragraph combines motivation, derivation, algorithm, convergence, and numerical comparisons in one paragraph; its opening uses the prohibited phrase “bridge this gap.” It also leaves the unrestricted-to-restricted-to-approximate problem chain implicit. Replace it with an explicit motivation paragraph and a contribution list aligned with the Abstract. Do not claim that moment independence proves an ESSR lower bound or that the reported surrogate convergence proves stationarity.

**Stored-result-confirmed quantitative anchor.** `ma_secrecy_matlab/results/fig5_snr.mat`, transmit SNR 20 dB: proposed ESSR `20.74973927`, rate-oriented MA ESSR `18.07564351` bps/Hz. The relative gain is `100*(20.74973927/18.07564351-1) = 14.7939%` (round to `14.8%`). These are Monte Carlo estimates stored in the supplied artifacts, not analytical rates or a newly rerun experiment. Recalculate the numbers from the named scheme fields after any implementation change.

### 1.2 Complete Rewrite of Abstract

**Ticket 1.2 — Location:** `main.tex`, baseline lines 95--97, complete `abstract` environment. The replacement follows background → optimization → intractability → mathematical decomposition → bounded surrogate convergence and quantified physical gain. It has one paragraph and no citations or display equations. Acronyms used in it are defined within it; the main text defines its own acronyms independently.

[ORIGINAL]
```latex
\begin{abstract}
This paper investigates two-timescale secure transmission for a movable antenna (MA)-enabled multiuser downlink system with a passive eavesdropper (Eve), where the antenna positions are optimized based on statistical channel state information (CSI), and the precoding and artificial noise (AN) are designed based on the instantaneous CSI of the legitimate users (LUs). Specifically, under zero-forcing (ZF) precoding and null-space AN, the antenna positions and the power allocation among the confidential signals and the AN are jointly optimized to maximize the ergodic secrecy sum rate (ESSR) subject to the transmit power and antenna position constraints. Since the ergodic wiretap rate depends on the random ZF directions and AN subspace, we first prove that the information leakage and the AN received by Eve are conditionally independent given the channels of the LUs. Based on this property, a closed-form approximation of the ergodic wiretap rate is derived. This approximation reveals that the MAs can reduce the information leakage and increase the AN received by Eve. Then, an alternating optimization algorithm is developed for the resulting approximate ESSR maximization problem. For given antenna positions and AN power, the optimal power allocation among the LUs is derived in semi-closed form and follows a secrecy water-filling structure. For a given power allocation, each antenna position is updated by a global grid search followed by majorization--minimization refinement, and the resulting algorithm converges monotonically. Simulation results demonstrate that the proposed design outperforms the benchmark schemes, even for a single LU, while requiring less AN power and fewer antennas.
\end{abstract}
```

[REPLACE WITH]
```latex
\begin{abstract}
Movable antenna (MA) arrays can separate nearly aligned legitimate and eavesdropping channels, but repositioning under fast fading incurs mechanical overhead. We formulate ergodic secrecy sum rate (ESSR) maximization by jointly optimizing antenna positions and long-term information and artificial noise (AN) powers under total-power, movement-region, and minimum-spacing constraints, using statistical channel state information (CSI). We restrict the instantaneous transmission policy to zero-forcing (ZF) precoding and null-space AN based on legitimate-channel CSI. The resulting problem couples random beamforming directions and AN subspaces with nonconcave position-dependent rates and nonconvex spacing constraints. To obtain a deterministic design objective, we derive conditional leakage and AN moments from their orthogonal Gaussian channel components and construct closed-form moment approximations; these approximations are not secrecy-rate bounds. For fixed positions and AN power, user screening yields a concave power-allocation problem with a secrecy water-filling solution, while a finite coarse-to-fine search selects the AN power. For fixed powers, a feasible grid search identifies position candidates, and quadratic minorization with linearized spacing constraints reduces local refinement to projection onto a convex polygon. Alternating these updates produces a nondecreasing, bounded surrogate-objective sequence without sampling channel realizations during optimization; Monte Carlo evaluation at a transmit signal-to-noise ratio of 20~dB gives a 14.8\% ESSR gain over the rate-oriented two-timescale MA benchmark in the default setting.
\end{abstract}
```


### 1.3 Complete Rewrite of Introduction Motivation & Contributions

**Ticket 1.3 — Location:** `main.tex`, baseline line 112, the complete paragraph beginning `To bridge this gap,` and ending immediately before `\textit{Notations:}`. There is no original separate contribution list: replace this one paragraph with the following motivation and four contributions. Preserve its `ZhengTCOM2025` citation key. Related-work paragraphs at baseline lines 108 and 110 are handled in Section 4.

[ORIGINAL]
```latex
To bridge this gap, we jointly optimize the antenna positions and the long-term power allocation of an MA-enabled multiuser downlink with ZF precoding and null-space AN to maximize the ergodic secrecy sum rate (ESSR) based on the statistical CSI of the LUs and Eve. The resulting design requires neither the instantaneous CSI of Eve nor the antenna movement in each CI. First, we prove that, given the channels of the LUs, the information leakage and the AN received by Eve depend on orthogonal components of the wiretap channel and are thus conditionally independent. Based on this property, we derive a closed-form approximation of the ergodic wiretap rate. The approximation captures the LoS correlation between Eve and the LUs and is accurate over a wide range of Rician factors. Moreover, it reveals that, in contrast to the rate-oriented design, the MAs enhance secrecy by reducing the information leakage and increasing the AN received by Eve, even for a single LU. Then, we develop an alternating optimization (AO) algorithm for the resulting approximate ESSR maximization problem. For given antenna positions and AN power, the optimal power allocation among the LUs is derived in semi-closed form, and the AN power is then optimized by a one-dimensional search. The resulting allocation follows a secrecy water-filling structure and switches off the LUs whose effective channel gains do not exceed that of Eve. For a given power allocation, we update each antenna position by a global grid search followed by majorization--minimization (MM) refinement. The global search avoids the local maxima near the current position of each MA and is rendered affordable by a rank-one structure of the objective function. The resulting AO algorithm converges monotonically, and its complexity does not depend on the number of channel realizations due to the closed-form objective function. Finally, simulation results show that the proposed design outperforms the rate-oriented two-timescale MA design~\cite{ZhengTCOM2025}, antenna selection (AS) from twice as many antennas, and both compact and sparse FPA arrays, while requiring considerably less AN power. With only four MAs, it even outperforms a compact FPA array with $12$ antennas. The secrecy gain persists for a single LU, against an Eve that treats the inter-user interference as noise, under moderate errors in the AoDs of Eve, and when the AoDs of Eve are independent of those of the LUs.
```

[REPLACE WITH]
```latex
The remaining design task is to optimize long-term antenna positions and powers when the wiretap rate depends on the instantaneous ZF directions and AN subspace of the legitimate channels. A rate-oriented position design addresses interference among the LUs, but does not directly control leakage to Eve or its received AN power. We therefore formulate joint ergodic secrecy sum rate (ESSR) maximization with statistical CSI of the LUs and Eve, restrict the short-timescale policy to ZF precoding and isotropic null-space AN, and construct a deterministic approximate objective for the long-term variables. This restriction preserves per-realization power feasibility but does not solve the unrestricted precoding-policy problem. The principal contributions are as follows.
\begin{enumerate}
\item \textit{Wiretap-rate approximation and spatial mechanisms:} Under independent, spatially isotropic Gaussian non-line-of-sight (NLoS) components, we prove conditional independence between the information leakage and the AN-channel energy given the LU channels. We then approximate the random channel moments and the ergodic wiretap rate in closed form. The resulting coefficients characterize leakage along the ZF directions and AN coupling to Eve, in addition to the LU correlation that determines the ZF gain. These approximations are design surrogates rather than certified secrecy-rate bounds; their accuracy is evaluated by Monte Carlo simulation.
\item \textit{Power-allocation decomposition:} For fixed positions and AN power, we identify the users whose legitimate effective gains exceed Eve's gains. The remaining power-allocation problem is strictly concave and admits a secrecy water-filling solution with one dual variable, obtained by bisection. We evaluate the resulting value function over finite coarse and refined AN-power grids because its unimodality is not established. This procedure provides a feasible candidate and does not certify a continuous global optimum.
\item \textit{Feasible position updates and objective convergence:} We develop an alternating optimization (AO) algorithm. For fixed powers, a rank-one Gram-matrix representation permits efficient evaluation of each antenna's feasible grid candidates. Majorization--minimization (MM) refinement uses a quadratic lower model and an inner linear approximation of the spacing constraints, reducing the local update to projection onto a convex polygon. Retaining the current position and accepting only nondecreasing power updates yield a bounded, nondecreasing surrogate-objective sequence. The convergence statement concerns objective values; joint stationarity and global optimality are not established.
\item \textit{Evaluation with the original channel model:} Designs computed from the approximations are evaluated using the instantaneous signal-to-interference-plus-noise ratios (SINRs) over independently generated small-scale fading realizations. In the default setting at a transmit signal-to-noise ratio (SNR) of $20$~dB, the proposed design achieves $20.75$~bps/Hz, compared with $18.08$~bps/Hz for the rate-oriented MA benchmark~\cite{ZhengTCOM2025}, a gain of $14.8\%$. Comparisons with antenna selection (AS) and fixed arrays also examine the AN fraction and antenna count, while additional tests consider single-user operation and errors in Eve's statistical CSI. All reported comparisons refer to the tested channel and resource settings.
\end{enumerate}
```

## Section 2: Problem Formulation & Algorithm Derivation Logic Repair

The tickets below distinguish exact probability identities, moment approximations, restricted optimization, and numerical search. All line numbers refer to the uploaded, unmodified `manuscript/main.tex`; match the literal original block rather than shifted line numbers. Preserve all existing labels and citation keys. The physical model, power restriction, positive-part argument, secrecy water-filling algebra, analytical derivatives, and feasible inner approximation are retained unless a ticket explicitly changes them.

### Ticket 2.1a: State the stochastic and physical domain of the model

**Target:** `manuscript/main.tex`, original lines 216-216.

**Reason / required action:** The full-rank and inverse-moment arguments require positive large-scale gains and finite Rician factors. A distance constraint does not prove independent diffuse fading. State these assumptions explicitly; retain the existing marginal Rician model and its citations.

[ORIGINAL]
```latex
where $\beta_m$ is the large-scale fading coefficient, $\kappa_m\ge0$ is the Rician factor, and $\htl_m\sim\CN(\mathbf 0,\bI_N)$ is the non-LoS (NLoS) component.\footnote{The NLoS components at different antennas are assumed to be independent and identically distributed (i.i.d.)~\cite{ZhengTCOM2025,HuTVT2025}. This assumption is a reasonable approximation in rich-scattering environments with $\Dmin\ge\lambda/2$.} Similarly, the channel from the BS to Eve is given by
```

[REPLACE WITH]
```latex
where $\beta_m>0$ is the large-scale fading coefficient, $0\le\kappa_m<\infty$ is the Rician factor, and $\htl_m\sim\CN(\mathbf 0,\bI_N)$ is the NLoS component.\footnote{For each fixed feasible antenna configuration, the NLoS components at distinct antennas are assumed to be independent and identically distributed (i.i.d.)~\cite{ZhengTCOM2025,HuTVT2025}. This is an idealized rich-scattering model with $\Dmin\ge\lambda/2$; the spacing condition alone does not imply spatial independence. The model specifies the channel distribution at a fixed configuration and does not model the transient channel during antenna movement.} The NLoS components are redrawn independently across CIs. Similarly, the channel from the BS to Eve is given by
```

### Ticket 2.1b: Close the every-realization policy constraint at singular inputs

**Target:** `manuscript/main.tex`, original lines 313-313.

**Reason / required action:** The inverse-based policy is defined only almost surely, whereas (P1) imposes its constraint for every channel input. Define a zero-transmission fallback on the null-probability singular set. Positive noise powers also justify every logarithm and smoothness argument. In code, reject an ill-conditioned numerical realization or use a documented stable factorization; do not identify a finite numerical conditioning threshold with the probability-zero set.

[ORIGINAL]
```latex
is the orthogonal projection onto the null space of $\bH^H(\bt)$. Since $\bH(\bt)$ has full column rank with probability one, we have $\bH^H(\bt)\PHp=\mathbf 0$ and $\tr(\PHp)=N-M$. Hence, the AN causes no interference to the LUs, and the transmit power in each CI is $\sum_{m=1}^M p_m+(N-M)q$.
```

[REPLACE WITH]
```latex
For finite Rician factors, positive large-scale gains, and $N>M$, the independent Gaussian NLoS components imply that $\bH(\bt)$ has full column rank almost surely. Therefore, $\bH^H(\bt)\PHp=\mathbf 0$ and $\tr(\PHp)=N-M$ almost surely. The AN causes no interference to the LUs, and the transmit power in each CI is $\sum_{m=1}^M p_m+(N-M)q$. On a rank-deficient channel realization, which has probability zero under this model, define the policy by $\bw_m=\mathbf 0$ for all $m$ and $\bSig=\mathbf 0$. This extension satisfies the every-realization power constraint in (P1) and does not change any ergodic rate. We assume $\beta_e>0$, $0\le\kappa_e<\infty$, $\sigma_m^2>0$, and $\sigma_e^2>0$ throughout the finite-parameter analysis; infinite Rician factors are considered only as limits.
```

### Ticket 2.1c: State the coding limit behind the secrecy metric

**Target:** `manuscript/main.tex`, original lines 273-273.

**Reason / required action:** A finite frame with N_CI much greater than one does not itself prove a finite-blocklength secrecy guarantee. Identify the rate as the asymptotic stationary-ergodic achievable metric. Do not add a finite-blocklength, outage, or finite-frame claim.

[ORIGINAL]
```latex
Since the instantaneous CSI of Eve is unknown, the confidential message of each LU is encoded over the CIs of a frame, which experience independent realizations of the NLoS components. With this coding, the following ergodic secrecy rate is achievable for the $m$-th LU~\cite{Gopala2008,ZhuTWC2014}:
```

[REPLACE WITH]
```latex
Since the instantaneous CSI of Eve is unknown, the confidential message of each LU is encoded across independently faded CIs with fixed statistical CSI and fixed long-term variables. We use the asymptotic stationary-ergodic coding model in~\cite{Gopala2008,ZhuTWC2014}, under which the following ergodic secrecy rate is achievable for the $m$-th LU:
```

### Ticket 2.1d: Close the protocol and overhead scope

**Target:** `manuscript/main.tex`, original lines 253-253.

**Reason / required action:** The objective is a gross data-phase ergodic spectral-efficiency metric. Endpoint spacing does not specify collision-free movement paths, and once-per-frame motion does not quantify net throughput or energy. State these modeling limits without inventing unmodeled mechanics or overhead numbers.

[ORIGINAL]
```latex
Accordingly, we adopt the two-timescale protocol in Fig.~\ref{fig:protocol}. The time is divided into frames, each of which consists of $N_{\mathrm{CI}}\gg1$ CIs over which the statistical CSI remains constant. At the beginning of each frame, the BS optimizes the antenna positions $\bt$ and the long-term power allocation $(\bp,q)$ (see Section~\ref{sec:zfan}) based on the statistical CSI and moves the MAs accordingly. Then, in each CI, the BS estimates $\bH(\bt)$ via uplink pilots by exploiting the channel reciprocity of time-division duplexing, and designs the precoding and AN. For ease of exposition, $\bH(\bt)$ is assumed to be perfectly estimated, whereas $\gtl$ is never available at the BS. Hence, the MAs are moved only once per frame, and the CSI of the LUs is required only at the current antenna positions.
```

[REPLACE WITH]
```latex
Accordingly, we adopt the two-timescale protocol in Fig.~\ref{fig:protocol}. Each frame contains $N_{\mathrm{CI}}\gg1$ CIs with fixed statistical CSI. At the beginning of the frame, the BS optimizes the antenna positions $\bt$ and the long-term power allocation $(\bp,q)$ (see Section~\ref{sec:zfan}) and moves the MAs to the selected positions. In each CI, uplink pilots and time-division-duplex channel reciprocity provide $\bH(\bt)$ at the selected positions, from which the BS constructs the precoders and AN covariance. The LU CSI is assumed perfect, whereas $\gtl$ is unavailable at the BS. The rate objective measures spectral efficiency during data transmission and excludes the movement delay, movement energy, and pilot overhead. The position constraints describe feasible stationary configurations; antenna trajectories and collision avoidance during repositioning are outside the model. The MAs are repositioned once per frame, and instantaneous LU CSI is required only at the selected configuration.
```

### Ticket 2.2: Separate the exact Jensen bound from the central Wishart approximation

**Target:** `manuscript/main.tex`, original lines 354-354.

**Reason / required action:** The original mixes an exact Jensen inequality with an approximate inverse moment and then calls the final expression conservative. The final noncentral-channel expression has no proved global lower-bound property. Preserve its formula and its valid exact Rayleigh lower-bound case; state which step loses the bound guarantee.

[ORIGINAL]
```latex
Lemma~\ref{lem:lu} follows from Jensen's inequality and a central Wishart approximation of $(\bL(\bt)+\Htl)^H(\bL(\bt)+\Htl)$ with the same mean $\bPhi(\bt)$~\cite{ZhangJSTSP2014}. This approximation is equivalent to that in~\cite[Sec.~IV-A]{ZhengTCOM2025}, reduces to the well-known lower bound $\log_2(1+\zeta_mp_m(N-M))$ for Rayleigh fading~\cite{Ngo2013}, and is conservative in the LoS-dominant regime (see Section~\ref{sec:sim_acc}). Moreover, the antenna positions affect $\tilde R_m(\bt,p_m)$ only through $\omega_m(\bt)$. Since $\bPhi(\bt)\succeq N\bI_M$ and $[\bOm(\bt)]_{m,m}\ge1/[\bPhi(\bt)]_{m,m}=1/(N(\kappa_m+1))$~\cite{Horn2013}, we have
```

[REPLACE WITH]
```latex
To distinguish the exact inequality from the subsequent moment approximation, let $Z_m\triangleq[(\bH^H(\bt)\bH(\bt))^{-1}]_{m,m}$. Since $\log_2(1+p_m/(\sigma_m^2 z))$ is convex for $z>0$, Jensen's inequality gives
\begin{equation}\label{eq:lu_jensen_exact}
\bar R_m\ge
\log_2\!\left(1+\frac{p_m}{\sigma_m^2\E\{Z_m\}}\right).
\end{equation}
The central Wishart approximation in~\cite{ZhangJSTSP2014} replaces the noncentral Gram matrix of $\bL(\bt)+\Htl$ by a central Wishart matrix with $N$ degrees of freedom and covariance $\bPhi(\bt)/N$. Its inverse moment gives $\E\{Z_m\}\approx N\omega_m(\bt)/((N-M)[\bB]_{m,m})$, which yields~\eqref{eq:Rm} and is equivalent to~\cite[Sec.~IV-A]{ZhengTCOM2025}. The inverse-moment substitution is an approximation, so~\eqref{eq:Rm} is not asserted to be a lower bound for an arbitrary noncentral channel. For Rayleigh fading, the inverse moment is exact and~\eqref{eq:Rm} reduces to the lower bound $\log_2(1+\zeta_mp_m(N-M))$~\cite{Ngo2013}. Its behavior in the LoS-dominant regime is evaluated in Section~\ref{sec:sim_acc}. The antenna positions affect $\tilde R_m(\bt,p_m)$ only through $\omega_m(\bt)$. Since $\bPhi(\bt)\succeq N\bI_M$ and $[\bOm(\bt)]_{m,m}\ge1/[\bPhi(\bt)]_{m,m}=1/(N(\kappa_m+1))$~\cite{Horn2013}, we have
```

### Ticket 2.3: Repair the conditional-independence to unconditional-rate transition

**Target:** `manuscript/main.tex`, original lines 378-378.

**Reason / required action:** The conditional independence proof is correct under isotropic Eve covariance. The unqualified concentration argument drops the randomness of the conditional means, so it cannot justify an unconditional ratio-of-means rate. Add the missing total-variance terms, retain the approximation sign, and remove the unqualified all-Rician-large exactness claim. Do not replace conditional independence by unconditional independence anywhere in the paper.

[ORIGINAL]
```latex
Lemma~\ref{lem:indep} reveals that, given the channels of the LUs, the information leakage is determined only by the component of the wiretap channel along the ZF direction, whereas the AN received by Eve is determined only by its component in the null space of $\bH^H(\bt)$. Moreover, the conditional relative variances of $X_m$ and $Y$ are $(2\kappa_e\bar X_m+1)/(\kappa_e\bar X_m+1)^2$ and $(2\kappa_e\bar Y+N-M)/(\kappa_e\bar Y+N-M)^2$, respectively. Hence, $X_m$ concentrates when the LoS leakage $\kappa_e\bar X_m$ is strong, i.e., in the case that dominates the ergodic wiretap rate, and $Y$ concentrates when $N-M$ or $\kappa_e\bar Y$ is large. This concentration property motivates approximating $\bar R_{e,m}=\E\{\log_2(1+p_mX_m/(qY+\sigma_e^2))\}$ by $\log_2(1+p_m\E\{X_m\}/(q\E\{Y\}+\sigma_e^2))$ as in~\cite[Lemma~1]{ZhangJSTSP2014}, which is accurate when $X_m$ and $Y$ concentrate around their means and is asymptotically exact as $\kappa_e,\kappa_m\to\infty$, $\forall m\in\mathcal M$. Using Lemma~\ref{lem:indep} and taking the expectation over $\Htl$, we obtain
```

[REPLACE WITH]
```latex
Lemma~\ref{lem:indep} follows from the isotropic Gaussian covariance of Eve's NLoS component and the orthogonality between the ZF direction and the AN subspace. It does not imply unconditional independence after averaging over $\Htl$. Indeed, the laws of total variance and total covariance give
\begin{align}
\frac{\mathrm{Var}\{X_m\}}{\tilde\beta_e^2}
&=1+2\kappa_e\E\{\bar X_m\}
  +\kappa_e^2\mathrm{Var}\{\bar X_m\},\nonumber\\
\frac{\mathrm{Var}\{Y\}}{\tilde\beta_e^2}
&=N-M+2\kappa_e\E\{\bar Y\}
  +\kappa_e^2\mathrm{Var}\{\bar Y\},\nonumber\\
\frac{\mathrm{Cov}\{X_m,Y\}}{\tilde\beta_e^2}
&=\kappa_e^2\mathrm{Cov}\{\bar X_m,\bar Y\}.
\label{eq:unconditional_moments}
\end{align}
Thus, small conditional relative variances alone do not establish concentration of the unconditional received powers: their conditional means also vary with the LU channel. To obtain a deterministic design objective, we apply a first-order moment approximation to $\log_2(1+p_mX_m/(qY+\sigma_e^2))$, replacing the received powers by their unconditional means, as motivated by~\cite[Lemma~1]{ZhangJSTSP2014}. This replacement is neither an equality nor a general upper or lower bound, because the logarithmic rate is concave in $X_m$ and convex in $Y$ for $p_m,q>0$. Its accuracy must therefore be checked against the exact SINR, including weak-LoS and small-null-space cases. Substitution of the exact conditional means in Lemma~\ref{lem:indep} yields
```

### Ticket 2.4: Qualify exactness and distinguish moment error from rate error

**Target:** `manuscript/main.tex`, original lines 402-402.

**Reason / required action:** The original does not state the rank condition required by its own Appendix and may be read as asserting exact wiretap rates in Rayleigh fading. Specify exactness for the two moments only, then state the separate deterministic-channel limit for the rate. Do not claim asymptotic exactness at a rank-deficient LoS configuration.

[ORIGINAL]
```latex
The approximations $\E\{\bar X_m\}\approx c_m(\bt)$ and $\E\{\bar Y\}\approx d(\bt)$ in Proposition~\ref{prop:eve} are exact for Rayleigh fading and asymptotically exact as the LoS components dominate, and $c_m(\bt),d(\bt)\in[0,N]$ hold as for their exact counterparts (see Appendix~\ref{app:det}). Accordingly, $\xi_m(\bt)$ and $\psi(\bt)$ represent the normalized information leakage for the $m$-th LU and the normalized AN power received by Eve, respectively. Unlike the existing approximations for ZF precoding, which involve only the diagonal entries of $\bOm(\bt)$, Proposition~\ref{prop:eve} captures the correlation between the LoS components of Eve and the LUs via $\bv(\bt)$.
```

[REPLACE WITH]
```latex
The approximations of $\E\{\bar X_m\}$ and $\E\{\bar Y\}$ in Proposition~\ref{prop:eve} are exact when all LU LoS components vanish, and their values lie in $[0,N]$ (see Appendix~\ref{app:det}). Their large-LoS exactness requires a fixed, full-column-rank limiting LU LoS matrix, as specified in Lemma~\ref{lem:det}; it does not cover coincident or linearly dependent limiting LU steering vectors. The corresponding rate approximation in~\eqref{eq:Re} has an additional moment-replacement error and is not exact merely because the LU channels are Rayleigh. If all LU channels and Eve's channel approach deterministic LoS channels with a full-column-rank limiting LU matrix and positive noise powers, the random ZF directions and the AN subspace converge to their deterministic counterparts, and the wiretap-rate approximation also becomes exact. No uniform accuracy statement is made near a rank-deficient limiting LU geometry. The coefficients $\xi_m(\bt)$ and $\psi(\bt)$ describe normalized leakage and normalized AN reception in the adopted approximation. The vector $\bv(\bt)$ retains the LoS correlation between Eve and the LUs, which is absent from an approximation based only on the diagonal of $\bOm(\bt)$.
```

### Ticket 2.5a: Identify the mathematical status of the Appendix construction

**Target:** `manuscript/main.tex`, original lines 715-715.

**Reason / required action:** The proof verifies properties of proposed approximations, rather than deriving an exact expectation or a deterministic equivalent. Explicitly separate the moment construction from the properties that are proved.

[ORIGINAL]
```latex
We first establish the following lemma for a generic noncentral Gaussian matrix, and then apply it to~\eqref{eq:Re0}.
```

[REPLACE WITH]
```latex
We construct approximations for two moments of a noncentral Gaussian matrix and then apply them to~\eqref{eq:Re0}. The following lemma establishes their ranges and their exact limiting cases; it does not provide a finite-parameter error bound.
```

### Ticket 2.5b: State both approximation steps before the exact moment calculation

**Target:** `manuscript/main.tex`, original lines 727-727.

**Reason / required action:** The inverse-of-mean replacement and expectation-of-ratio replacement must not be presented as proved equalities. The following existing numerator and denominator moment equations remain exact for the substituted deterministic inverse.

[ORIGINAL]
```latex
For brevity, let $\bPhi\triangleq\bPhi_{\bF}$. We first prove~\eqref{eq:lem_c}. Replacing $(\bF^H\bF)^{-1}$ in the unnormalized ZF direction by $\bPhi^{-1}=(\E\{\bF^H\bF\})^{-1}$ yields $\wb_m(\bF)\approx\bF\bPhi^{-1}\be_m/\|\bF\bPhi^{-1}\be_m\|$. Then, we approximate the mean of $|\bb^H\bF\bPhi^{-1}\be_m|^2/\|\bF\bPhi^{-1}\be_m\|^2$ by the ratio of the means of its numerator and denominator, in the same spirit as~\cite[Lemma~1]{ZhangJSTSP2014}. Since $\E\{\bW\}=\mathbf 0$ and $\E\{\bW\mathbf x\mathbf x^H\bW^H\}=\|\mathbf x\|^2\bI_N$ for any deterministic $\mathbf x$, we have
```

[REPLACE WITH]
```latex
For brevity, let $\bPhi\triangleq\bPhi_{\bF}$. To construct~\eqref{eq:lem_c}, first replace the random inverse $(\bF^H\bF)^{-1}$ in the unnormalized ZF direction by $\bPhi^{-1}$. Then approximate the expectation of the normalized quadratic ratio by the ratio of its numerator and denominator expectations, in the same spirit as~\cite[Lemma~1]{ZhangJSTSP2014}. These are two distinct approximations; neither follows from $\E\{(\bF^H\bF)^{-1}\}=(\E\{\bF^H\bF\})^{-1}$, which does not hold in general. For the deterministic vector $\bPhi^{-1}\be_m$, the required moments are exact because $\E\{\bW\}=\mathbf 0$ and $\E\{\bW\mathbf x\mathbf x^H\bW^H\}=\|\mathbf x\|^2\bI_N$ for any deterministic $\mathbf x$. Hence,
```

### Ticket 2.5c: Introduce the projector approximation as a construction

**Target:** `manuscript/main.tex`, original lines 733-733.

**Reason / required action:** Do not use “prove” to describe a heuristic expectation closure. The displayed expression that follows retains its approximation sign and label.

[ORIGINAL]
```latex
which lead to~\eqref{eq:lem_c}. Next, we prove~\eqref{eq:lem_d}. Replacing $(\bF^H\bF)^{-1}$ in $\mathbf P_{\bF}\triangleq\bI_N-\mathbf P_{\bF}^\perp=\bF(\bF^H\bF)^{-1}\bF^H$ by $\bPhi^{-1}$ and using $\E\{\bW\bPhi^{-1}\bW^H\}=\tr(\bPhi^{-1})\bI_N$ yield
```

[REPLACE WITH]
```latex
which define the approximation in~\eqref{eq:lem_c}. To construct~\eqref{eq:lem_d}, replacing the random inverse in $\mathbf P_{\bF}\triangleq\bI_N-\mathbf P_{\bF}^{\perp}=\bF(\bF^H\bF)^{-1}\bF^H$ by $\bPhi^{-1}$ first gives
```

### Ticket 2.5d: Replace the unproved projector interpretation by an explicit trace-calibrated ansatz

**Target:** `manuscript/main.tex`, original lines 737-741.

**Reason / required action:** The trace identity fixes one scalar but does not derive the true expected projector. Describe the calibrated closure honestly while retaining its positive-semidefinite range, exact Rayleigh case, and full-rank deterministic limit. Preserve label eq:app4; eq:app3 remains unchanged.

[ORIGINAL]
```latex
where $\bPi$ and $\tr(\bPhi^{-1})\bI_N$ represent the parts of the signal subspace induced by the LoS and NLoS components, respectively. However, \eqref{eq:app3} lets the NLoS component capture the fraction $\tr(\bPhi^{-1})$ of every direction, including those already captured by the LoS component, so that $\bb^H(\bI_N-\bPi-\tr(\bPhi^{-1})\bI_N)\bb$ may even become negative when $\bb$ is closely aligned with the column space of $\Fb$. To avoid this double counting, we let the NLoS component capture a fraction $\vartheta\in[0,1]$ of the complement of $\bPi$ only, i.e.,
\begin{equation}\label{eq:app4}
\E\{\mathbf P_{\bF}\}\approx\bPi+\vartheta(\bI_N-\bPi),
\end{equation}
which satisfies $\mathbf 0\preceq\bPi+\vartheta(\bI_N-\bPi)\preceq\bI_N$ since $\mathbf 0\preceq\bPi\prec\bI_N$, as shown below. The fraction $\vartheta$ is determined by the identity $\tr(\mathbf P_{\bF})=M$, which holds for every realization of $\bF$. Since $\tr(\bPi)=\tr\big(\bPhi^{-1}(\bPhi-N\bI_M)\big)=M-N\tr(\bPhi^{-1})$, taking the trace of both sides of~\eqref{eq:app4} yields $M-N\tr(\bPhi^{-1})+\vartheta\big(N-M+N\tr(\bPhi^{-1})\big)=M$, i.e., $\vartheta=N\tr(\bPhi^{-1})/(N-M+N\tr(\bPhi^{-1}))$. Therefore, $\E\{\mathbf P_{\bF}^\perp\}\approx(1-\vartheta)(\bI_N-\bPi)$ with $1-\vartheta=(N-M)/(N-M+N\tr(\bPhi^{-1}))$, and~\eqref{eq:lem_d} follows.
```

[REPLACE WITH]
```latex
The direct inverse substitution in~\eqref{eq:app3} need not be a contraction: subtracting it from $\bI_N$ can yield a negative quadratic form. We therefore adopt a positive-semidefinite, trace-calibrated ansatz for the expected signal-space projector,
\begin{equation}\label{eq:app4}
\E\{\mathbf P_{\bF}\}
\approx\bPi+\vartheta(\bI_N-\bPi).
\end{equation}
Since $\mathbf 0\preceq\bPi\prec\bI_N$, the right-hand side is a contraction for $\vartheta\in[0,1]$. Matching the exact trace $\tr(\mathbf P_{\bF})=M$ and using $\tr(\bPi)=M-N\tr(\bPhi^{-1})$ fixes
\begin{equation*}
\vartheta=\frac{N\tr(\bPhi^{-1})}
{N-M+N\tr(\bPhi^{-1})}.
\end{equation*}
Consequently, $\E\{\mathbf P_{\bF}^{\perp}\}\approx(1-\vartheta)(\bI_N-\bPi)$, which yields~\eqref{eq:lem_d}. Trace matching does not uniquely determine an expected projector and does not establish an error bound; it fixes the scalar parameter within this ansatz. The range and limiting-case arguments below establish the stated properties of the construction.
```

### Ticket 2.6: Disclose the finite-Rician single-user complementary-projector residual

**Target:** `manuscript/main.tex`, original lines 422-422.

**Reason / required action:** For M=1 the exact identity is barX1+barY=N, but the uploaded c1,d formulas do not preserve it. For example, N=2, kappa1=1, C1=0 gives c1=1/2 and d=4/3. Retain the audited estimator and disclose this limitation. Add a separate sensitivity experiment comparing the existing d with the identity-closed alternative d=N-c1 using exact Monte Carlo rates; do not substitute that alternative into the method or claim its superiority without recomputing results. Existing eq:d1 is reflowed, without changing its estimator, in Section 3.

[ORIGINAL]
```latex
depend on $\bt$ through the LoS correlation $|\hb_1^H(\bt)\gb(\bt)|^2$ between the LU and Eve. Hence, unlike the rate-oriented two-timescale design, where the MAs bring no gain for a single user~\cite[Remark~2]{ZhengTCOM2025}, the MAs enhance the secrecy of a single LU by reducing this correlation.
```

[REPLACE WITH]
```latex
Both quantities depend on $\bt$ through the LoS correlation $|\hb_1^H(\bt)\gb(\bt)|^2$ between the LU and Eve. Reducing this correlation decreases $c_1(\bt)$ and increases $d(\bt)$ in the adopted approximation, whereas the LU rate is position-independent~\cite[Remark~2]{ZhengTCOM2025}. For a single LU, however, the exact projectors satisfy $\wb_1\wb_1^H+\PHp=\bI_N$ and hence $\bar X_1+\bar Y=N$ for every channel realization. The separately constructed approximations do not enforce this identity at finite $\kappa_1$: writing $C_1\triangleq|\hb_1^H(\bt)\gb(\bt)|^2$, their residual is
\begin{equation}\label{eq:single_identity_residual}
c_1+d-N=
\frac{\kappa_1(C_1/N-1)}
{(\kappa_1+1)((N-1)(\kappa_1+1)+1)}.
\end{equation}
Thus, the single-user secrecy trend is a prediction of the approximation that requires verification using the exact SINRs. The residual vanishes in the Rayleigh and deterministic-LoS limits but is generally nonzero between these limits.
```

### Ticket 2.7: Close the positive-part equivalence and objective-monitoring logic

**Target:** `manuscript/main.tex`, original lines 445-445.

**Reason / required action:** The global-optimum equivalence is valid. It does not make F equal to the positive-part sum at every intermediate feasible point. State which objective converges and which expression is evaluated as secrecy performance; preserve the distinct equal-power benchmark objective.

[ORIGINAL]
```latex
where the operator $[\cdot]^+$ in~\eqref{eq:esrapprox} is dropped without loss of optimality. Specifically, for any feasible $(\bt,\bp,q)$, setting $p_m=0$ for every LU whose term in~\eqref{eq:P3obj} is negative yields another feasible solution, whose objective value equals the approximate ESSR $\sum_{m=1}^M\tilde R_m^{\mathrm{sec}}(\bt,p_m,q)$ of the original solution, since the $m$-th term depends only on $p_m$ and $q$ for a given $\bt$. Hence, (P3) has the same optimal value as its counterpart with $[\cdot]^+$, and every term in~\eqref{eq:P3obj} is nonnegative at any optimal solution of (P3). In contrast, under equal power allocation among the LUs, the operator $[\cdot]^+$ must be retained.
```

[REPLACE WITH]
```latex
where removing $[\cdot]^+$ preserves the global optimum under freely adjustable nonnegative user powers. For fixed $\bt$ and $q$, each summand depends only on its own $p_m$. Setting $p_m=0$ for every negative summand preserves feasibility, makes those summands zero, and leaves the other summands unchanged. Therefore, (P3) and its positive-part counterpart have the same global optimum. This argument does not identify $F$ with the approximate ESSR at an arbitrary intermediate position iterate: a position update with fixed powers can make an individual summand negative. Accordingly, Algorithm~\ref{alg:ao} monitors the smooth objective $F$; Monte Carlo evaluation retains $[\cdot]^+$ as in~\eqref{eq:esr}. For a final report of the approximate ESSR, evaluate~\eqref{eq:esrapprox} directly. Under equal user powers, turning off a single user is inadmissible, so the positive-part operator must also be retained during benchmark optimization.
```

### Ticket 2.8a: Distinguish fixed-q optimality from a finite candidate AN-power search

**Target:** `manuscript/main.tex`, original lines 489-493.

**Reason / required action:** The fixed-q convex subproblem has a global KKT solution. The continuous q maximization does not have a proved unimodality or global search guarantee. Specify all endpoint cases, the dual bracket, finite bisection, and the finite-grid output; preserve label eq:qsearch.

[ORIGINAL]
```latex
Next, let $G(q)\triangleq\sum_{m\in\mathcal M}f_m(p_m^\star;q)$ denote the objective value achieved by the optimal $\bp$ for a given $q$, where $G(q)=0$ if $\mathcal M_{\mathrm a}(q)=\emptyset$ or $P_{\mathrm I}(q)=0$. The AN power per dimension is then optimized as
\begin{equation}\label{eq:qsearch}
q^\star=\arg\max_{0\le q\le q_{\max}}\ G(q),
\end{equation}
where $q_{\max}\triangleq\Ptot/(N-M)$. Increasing $q$ reduces the effective channel gains of Eve at the cost of less power for the confidential signals. Since $G(q)$ is not necessarily unimodal, \eqref{eq:qsearch} is tackled by a coarse grid search followed by a finer one around the best grid point (Algorithm~\ref{alg:power}).
```

[REPLACE WITH]
```latex
Next, let $G(q)\triangleq\sum_{m\in\mathcal M}f_m(p_m^\star(q);q)$ denote the optimal fixed-$q$ value. Set $G(q)=0$ and $\bp=\mathbf 0$ when $\mathcal M_{\mathrm a}(q)=\emptyset$ or $P_{\mathrm I}(q)=0$. The continuous AN-power target is
\begin{equation}\label{eq:qsearch}
q^\star\in\underset{0\le q\le q_{\max}}{\arg\max}\ G(q),
\end{equation}
where $q_{\max}\triangleq\Ptot/(N-M)$. Increasing $q$ suppresses Eve's effective gain while reducing the signal-power budget. No unimodality of $G$ is established, so a golden-section or ternary search is not justified as a global solver. Algorithm~\ref{alg:power} evaluates a coarse grid and a finer grid around its best point, retaining the union of both candidate sets. It returns the best evaluated pair $(\hat\bp,\hat q)$, rather than a certified global solution of~\eqref{eq:qsearch}. For a nonempty active set and positive signal budget, the bisection interval is initialized by $\nu_{\mathrm{lo}}=0$ and $\nu_{\mathrm{hi}}=\max_{m\in\mathcal M_{\mathrm a}(q)}(\eta_m-\eta_{e,m}(q))/\ln2$. After $I_{\mathrm b}$ bisection steps, use the upper endpoint in~\eqref{eq:wf}, which preserves the power inequality. The zero dual endpoint is never evaluated.
```

### Ticket 2.8b: Make Algorithm 1 executable at endpoints and retain the coarse incumbent

**Target:** `manuscript/main.tex`, original lines 495-507.

**Reason / required action:** The original calls Proposition 2 even at q_max, where its stated hypotheses fail, omits bisection input, and returns the fine-grid maximum only. A fine grid with an even Q need not contain the best coarse point. Preserve the best coarse value explicitly; Q=41 is the original odd default, so the omission is dormant there. The AO acceptance guard remains necessary.

[ORIGINAL]
```latex
\begin{algorithm}[t]
\caption{Power Allocation for Given $\bt$}\label{alg:power}
\small\begin{algorithmic}[1]
\Require $\{\eta_m,\xi_m\}_{m\in\mathcal M}$, $\psi$, $\sbe$, $\Ptot$, and the grid size $Q$.
\Ensure $q^\star$ and $\bp^\star$.
\For{each $q$ in a uniform grid of $Q$ points over $[0,q_{\max}]$}
  \State Obtain $\bp^\star$ by Proposition~\ref{prop:wf}, where $\nu$ is found by bisection.
  \State Evaluate $G(q)$.
\EndFor
\State Repeat Steps 1--4 over a uniform grid of $Q$ points between the two neighbors of the best grid point.
\State \Return the best $q$ as $q^\star$ and its optimal power allocation as $\bp^\star$.
\end{algorithmic}
\end{algorithm}
```

[REPLACE WITH]
```latex
\begin{algorithm}[t]
\caption{Finite-Grid Power Allocation for Given $\bt$}\label{alg:power}
\small\begin{algorithmic}[1]
\Require $\{\eta_m,\xi_m\}_{m\in\mathcal M}$, $\psi$, $\sbe$, $\Ptot$, integer $Q\ge2$, and $I_{\mathrm b}$.
\Ensure Best evaluated powers $\hat\bp$ and $\hat q$.
\State Set $q_{\max}=\Ptot/(N-M)$ and let $\mathcal Q_0$ contain $Q$ uniformly spaced points in $[0,q_{\max}]$.
\For{each $q\in\mathcal Q_0$}
  \State If $P_{\mathrm I}(q)=0$ or $\mathcal M_{\mathrm a}(q)=\emptyset$, set $\bp(q)=\mathbf 0$ and $G(q)=0$.
  \State Otherwise, compute $\bp(q)$ by~\eqref{eq:wf} with $I_{\mathrm b}$ bisection steps and the feasible upper dual endpoint, and evaluate $G(q)$.
\EndFor
\State Let $q_0$ be a maximizer over $\mathcal Q_0$; break ties by candidate order.
\State Let $a$ and $b$ be its adjacent coarse points, clipped to $[0,q_{\max}]$ at the endpoints.
\State Let $\mathcal Q_1$ contain $Q$ uniformly spaced points in $[a,b]$.
\For{each previously unevaluated $q\in\mathcal Q_1$}
  \State Compute $\bp(q)$ and $G(q)$ with the same zero-case and bisection rules.
\EndFor
\State Select a maximum over $\mathcal Q_1$; replace it by the coarse maximum only if the coarse value is strictly larger. Set the selected powers to $(\hat\bp,\hat q)$.
\State \Return $(\hat\bp,\hat q)$.
\end{algorithmic}
\end{algorithm}
```

### Ticket 2.8c: Synchronize the safe finite search in MATLAB

**Target:** `manuscript/ma_secrecy_matlab/functions/power_opt.m`, original lines 54-62, local function `search1d`. Keep its existing four-argument interface and all callers. Do not add an incumbent-q candidate or otherwise change the default optimization method.

**Reason:** Returning only the second grid can discard the coarse maximum for even `n`. Select from both grids. The original default `n=41` already contains its coarse incumbent in exact arithmetic; this fix removes the parity dependence and does not assert a continuous global optimum.

[ORIGINAL]
```matlab
function [xbest, fbest] = search1d(f, a, b, n)
% coarse grid on [a, b] followed by a fine grid around the best coarse point
x = linspace(a, b, n);
[~, i] = max(f(x));
lo = x(max(i-1, 1));  hi = x(min(i+1, n));
x2 = linspace(lo, hi, n);
[fbest, j] = max(f(x2));
xbest = x2(j);
end
```

[REPLACE WITH]
```matlab
function [xbest, fbest] = search1d(f, a, b, n)
% Retain both grids; prefer the original fine-grid result on a tie.
validateattributes(n, {'numeric'}, {'scalar','integer','>=',2});
x = linspace(a, b, n);
y = reshape(f(x), 1, []);
[fcoarse, i] = max(y);
lo = x(max(i-1, 1));
hi = x(min(i+1, n));
x2 = linspace(lo, hi, n);
y2 = reshape(f(x2), 1, []);
[fbest, j] = max(y2);
xbest = x2(j);
if fcoarse > fbest
    fbest = fcoarse;
    xbest = x(i);
end
end
```

**Required verification:** In a MATLAB verification harness, exercise this helper with `f=@(x) exp(-1e6*(x-1/3).^2)`, `a=0`, `b=1`, and `n=4`; the returned value must retain the evaluated coarse maximum of one. Also check `n=41`, both endpoint maximizers, `P_tot=0`, no secrecy-active user, fixed-q power feasibility, and the existing AO nondecrease guard. Do not claim these tests ran unless a MATLAB-compatible runtime executes them. Preserve the implementation's `nBisect=60` default and disclose it in the algorithm parameters. Record whether the patch changes any regenerated design or reported rate before retaining numerical claims.

### Ticket 2.9a: Remove an unsupported continuous-global-basin guarantee

**Target:** `manuscript/main.tex`, original lines 527-527.

**Reason / required action:** A finite grid is exhaustive only over its candidates. It does not locate a provably best continuous basin, and a local MM method need not converge to a nearby local maximum under every geometry. Describe the actual two-stage search and its valid nondecrease property.

[ORIGINAL]
```latex
Although (P3.2.$n$) has only two real variables, $F(\bt_n)$ is multimodal. Therefore, a purely local method, e.g., the MM method adopted in~\cite{ZhengTCOM2025}, typically converges to a local maximum near the current position of the MA, so that the MAs move slowly across $\mathcal C$ and the AO iterations may stagnate at an inferior solution (see Section~\ref{sec:sim_conv}). To overcome this issue, we tackle (P3.2.$n$) by a coarse-to-fine approach: in Stage~1, a global search over a grid of candidate positions locates the best basin of $F(\bt_n)$; in Stage~2, the MM method refines the position within this basin. The global search is affordable, because the following rank-one structure allows $F(\bt_n)$ to be evaluated at any candidate position with only $\mathcal O(M^2)$ operations.
```

[REPLACE WITH]
```latex
Although (P3.2.$n$) contains only two real variables, its objective can have several local maxima because the spatial phases depend on the antenna position. A local MM step can therefore depend on its starting point~\cite{ZhengTCOM2025}. We combine a search over a finite grid with MM refinement: Stage~1 selects the best feasible evaluated point, including the current position, and Stage~2 improves that point within a convex inner approximation of the spacing constraints. Neither stage certifies a globally optimal position or identifies the basin of a continuous global maximizer. The rank-one structure below reduces the arithmetic cost per grid candidate after its position-independent quantities are formed.
```

### Ticket 2.9b: Qualify the phase-period and grid-resolution argument

**Target:** `manuscript/main.tex`, original lines 548-548.

**Reason / required action:** The shortest period of an individual Fourier phase does not ensure that a finite grid samples the global basin of a nonlinear inverse-matrix objective. Include empty-grid feasibility, zero direction-difference handling, and an empirical resolution check. Section 5 must save exact rate and run time versus d_g for the grid-refinement check, without inventing an accuracy certificate.

[ORIGINAL]
```latex
which requires $\mathcal O(|\mathcal G|M^2)$ operations, e.g., $|\mathcal G|=1681$ candidate positions for $A=4\lambda$ and $d_{\mathrm g}=\lambda/10$. Since the current position is included in the candidates, $F(\hat\bt_n)\ge F(\bt_n)$. The spacing $d_{\mathrm g}$ is chosen as a fraction of the shortest period $\lambda/\max_{i,j\in\mathcal M\cup\{e\}}\|\ba_j-\ba_i\|$ of the phases in $F(\bt_n)$, so that the basins of $F(\bt_n)$ are densely sampled, and $\hat\bt_n$ typically lies in the basin of a globally optimal solution of (P3.2.$n$).
```

[REPLACE WITH]
```latex
which requires $\mathcal O(|\mathcal G|M^2)$ arithmetic operations after the candidate-independent matrix quantities are available, plus the feasibility checks. For example, $A=4\lambda$ and $d_{\mathrm g}=\lambda/10$ give $|\mathcal G|=1681$. Including the current position guarantees $F(\hat\bt_n)\ge F(\bt_n)$ even when no grid point is feasible. The scale $\lambda/\max_{i,j\in\mathcal M\cup\{e\}}\|\ba_j-\ba_i\|$ describes the shortest variation period of an individual nonconstant correlation phase along its own direction. The grid resolution required by the rational matrix objective also depends on the spacing-constrained domain. If all direction differences vanish, the phase-dependent objective is invariant to the position. A grid-refinement study, rather than the phase scale alone, assesses the selected resolution.
```

### Ticket 2.10: Separate a theoretical global minorant from the tested backtracking step

**Target:** `manuscript/main.tex`, original lines 561-566.

**Reason / required action:** Compactness alone is insufficient without a well-defined smooth extension; state the positive-definiteness and noise conditions. Backtracking checks the minorant only at its trial point, which suffices for nondecrease but does not prove a global bound for the accepted curvature. Match the 60-trial cap and the explicit nondecrease guard in position_sweep.m. Keep the smooth signed objective F for the proposed method; do not apply a differentiability assertion to the equal-power positive-part benchmark.

[ORIGINAL]
```latex
Since $F(\bt_n)$ is twice continuously differentiable and $\mathcal C$ is compact, $\nabla_{\bt_n}F$ is Lipschitz continuous over $\mathcal C$ with some constant $\mathcal L_n$. According to the descent lemma~\cite[Lemma~5.7]{Beck2017}, for any $\delta_n\ge\mathcal L_n$, the following quadratic function, which is tight at $\bt_n^{(k)}$, is a lower bound of $F(\bt_n)$:
\begin{align}
F(\bt_n)\ge\hat F_n(\bt_n|\bt_n^{(k)})\triangleq\ &F(\bt_n^{(k)})+\nabla_{\bt_n}F(\bt_n^{(k)})^T\big(\bt_n-\bt_n^{(k)}\big)\nonumber\\
&-\frac{\delta_n}{2}\big\|\bt_n-\bt_n^{(k)}\big\|^2.\label{eq:surrogate}
\end{align}
Since $\mathcal L_n$ is difficult to obtain, $\delta_n$ is determined by backtracking~\cite{Beck2017}, i.e., starting from $\max\{\delta_0,\delta_n^{\mathrm{pre}}/2\}$, where $\delta_0>0$ is a constant and $\delta_n^{\mathrm{pre}}$ is the previously accepted value, $\delta_n$ is doubled until the update below satisfies $F(\bt_n^{(k+1)})\ge\hat F_n(\bt_n^{(k+1)}|\bt_n^{(k)})$, which holds once $\delta_n\ge\mathcal L_n$.
```

[REPLACE WITH]
```latex
For fixed $\bp$, $q$, and the other antenna positions, $F$ is smooth on a neighborhood of the compact square $\mathcal C$: $\bPhi\succeq N\bI_M$ and all noise powers are positive, so the inverse and logarithmic denominators remain well defined. Its coordinate gradient is therefore Lipschitz continuous on $\mathcal C$ with a finite constant $\mathcal L_n$. The smoothness bound~\cite[Lemma~5.7]{Beck2017} gives, for $\delta_n\ge\mathcal L_n$,
\begin{align}
F(\bt_n)&\ge\hat F_n(\bt_n|\bt_n^{(k)})\nonumber\\
&\triangleq F(\bt_n^{(k)})
 +\nabla_{\bt_n}F(\bt_n^{(k)})^T
 (\bt_n-\bt_n^{(k)})\nonumber\\
&\qquad-\frac{\delta_n}{2}
 \|\bt_n-\bt_n^{(k)}\|^2.
\label{eq:surrogate}
\end{align}
The surrogate is value- and gradient-tight at the current point~\cite{Sun2017}. Since $\mathcal L_n$ is unknown, the numerical method starts from $\max\{\delta_0,\delta_n^{\mathrm{pre}}/2\}$ and doubles $\delta_n$ until the trial solution of~\eqref{eq:P32n} satisfies $F(\bt_n^{\mathrm{trial}})\ge\hat F_n(\bt_n^{\mathrm{trial}}|\bt_n^{(k)})$. This pointwise acceptance test is sufficient for the monotonicity argument; passing it does not certify that the tested $\delta_n$ bounds the Hessian everywhere. The test succeeds for sufficiently large $\delta_n$ in exact arithmetic. In the implementation, at most $B_{\max}=60$ trials are made; a failed search retains the current feasible position. A trial is committed only if its computed objective also does not decrease, and $\delta_n^{\mathrm{pre}}$ stores the last accepted curvature value.

For an EP benchmark with objective $F_{\mathrm{EP}}(\bt)=\sum_m[r_m(\bt)]^+$, where $r_m=\tilde R_m-\tilde R_{e,m}$ for its fixed powers, the objective need not be differentiable at $r_m=0$. At the current point define $\mathcal A^{(k)}=\{m:r_m(\bt_n^{(k)})>0\}$ and $h_k(\bt_n)=\sum_{m\in\mathcal A^{(k)}}r_m(\bt_n)$. Then $h_k(\bt_n)\le F_{\mathrm{EP}}(\bt_n)$ everywhere and equality holds at the current point. The implementation uses the gradient of this fixed active sum to construct the quadratic lower model and tests its trial against the full positive-part objective. Thus, the same acceptance argument preserves nondecrease without assuming smoothness of the clipped objective. If the active set is empty, the selected gradient is zero and the current point may be retained.
```

### Ticket 2.11: Define the inner stopping criterion and the feasible-degenerate case

**Target:** `manuscript/main.tex`, original lines 584-584.

**Reason / required action:** The phrase fractional increase is undefined at zero and does not precisely match the supplied code. State the actual max(1,abs(F_new)) normalization. The existing convex-distance lower bound and polygon projection are mathematically valid and are retained; a degenerate feasible polygon is allowed.

[ORIGINAL]
```latex
and $\bt_n^{(k+1)}$ is feasible for (P3.2.$n$) due to~\eqref{eq:distlin}. The MM iterations are repeated until the fractional increase of $F$ is below $\epsilon_{\mathrm{in}}$ or $I_{\mathrm{in}}$ iterations are reached.
```

[REPLACE WITH]
```latex
and the new position satisfies the original spacing constraints because~\eqref{eq:distlin} is a global lower bound. The current position is feasible for the linearized constraints, so the inner polygon is nonempty even if it degenerates to a segment or point. The inner iterations stop when
\begin{equation*}
\frac{F(\bt_n^{(k+1)})-F(\bt_n^{(k)})}
{\max\{1,|F(\bt_n^{(k+1)})|\}}
<\epsilon_{\mathrm{in}},
\end{equation*}
or after $I_{\mathrm{in}}$ iterations. This scaled objective test remains defined when $F$ is zero or signed; it does not by itself certify a stationary point. A failed backtracking search leaves the position unchanged and consequently terminates the inner objective test.
```

### Ticket 2.12: Align Algorithm 2 inputs, outputs, finite inner solves, and stopping

**Target:** `manuscript/main.tex`, original lines 588-603.

**Reason / required action:** The output star suggests an optimizer that is not proved. The original omits the bisection budget, curvature initialization, finite backtracking cap, exact relative stopping definition, and an explicit returned tuple. Preserve both the per-position and post-power acceptance guards, and describe how latest positions are used.

[ORIGINAL]
```latex
\begin{algorithm}[t]
\caption{Two-Timescale AO Algorithm for (P3)}\label{alg:ao}
\small\begin{algorithmic}[1]
\Require Statistical CSI, $\Ptot$, $\mathcal C$, $\Dmin$, $Q$, $d_{\mathrm g}$, $\delta_0$, $\epsilon_{\mathrm{in}}$, $I_{\mathrm{in}}$, $\epsilon$, $I_{\max}$.
\Ensure $\bt^\star$, $\bp^\star$, and $q^\star$.
\State Initialize feasible antenna positions $\bt$, obtain $(\bp,q)$ by Algorithm~\ref{alg:power}, and set $\ell=0$.
\Repeat
  \For{$n=1$ to $N$}
    \State \textit{Stage 1:} Compute $\bGam_n^{-1}$ and $\br_n$, and obtain $\hat\bt_n$ by~\eqref{eq:gridsearch}.
    \State \textit{Stage 2:} Starting from $\bt_n^{(0)}=\hat\bt_n$, update $\bt_n$ by~\eqref{eq:P32n} with backtracking on $\delta_n$ until the fractional increase of $F$ is below $\epsilon_{\mathrm{in}}$ or $I_{\mathrm{in}}$ iterations are reached.
  \EndFor
  \State Obtain $(\bp',q')$ by Algorithm~\ref{alg:power} for the updated $\bt$, and set $(\bp,q)\leftarrow(\bp',q')$ if $F(\bt,\bp',q')\ge F(\bt,\bp,q)$.
  \State $\ell\leftarrow\ell+1$.
\Until{the fractional increase of $F$ is below $\epsilon$ or $\ell=I_{\max}$}
\end{algorithmic}
\end{algorithm}
```

[REPLACE WITH]
```latex
\begin{algorithm}[t]
\caption{Two-Timescale AO Algorithm for (P3)}\label{alg:ao}
\small\begin{algorithmic}[1]
\Require Statistical CSI and noise powers, $\Ptot$, $\mathcal C$, $\Dmin$, $Q$, $I_{\mathrm b}$, $d_{\mathrm g}$, $\delta_0$, $B_{\max}$, $\epsilon_{\mathrm{in}}$, $I_{\mathrm{in}}$, $\epsilon$, and $I_{\max}$.
\Ensure Feasible outputs $\bt^{\mathrm{out}}$, $\bp^{\mathrm{out}}$, and $q^{\mathrm{out}}$.
\State Verify that the selected initial configuration $\bt$ satisfies~\eqref{eq:P2region} and~\eqref{eq:P2dist}.
\State Obtain $(\bp,q)$ by Algorithm~\ref{alg:power}; set $\ell=0$ and $\delta_n^{\mathrm{pre}}=\delta_0$ for every $n$.
\Repeat
  \State Store $F_{\mathrm{old}}=F(\bt,\bp,q)$.
  \For{$n=1$ to $N$}
    \State Form $\bGam_n^{-1}$ and $\br_n$ using the latest positions, and choose $\hat\bt_n$ by~\eqref{eq:gridsearch}.
    \State Starting from $\hat\bt_n$, perform at most $I_{\mathrm{in}}$ updates of~\eqref{eq:P32n} with the pointwise surrogate test, the nondecrease guard, and at most $B_{\max}$ backtracking trials per update.
    \State Stop the inner updates by the scaled objective test in Section~\ref{sec:position}; retain the previous position if no trial is accepted.
  \EndFor
  \State Obtain $(\bp',q')$ by Algorithm~\ref{alg:power} at the updated $\bt$.
  \State Commit $(\bp,q)\leftarrow(\bp',q')$ only if $F(\bt,\bp',q')\ge F(\bt,\bp,q)$.
  \State Set $F_{\mathrm{new}}=F(\bt,\bp,q)$ and $\ell\leftarrow\ell+1$.
\Until{$(F_{\mathrm{new}}-F_{\mathrm{old}})/\max\{1,|F_{\mathrm{new}}|\}<\epsilon$ or $\ell=I_{\max}$}
\State \Return $(\bt^{\mathrm{out}},\bp^{\mathrm{out}},q^{\mathrm{out}})=(\bt,\bp,q)$.
\end{algorithmic}
\end{algorithm}
```

### Ticket 2.13: State exactly which convergence claim is proved

**Target:** `manuscript/main.tex`, original lines 607-607.

**Reason / required action:** Bounded nondecreasing objective values converge; no stationary-point theorem or iterate-convergence proof is present. Separate ideal infinite iteration value convergence, finite implemented stopping, and exact Monte Carlo performance. The original bound and valid value-monotonicity argument are retained.

[ORIGINAL]
```latex
\textit{Convergence:} In each iteration of Algorithm~\ref{alg:ao}, the global search in~\eqref{eq:gridsearch} does not decrease the objective value of (P3), since the current position is included in the candidates, and neither do the MM updates in~\eqref{eq:P32n} due to~\eqref{eq:mono}. Since the power allocation is also updated only if the objective value does not decrease, the objective value is nondecreasing over the iterations. Moreover, it is upper-bounded by $\sum_{m=1}^M\log_2(1+\zeta_m(N-M)(\kappa_m+1)\Ptot)$ according to~\eqref{eq:etabound} and $p_m\le\Ptot$. Therefore, the objective value achieved by Algorithm~\ref{alg:ao} is guaranteed to converge.
```

[REPLACE WITH]
```latex
\textit{Convergence:} The finite-grid position search includes the current point, the accepted MM step satisfies~\eqref{eq:mono}, and the power update is committed only when $F$ does not decrease. Therefore, the sequence of accepted values of the smooth objective $F$ is nondecreasing. It is bounded above by $\sum_{m=1}^M\log_2(1+\zeta_m(N-M)(\kappa_m+1)\Ptot)$ using~\eqref{eq:etabound} and $p_m\le\Ptot$. With the iteration caps removed, these objective values converge. The implemented finite algorithm terminates at its iteration limit or its specified objective-increase tolerance. This argument proves neither convergence of the variables nor stationarity or global optimality: the power search uses a finite grid, the position subproblems are inexact, and the spacing constraints couple the antenna blocks. It also does not establish monotonicity of the exact Monte Carlo ESSR, because $F$ uses approximated rates. The final design is evaluated using~\eqref{eq:esr} with the exact SINRs.
```

### Ticket 2.14: Make the complexity bound describe the supplied implementation

**Target:** `manuscript/main.tex`, original lines 611-611.

**Reason / required action:** The paper claims a rank-one inverse downdate and an O(M^2) MM gradient, but objective_F_n.m freshly forms/inverts Gamma_n and grad_F_n.m calls geo_quantities.m and multiplies Omega*dOmega densely. Candidate evaluation itself is correctly O(M^2); do not mark that part as a bug. Use a conservative actual-code bound instead of promising an unimplemented cache. Keep Monte Carlo evaluation cost separate from the statistical optimizer. Check functions/objective_F_n.m, geo_quantities.m, grad_F_n.m, position_sweep.m, and power_opt.m against this account.

[ORIGINAL]
```latex
\textit{Complexity:} In each iteration, forming $\bPhi$ and $\bOm$ requires $\mathcal O(NM^2+M^3)$ operations. For each MA, $\bGam_n^{-1}$ is obtained from $\bOm$ by a rank-one update. Stage 1 requires $\mathcal O(|\mathcal G|(M^2+N))$ operations, including the feasibility check of the grid points, where $|\mathcal G|=(\lfloor A/d_{\mathrm g}\rfloor+1)^2$. In Stage 2, the gradient in~\eqref{eq:dF} and each evaluation of $F$ require $\mathcal O(M^2)$ operations based on~\eqref{eq:sm}, and solving~\eqref{eq:P32n} by enumeration requires $\mathcal O(N^3)$ operations. Algorithm~\ref{alg:power} requires $\mathcal O(QI_{\mathrm b}M)$ operations, where $I_{\mathrm b}$ is the number of bisection iterations. Hence, the complexity of Algorithm~\ref{alg:ao} per initialization is $\mathcal O\big(I_{\mathrm o}\big(NM^2+M^3+N|\mathcal G|(M^2+N)+NI_{\mathrm{in}}J(M^2+N^3)+QI_{\mathrm b}M\big)\big)$, where $I_{\mathrm o}$ is the number of AO iterations and $J$ is the average number of backtracking trials. In contrast to stochastic optimization~\cite{ZhaoTWC2021}, this complexity does not depend on the number of channel realizations. Since Algorithm~\ref{alg:ao} depends only on the slowly varying statistical CSI, it is executed only once per frame, whereas the ZF precoding and AN generation in each CI require $\mathcal O(NM^2+M^3)$ operations.
```

[REPLACE WITH]
```latex
\textit{Complexity:} Let $C_{\mathrm{geo}}\triangleq NM^2+M^3$ denote the arithmetic cost of forming the Gram matrix and its inverse. Conditional on a precomputed $\bGam_n^{-1}$, a rank-one candidate evaluation costs $\mathcal O(M^2)$; in particular, $[\bOm^2]_{m,m}=\sum_i|[\bOm]_{m,i}|^2$ does not require forming a dense matrix square. The supplied implementation, however, reconstructs $\bGam_n^{-1}$ for each antenna and recomputes the geometry in the generic gradient and objective routines. Its Stage~1 cost per antenna is $\mathcal O(C_{\mathrm{geo}}+|\mathcal G|(M^2+N))$, including spacing checks, where $|\mathcal G|=(\lfloor A/d_{\mathrm g}\rfloor+1)^2$. Each inner MM iteration uses a gradient costing $\mathcal O(C_{\mathrm{geo}})$ and $J$ backtracking trials, each costing $\mathcal O(C_{\mathrm{geo}}+N^3)$. The $N^3$ term accounts for enumerating line intersections and checking their feasibility against all polygon constraints. The power routine uses $\mathcal O(QI_{\mathrm b}M)$ operations after the coefficients are formed. Thus, a conservative bound per initialization is
\begin{align*}
\mathcal O\!\Bigg(I_{\mathrm o}\Bigg\{
&C_{\mathrm{geo}}+QI_{\mathrm b}M\\
&+N\Big[C_{\mathrm{geo}}+|\mathcal G|(M^2+N)\\
&\quad+I_{\mathrm{in}}\big(C_{\mathrm{geo}}
  +J(C_{\mathrm{geo}}+N^3)\big)\Big]
\Bigg\}\Bigg),
\end{align*}
where $I_{\mathrm o}\le I_{\max}$, $J\le B_{\max}$, and $I_{\mathrm{in}}$ bounds the number of inner updates. Executing $N_{\mathrm{init}}$ initializations multiplies the design cost by $N_{\mathrm{init}}$. A fully cached implementation could reduce the repeated geometry cost, but that reduction is not claimed for the supplied code. In contrast to the stochastic optimization in~\cite{ZhaoTWC2021}, the statistical design contains no Monte Carlo channel loop; it is executed once per frame. The separate short-timescale ZF construction requires $\mathcal O(C_{\mathrm{geo}})$ operations per CI. Constructing a dense AN covariance is unnecessary: one AN realization can be generated by projecting a standard complex Gaussian vector with the already available channel factorization.
```

### Constraint and variable closure acceptance table

This is a verification ledger for the tickets above, not a request to change the physical objective or silently relax constraints.

| Original item | Exact implementation/derivation treatment | Acceptance condition |
|---|---|---|
| `(P1)` instantaneous policy `mathcal W` and positive-semidefinite AN covariance | Restrict to normalized ZF and `q P_perp`; define zero fallback on the null-probability rank-deficient set. | Do not call `(P2)` equivalent to or globally optimal for `(P1)`. |
| `p_m >= 0`, `q >= 0` | Fixed-q KKT solution, zero powers for nonpositive secrecy gaps, q-grid within `[0,P_tot/(N-M)]`. | Nonnegative powers; finite bisection chooses feasible upper dual endpoint. |
| Total transmit power `(P2pow)` | Unit-norm signal beams and `tr(P_perp)=N-M`; signal budget `P_I(q)`. | `sum(p)+(N-M)q <= P_tot` with a recorded numerical tolerance; zero-budget endpoint handled. |
| Region `(P2region)` | Feasible finite-grid candidates and the four square halfspaces in the MM polygon. | Both initial and committed antenna coordinates lie in the square. |
| Pairwise spacing `(P2dist)` | Exact grid feasibility and conservative affine lower bound in the MM step. | Every committed pair distance is at least `D_min` within a recorded tolerance; no unproved relaxation tightness claim is needed. |
| Positive-part secrecy metric `(esr)`, `(esrapprox)` | Dropped only in the freely optimized-power surrogate; retained in actual secrecy evaluation and equal-power benchmarks. | Record signed objective and positive-part approximate ESSR separately; never replace the exact Monte Carlo rate by the analytical approximation. |
| Two timescales | Fixed positions/powers per statistical frame; instantaneous legitimate CSI determines directions and AN projector. | No instantaneous Eve CSI or per-CI position optimization enters the proposed design. |
| Proposed rate formulas | Exact conditional moments followed by explicit moment approximations. | No generic finite-parameter bound, deterministic equivalent, Rayleigh-rate exactness, or stationary/global optimization guarantee is introduced. |

**Numerical verification gate for Section 2:** extend the existing implementation check only with the nontrivial cases identified above: finite-grid incumbent retention; empty active set and zero signal budget; analytic gradient against finite differences at generic feasible positions; MM surrogate acceptance and original spacing feasibility; monotonicity of the recorded signed objective; and the exact single-user identity versus its declared approximation residual. Use independent validation channel draws for final rates and preserve the original shared-scenario pairing across schemes. If no MATLAB-compatible runtime is available, mark these checks as pending and retain all source files; do not report successful numerical verification.

## Section 3: Global Mathematical Notation & Equation Formatting Fixes

### 3.1 Global Notation Replacement Table

The table distinguishes requested typography from mathematical errors. Preserve \bH for the LU channel matrix, \Hb for its LoS component, and \Htl for its NLoS component; do not introduce another matrix H. The current source contains no eqnarray or double-dollar displays.

| Physical or mathematical meaning | Original form | Standardized form | File / original lines | Codex instruction |
|---|---|---|---|---|
| Pairwise displacement vector | \bDel expands to \boldsymbol{\Delta} | \boldsymbol{\delta}_{n,i}^{(k)} | main.tex:75,570,572,574 | Replace macro definition below; retain the macro name \bDel. Bold lowercase delta differs from the scalar backtracking parameter \delta_n. |
| Transpose / conjugate transpose | ^T / ^H | ^{\mathrm{T}} / ^{\mathrm{H}} | main.tex:114 and throughout | Final math-token normalization only, including TikZ math labels; do not alter labels, keys, source identifiers, bibliography text, or program code. |
| Complex conjugation | ^* | ^{\mathrm{*}} | main.tex:114,759--764 | Normalize conjugation only; preserve ^\star for optimization outputs. The asterisk already denotes a nonitalic symbol; this is the requested source convention. |
| Trace operator | \tr renders \mathrm{tr} | \operatorname{Tr} | main.tex:38 and all uses | Replace macro below. Capitalization is an editorial convention; operator spacing is the typesetting correction. |
| Diagonal and real-part operators | \mathrm{diag}, \mathrm{Re} | \operatorname{diag}, \operatorname{Re} | main.tex:39--40 | Replace macros below to obtain operator spacing. |
| Descriptive Eve index | _e, _{e,m}, _{e,u} | _{\mathrm{e}}, _{\mathrm{e},m}, _{\mathrm{e},u} | main.tex:79 and channel/rate/noise expressions from218 onward | Normalize math subscript tokens only. Keep m,n,i,u italic. In receiver-index sets, \{e\} becomes \{\mathrm e\}; never replace the exponential base e. |
| Descriptive min/max labels | D_{\min},q_{\max},I_{\max} | D_{\mathrm{min}},q_{\mathrm{max}},I_{\mathrm{max}} | main.tex:78,491--493,591,601,620 | Normalize descriptor subscripts only; do not change genuine \min/\max operators. They are already upright; this enforces the requested descriptor convention. |
| Scalar Lipschitz constant | \mathcal L_n | L_n | main.tex:561,566 | Replace this exact mathematical token in the retained/revised MM argument. Preserve matrix \bL and vector \bl_n. |
| Gaussian law with nonzero mean | circularly symmetric complex Gaussian | proper complex Gaussian | main.tex:114,710 | Use the replacements below. Circular symmetry about the origin is not valid for a nonzero mean. Properness specifies zero pseudocovariance. |
| Single-user Gram matrix | \bPhi=N(\kappa_1+1) is a scalar | [\bPhi]_{1,1}=N(\kappa_1+1) | main.tex:417 | Keep the 1-by-1 matrix type; apply the prose replacement below. |
| Unnormalized ZF direction | long repeated matrix product in numerator and denominator | \bw_m^\circ | main.tex:305--313 | Define the intermediate direction below, then normalize. It is not a new optimization variable. |

Register token-wide normalization now and execute it only after all exact replacement blocks in Sections1--5. Earlier normalization invalidates later ORIGINAL anchors. Do not perform unrestricted text substitutions.

#### Ticket 3.1-A: Operator macros

**Location:** manuscript/main.tex, original lines 38--40. Keep all macro names.

[ORIGINAL]
```latex
\newcommand{\tr}{\mathrm{tr}}
\newcommand{\diag}{\mathrm{diag}}
\newcommand{\RE}{\mathrm{Re}}
```

[REPLACE WITH]
```latex
\newcommand{\tr}{\operatorname{Tr}}
\newcommand{\diag}{\operatorname{diag}}
\newcommand{\RE}{\operatorname{Re}}
```

#### Ticket 3.1-B: Lowercase displacement vector

**Location:** manuscript/main.tex, original lines 75--75. Keep every existing \bDel use.

[ORIGINAL]
```latex
\newcommand{\bDel}{\boldsymbol{\Delta}}
```

[REPLACE WITH]
```latex
\newcommand{\bDel}{\boldsymbol{\delta}}
```

#### Ticket 3.1-C: Notation definitions

**Location:** manuscript/main.tex, original lines 114--114. Correct proper-Gaussian terminology and use complete grammatical definitions.

[ORIGINAL]
```latex
\textit{Notations:} Scalars, vectors, and matrices are denoted by italic, bold lower-case, and bold upper-case letters, respectively. $\mathbb C^{a\times b}$ and $\mathbb R^{a\times b}$ denote the sets of $a\times b$ complex and real matrices, respectively. $(\cdot)^T$, $(\cdot)^*$, and $(\cdot)^H$ denote the transpose, conjugate, and conjugate transpose, and $|\cdot|$, $\|\cdot\|$, and $\tr(\cdot)$ the modulus, Euclidean norm, and trace, respectively. $[\mathbf x]_i$ and $[\bX]_{i,j}$ denote the $i$-th entry of $\mathbf x$ and the $(i,j)$-th entry of $\bX$, $\diag(x_1,\ldots,x_M)$ the diagonal matrix with diagonal entries $x_1,\ldots,x_M$, and $\bX^{1/2}$ the entrywise square root of a nonnegative diagonal matrix $\bX$. $\bI_N$ denotes the $N\times N$ identity matrix, $\be_m$ the $m$-th column of an identity matrix, and $\CN(\boldsymbol\mu,\bSig)$ the circularly symmetric complex Gaussian distribution with mean $\boldsymbol\mu$ and covariance matrix $\bSig$. $\bX\succeq\mathbf 0$ ($\bX\succ\mathbf 0$) means that $\bX$ is positive semidefinite (definite). $j\triangleq\sqrt{-1}$, $\E\{\cdot\}$ and $\mathrm{Var}\{\cdot\}$ denote the expectation and variance, $\RE\{\cdot\}$ the real part, $\nabla_{\mathbf x}f$ the gradient of $f$ w.r.t.\ $\mathbf x$, $[x]^+\triangleq\max\{x,0\}$, $\lfloor x\rfloor$ the largest integer not exceeding $x$, $|\mathcal S|$ the cardinality of a set $\mathcal S$, and $\mathcal O(\cdot)$ and $o(\cdot)$ the big-O and little-o notations, respectively.
```

[REPLACE WITH]
```latex
\textit{Notation:} Scalars, vectors, and matrices are denoted by italic, bold lowercase, and bold uppercase letters, respectively; sets are denoted by calligraphic letters. The spaces of $a\times b$ complex and real matrices are $\mathbb{C}^{a\times b}$ and $\mathbb{R}^{a\times b}$. The operators $(\cdot)^{\mathrm{T}}$, $(\cdot)^{\mathrm{*}}$, and $(\cdot)^{\mathrm{H}}$ denote transpose, conjugation, and conjugate transpose, respectively. The symbols $|\cdot|$, $\|\cdot\|$, and $\tr(\cdot)$ denote modulus, Euclidean norm, and trace. Vector and matrix entries are written as $[\mathbf{x}]_i$ and $[\bX]_{i,j}$. The diagonal entries of $\diag(x_1,\ldots,x_M)$ are $x_1,\ldots,x_M$. For a nonnegative diagonal matrix $\bX$, $\bX^{1/2}$ denotes its entrywise square root. The matrix $\bI_N$ is the $N\times N$ identity matrix, and $\be_m$ is the $m$th standard basis vector of the required dimension. The notation $\CN(\boldsymbol{\mu},\bSig)$ denotes a proper complex Gaussian distribution with mean $\boldsymbol{\mu}$, covariance $\bSig$, and zero pseudocovariance. Positive semidefiniteness and positive definiteness are written as $\bX\succeq\mathbf{0}$ and $\bX\succ\mathbf{0}$. We use $j\triangleq\sqrt{-1}$, $\E\{\cdot\}$ for expectation, $\mathrm{Var}\{\cdot\}$ for variance, $\RE\{\cdot\}$ for the real part, and $\nabla_{\mathbf{x}}f$ for the gradient with respect to $\mathbf{x}$. Finally, $[x]^+\triangleq\max\{x,0\}$, $\lfloor x\rfloor$ is the largest integer not exceeding $x$, $|\mathcal{S}|$ is the cardinality of $\mathcal{S}$, and $\mathcal{O}(\cdot)$ and $o(\cdot)$ denote big-O and little-o order, respectively.
```

### 3.2 Long Equation Splitting & Punctuation Fixes

**Evidence status:** No compilation log accompanies the source, and pdflatex is unavailable on PATH in the audit environment. The following are preventive source-derived reflows, not measured Overfull \hbox findings. Compile the edited source with IEEEtran and inspect the log and rendered columns. Do not hide overflow with \sloppy, negative margins, or scaled-down equations. Section2 owns the substantive surrogate, spacing, projection, monotonicity, single-LU consistency, and complexity changes; use column-safe displays in those replacements.

#### Ticket 3.2-A: LU SINR denominator

**Location:** manuscript/main.tex, original lines 264--266. Define a scalar interference power and retain every physical term.

[ORIGINAL]
```latex
\begin{equation}\label{eq:sinr_gen}
\gamma_m=\frac{|\bh_m^H(\bt)\bw_m|^2}{\sum_{i=1,i\neq m}^{M}|\bh_m^H(\bt)\bw_i|^2+\bh_m^H(\bt)\bSig\bh_m(\bt)+\sigma_m^2}.
\end{equation}
```

[REPLACE WITH]
```latex
\begin{align}
I_m&\triangleq\sum_{\substack{i=1\\ i\neq m}}^{M}
 |\bh_m^H(\bt)\bw_i|^2
 +\bh_m^H(\bt)\bSig\bh_m(\bt),\nonumber\\
\gamma_m&=\frac{|\bh_m^H(\bt)\bw_m|^2}{I_m+\sigma_m^2}.
\label{eq:sinr_gen}
\end{align}
```

#### Ticket 3.2-B: Ergodic-rate definitions

**Location:** manuscript/main.tex, original lines 277--281. Define the rates before the punctuated display.

[ORIGINAL]
```latex
where
\begin{equation}\label{eq:ergodic}
\bar R_m\triangleq\E\{\log_2(1+\gamma_m)\},\quad \bar R_{e,m}\triangleq\E\{\log_2(1+\gamma_{e,m})\}
\end{equation}
denote the ergodic rate of the $m$-th LU and the ergodic wiretap rate of Eve for $s_m$, respectively, with the expectations taken over $\Htl$ and $\gtl$ for a given $\bt$. The ESSR is then $\sum_{m=1}^MR_m^{\mathrm{sec}}$.
```

[REPLACE WITH]
```latex
where $\bar R_m$ is the ergodic rate of LU $m$ and $\bar R_{e,m}$ is the ergodic wiretap rate for $s_m$, defined as
\begin{equation}\label{eq:ergodic}
\begin{aligned}
\bar R_m&\triangleq\E\{\log_2(1+\gamma_m)\},\\
\bar R_{e,m}&\triangleq\E\{\log_2(1+\gamma_{e,m})\}.
\end{aligned}
\end{equation}
Both expectations are taken over $\Htl$ and $\gtl$ for fixed $\bt$. The ESSR is $\sum_{m=1}^{M}R_m^{\mathrm{sec}}$.
```

#### Ticket 3.2-C: ZF normalization and AN projector

**Location:** manuscript/main.tex, original lines 305--312. Retain both labels and citations. Section2 separately replaces original313; remove its opening projector-definition sentence because the projector is defined here.

[ORIGINAL]
```latex
To avoid designing $\mathcal W$ for every realization of $\bH(\bt)$, we restrict the short-timescale policy to ZF precoding and null-space AN with a long-term power allocation. Specifically, in each CI, the precoder of the $m$-th LU is $\bw_m(\bH(\bt))=\sqrt{p_m}\,\wb_m$, where $p_m\ge0$ denotes the power allocated to the $m$-th LU, and
\begin{equation}\label{eq:zf}
\wb_m\triangleq\frac{\bH(\bt)\big(\bH^H(\bt)\bH(\bt)\big)^{-1}\be_m}{\big\|\bH(\bt)\big(\bH^H(\bt)\bH(\bt)\big)^{-1}\be_m\big\|}
\end{equation}
is the normalized ZF precoding vector of the $m$-th LU, which satisfies $\bh_i^H(\bt)\wb_m=0$, $\forall i\neq m$. Meanwhile, the AN is isotropically distributed in the null space of $\bH^H(\bt)$~\cite{Zhou2010,ZhuTWC2014}, i.e., $\bSig(\bH(\bt))=q\,\PHp$, where $q\ge0$ denotes the AN power per dimension, and
\begin{equation}\label{eq:an}
\PHp\triangleq\bI_N-\bH(\bt)\big(\bH^H(\bt)\bH(\bt)\big)^{-1}\bH^H(\bt)
\end{equation}
```

[REPLACE WITH]
```latex
We restrict the short-timescale policy to ZF precoding and null-space AN with a long-term power allocation. In each CI, the precoder for LU $m$ is $\bw_m(\bH(\bt))=\sqrt{p_m}\,\wb_m$, where $p_m\ge0$ is its allocated power. Define the unnormalized and unit-norm ZF directions as
\begin{equation}\label{eq:zf}
\begin{aligned}
\bw_m^\circ&\triangleq\bH(\bt)
 \big(\bH^H(\bt)\bH(\bt)\big)^{-1}\be_m,\\
\wb_m&\triangleq\frac{\bw_m^\circ}{\|\bw_m^\circ\|}.
\end{aligned}
\end{equation}
The direction satisfies $\bh_i^H(\bt)\wb_m=0$ for $i\neq m$. The AN covariance is $\bSig(\bH(\bt))=q\,\PHp$, with $q\ge0$ denoting the AN power per null-space dimension~\cite{Zhou2010,ZhuTWC2014}. The projector onto the null space of $\bH^H(\bt)$ is
\begin{equation}\label{eq:an}
\PHp=\bI_N-\bH(\bt)
 \big(\bH^H(\bt)\bH(\bt)\big)^{-1}\bH^H(\bt).
\end{equation}
```

#### Ticket 3.2-D: ZF SINRs

**Location:** manuscript/main.tex, original lines 316--319. Split the two equal LU expressions.

[ORIGINAL]
```latex
\begin{align}
\gamma_m&=\frac{p_m|\bh_m^H(\bt)\wb_m|^2}{\sigma_m^2}=\frac{p_m}{\sigma_m^2\big[(\bH^H(\bt)\bH(\bt))^{-1}\big]_{m,m}},\label{eq:snr}\\
\gamma_{e,m}&=\frac{p_m|\bg^H(\bt)\wb_m|^2}{q\,\bg^H(\bt)\PHp\bg(\bt)+\sigma_e^2},\label{eq:sinre}
\end{align}
```

[REPLACE WITH]
```latex
\begin{align}
\gamma_m&=\frac{p_m|\bh_m^H(\bt)\wb_m|^2}{\sigma_m^2}
\nonumber\\
&=\frac{p_m}{\sigma_m^2
 \big[(\bH^H(\bt)\bH(\bt))^{-1}\big]_{m,m}},
\label{eq:snr}\\
\gamma_{e,m}&=\frac{p_m|\bg^H(\bt)\wb_m|^2}
 {q\,\bg^H(\bt)\PHp\bg(\bt)+\sigma_e^2},
\label{eq:sinre}
\end{align}
```

#### Ticket 3.2-E: Statistical Gram matrix

**Location:** manuscript/main.tex, original lines 341--343. Use two aligned definition lines.

[ORIGINAL]
```latex
\begin{equation}\label{eq:Phi}
\bPhi(\bt)\triangleq\bL^H(\bt)\bL(\bt)+N\bI_M,\qquad \bOm(\bt)\triangleq\bPhi^{-1}(\bt),
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:Phi}
\begin{aligned}
\bPhi(\bt)&\triangleq\bL^H(\bt)\bL(\bt)+N\bI_M,\\
\bOm(\bt)&\triangleq\bPhi^{-1}(\bt),
\end{aligned}
\end{equation}
```

#### Ticket 3.2-F: Secrecy-rate approximation

**Location:** manuscript/main.tex, original lines 407--409. Retain the positive-part operation.

[ORIGINAL]
```latex
\begin{equation}\label{eq:esrapprox}
R_m^{\mathrm{sec}}\approx\tilde R_m^{\mathrm{sec}}(\bt,p_m,q)\triangleq\big[\tilde R_m(\bt,p_m)-\tilde R_{e,m}(\bt,p_m,q)\big]^+,
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:esrapprox}
\begin{aligned}
R_m^{\mathrm{sec}}&\approx\tilde R_m^{\mathrm{sec}}(\bt,p_m,q)\\
&\triangleq\big[\tilde R_m(\bt,p_m)
 -\tilde R_{e,m}(\bt,p_m,q)\big]^+,
\end{aligned}
\end{equation}
```

#### Ticket 3.2-F2: Single-LU coefficients

**Location:** manuscript/main.tex, original lines 418--421. Reflow the retained estimator without changing its mathematics. In Section2 original422 replacement, change its first word depend to Both quantities depend to follow the punctuated display.

[ORIGINAL]
```latex
\begin{align}
c_1(\bt)&=\frac{\kappa_1|\hb_1^H(\bt)\gb(\bt)|^2/N+1}{\kappa_1+1},\label{eq:c1}\\
d(\bt)&=\frac{(N-1)(\kappa_1+1)}{(N-1)(\kappa_1+1)+1}\bigg(N-\frac{\kappa_1|\hb_1^H(\bt)\gb(\bt)|^2}{N(\kappa_1+1)}\bigg)\label{eq:d1}
\end{align}
```

[REPLACE WITH]
```latex
\begin{align}
c_1(\bt)&=\frac{\kappa_1|\hb_1^H(\bt)\gb(\bt)|^2/N+1}
 {\kappa_1+1},\label{eq:c1}\\
d(\bt)&=\frac{(N-1)(\kappa_1+1)}
 {(N-1)(\kappa_1+1)+1}\nonumber\\
&\quad\times\bigg(N-
 \frac{\kappa_1|\hb_1^H(\bt)\gb(\bt)|^2}
 {N(\kappa_1+1)}\bigg).\label{eq:d1}
\end{align}
```

#### Ticket 3.2-G: High-SNR expansion

**Location:** manuscript/main.tex, original lines 427--429. Put each logarithm on a separate line.

[ORIGINAL]
```latex
\begin{equation}\label{eq:highsnr}
\tilde R_m-\tilde R_{e,m}=\log_2\frac{\alpha\Ptot\eta_m(\bt)}{M}-\log_2\Big(1+\frac{\alpha\Theta_m(\bt)}{1-\alpha}\Big)+o(1),
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:highsnr}
\begin{aligned}
\tilde R_m-\tilde R_{e,m}
={}&\log_2\frac{\alpha\Ptot\eta_m(\bt)}{M}\\
&-\log_2\Big(1+\frac{\alpha\Theta_m(\bt)}
 {1-\alpha}\Big)+o(1),
\end{aligned}
\end{equation}
```

#### Ticket 3.2-H: Water-filling denominator

**Location:** manuscript/main.tex, original lines 474--476. Introduce a descriptive auxiliary scalar v_m^{wf}, distinct from vector \bv; do not change the root or its numerically stable form.

[ORIGINAL]
```latex
\begin{equation}\label{eq:wf}
p_m^\star(\nu)=\bigg[\frac{2(\rho_m-1)}{\sqrt{(\eta_m-\eta_{e,m})^2+4\eta_m\eta_{e,m}\rho_m}+\eta_m+\eta_{e,m}}\bigg]^+
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:wf}
\begin{aligned}
v_m^{\mathrm{wf}}(\nu)
&\triangleq\sqrt{(\eta_m-\eta_{e,m})^2
 +4\eta_m\eta_{e,m}\rho_m(\nu)},\\
p_m^\star(\nu)
&=\left[\frac{2(\rho_m(\nu)-1)}
 {v_m^{\mathrm{wf}}(\nu)+\eta_m+\eta_{e,m}}\right]^+,
\end{aligned}
\end{equation}
```

#### Ticket 3.2-I: Sherman--Morrison formula

**Location:** manuscript/main.tex, original lines 539--541. Suppress only the local vector argument and state that convention explicitly.

[ORIGINAL]
```latex
\begin{equation}\label{eq:sm}
\bOm(\bt)=\bGam_n^{-1}-\frac{\bGam_n^{-1}\bl_n(\bt_n)\bl_n^H(\bt_n)\bGam_n^{-1}}{1+\bl_n^H(\bt_n)\bGam_n^{-1}\bl_n(\bt_n)}.
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:sm}
\bOm(\bt)=\bGam_n^{-1}
-\frac{\bGam_n^{-1}\bl_n\bl_n^H\bGam_n^{-1}}
 {1+\bl_n^H\bGam_n^{-1}\bl_n}.
\end{equation}
Here, $\bl_n=\bl_n(\bt_n)$.
```

#### Ticket 3.2-J: Correlation-vector derivative

**Location:** manuscript/main.tex, original lines 553--553. Break the derivative at the equality.

[ORIGINAL]
```latex
\dot{\bv}&\triangleq\frac{\partial\bv}{\partial u_n}=j\frac{2\pi}{\lambda}\big(a_{e,u}\bI_M-\bD_u\big)\bl_ne^{j\frac{2\pi}{\lambda}\bt_n^T\ba_e},\label{eq:dv}\\
```

[REPLACE WITH]
```latex
\dot{\bv}&\triangleq\frac{\partial\bv}{\partial u_n}\nonumber\\
&=j\frac{2\pi}{\lambda}
 \big(a_{e,u}\bI_M-\bD_u\big)\bl_n
 e^{j\frac{2\pi}{\lambda}\bt_n^T\ba_e},\label{eq:dv}\\
```

#### Ticket 3.2-K: Objective derivative

**Location:** manuscript/main.tex, original lines 557--559. Split within a single summation and preserve all signs.

[ORIGINAL]
```latex
\begin{equation}\label{eq:dF}
\frac{\partial F}{\partial u_n}=\frac{1}{\ln2}\sum_{m=1}^{M}\bigg[\frac{p_m\dot\eta_m}{1+\eta_mp_m}-\frac{\kappa_ep_m\dot c_m}{\chi_m+\Upsilon}+\frac{\kappa_eq\chi_m\dot d}{\Upsilon(\chi_m+\Upsilon)}\bigg],
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:dF}
\begin{aligned}
\frac{\partial F}{\partial u_n}
=\frac{1}{\ln2}\sum_{m=1}^{M}
\bigg[&
\frac{p_m\dot\eta_m}{1+\eta_mp_m}
-\frac{\kappa_ep_m\dot c_m}{\chi_m+\Upsilon}\\
&+\frac{\kappa_eq\chi_m\dot d}
 {\Upsilon(\chi_m+\Upsilon)}\bigg].
\end{aligned}
\end{equation}
```

#### Ticket 3.2-L: Appendix B expectations

**Location:** manuscript/main.tex, original lines 719--722. Move products out of long fractions. Do not strengthen approximation claims.

[ORIGINAL]
```latex
\begin{align}
\E\{|\bb^H\wb_m(\bF)|^2\}&\approx\frac{\big|[\bPhi_{\bF}^{-1}\Fb^H\bb]_m\big|^2+\|\bb\|^2[\bPhi_{\bF}^{-2}]_{m,m}}{[\bPhi_{\bF}^{-1}]_{m,m}},\label{eq:lem_c}\\
\E\{\bb^H\mathbf P_{\bF}^\perp\bb\}&\approx\frac{(N-M)\big(\|\bb\|^2-\bb^H\Fb\bPhi_{\bF}^{-1}\Fb^H\bb\big)}{N-M+N\tr(\bPhi_{\bF}^{-1})}.\label{eq:lem_d}
\end{align}
```

[REPLACE WITH]
```latex
\begin{align}
\E\{|\bb^H\wb_m(\bF)|^2\}
&\approx\frac{1}{[\bPhi_{\bF}^{-1}]_{m,m}}
\nonumber\\
&\quad\times\Big(
 \big|[\bPhi_{\bF}^{-1}\Fb^H\bb]_m\big|^2
 +\|\bb\|^2[\bPhi_{\bF}^{-2}]_{m,m}\Big),
\label{eq:lem_c}\\
\E\{\bb^H\mathbf P_{\bF}^{\perp}\bb\}
&\approx\frac{N-M}
 {N-M+N\tr(\bPhi_{\bF}^{-1})}
\nonumber\\
&\quad\times\big(
 \|\bb\|^2-\bb^H\Fb\bPhi_{\bF}^{-1}\Fb^H\bb\big).
\label{eq:lem_d}
\end{align}
```

#### Ticket 3.2-M: Appendix B moments

**Location:** manuscript/main.tex, original lines 728--732. Preserve exact equalities and both labels.

[ORIGINAL]
```latex
\begin{align}
\E\{|\bb^H\bF\bPhi^{-1}\be_m|^2\}&=|\bb^H\Fb\bPhi^{-1}\be_m|^2+\|\bb\|^2\|\bPhi^{-1}\be_m\|^2\nonumber\\
&=\big|[\bPhi^{-1}\Fb^H\bb]_m\big|^2+\|\bb\|^2[\bPhi^{-2}]_{m,m},\label{eq:app1}\\
\E\{\|\bF\bPhi^{-1}\be_m\|^2\}&=\be_m^T\bPhi^{-1}\bPhi\bPhi^{-1}\be_m=[\bPhi^{-1}]_{m,m},\label{eq:app2}
\end{align}
```

[REPLACE WITH]
```latex
\begin{align}
\E\{|\bb^H\bF\bPhi^{-1}\be_m|^2\}
&=|\bb^H\Fb\bPhi^{-1}\be_m|^2
\nonumber\\
&\quad+\|\bb\|^2\|\bPhi^{-1}\be_m\|^2
\nonumber\\
&=\big|[\bPhi^{-1}\Fb^H\bb]_m\big|^2
\nonumber\\
&\quad+\|\bb\|^2[\bPhi^{-2}]_{m,m},
\label{eq:app1}\\
\E\{\|\bF\bPhi^{-1}\be_m\|^2\}
&=\be_m^T\bPhi^{-1}\bPhi\bPhi^{-1}\be_m
\nonumber\\
&=[\bPhi^{-1}]_{m,m},
\label{eq:app2}
\end{align}
```

#### Ticket 3.2-N: Transformed-vector derivative

**Location:** manuscript/main.tex, original lines 765--767. Split the three-term chain rule.

[ORIGINAL]
```latex
\begin{equation}\label{eq:a4}
\dot{\tilde{\bv}}=\dot{\bOm}\bv+\bOm\dot{\bv}=-\bOm\dot{\bl}_n\big(\bl_n^H\tilde{\bv}\big)-\bOm\bl_n\big(\dot{\bl}_n^H\tilde{\bv}\big)+\bOm\dot{\bv},
\end{equation}
```

[REPLACE WITH]
```latex
\begin{equation}\label{eq:a4}
\begin{aligned}
\dot{\tilde{\bv}}
&=\dot{\bOm}\bv+\bOm\dot{\bv}\\
&=-\bOm\dot{\bl}_n
 \big(\bl_n^H\tilde{\bv}\big)\\
&\quad-\bOm\bl_n
 \big(\dot{\bl}_n^H\tilde{\bv}\big)
 +\bOm\dot{\bv},
\end{aligned}
\end{equation}
```

#### Ticket 3.2-O: Quadratic-form derivative

**Location:** manuscript/main.tex, original lines 774--774. Keep the two products within the real-part operator.

[ORIGINAL]
```latex
\dot\varpi&=2\RE\{\tilde{\bv}^H\dot{\bv}\}-2\RE\big\{(\tilde{\bv}^H\dot{\bl}_n)(\bl_n^H\tilde{\bv})\big\},\label{eq:a6}\\
```

[REPLACE WITH]
```latex
\dot\varpi&=2\RE\{\tilde{\bv}^H\dot{\bv}\}\nonumber\\
&\quad-2\RE\big\{
 (\tilde{\bv}^H\dot{\bl}_n)
 (\bl_n^H\tilde{\bv})\big\},\label{eq:a6}\\
```

**Additional conditional closure:** After all substantive replacements, inspect eq:hbar, eq:Re0, eq:cm, eq:d, eq:P3obj, eq:ln, eq:a2 and long inline formulas in Remarks1--3 and Appendix B. Reflow any remaining measured overflow by splitting at equalities or addition boundaries, or suppressing repeated arguments with an explicit local statement. Preserve labels and mathematical operations. There is no current log from which an exhaustive measured overflow list can be asserted. The original full stop after eq:d is followed by "and" on line392; Section2's coefficient replacement must use a comma there or recast that definition as a separate complete sentence.



### Ticket 3.2-O: Split the leakage and AN coefficients and repair their sentence link

**Location:** `main.tex`, original line 388. Preserve both coefficients and labels exactly in meaning. The final comma connects the displays to the following definition of the correlation vector; the original period leaves an orphaned conjunction.

[ORIGINAL]
```latex
\begin{align}
c_m(\bt)&\triangleq\frac{\big|[\bOm(\bt)\bv(\bt)]_m\big|^2+N[\bOm^2(\bt)]_{m,m}}{\omega_m(\bt)},\label{eq:cm}\\
d(\bt)&\triangleq\frac{(N-M)\big(N-\bv^H(\bt)\bOm(\bt)\bv(\bt)\big)}{N-M+N\tr(\bOm(\bt))}.\label{eq:d}
\end{align}
and $\bv(\bt)\triangleq\bL^H(\bt)\gb(\bt)=\bK^{1/2}\Hb^H(\bt)\gb(\bt)$. Accordingly, the ergodic wiretap rate of Eve for $s_m$ is approximated by
```

[REPLACE WITH]
```latex
\begin{align}
c_m(\bt)&\triangleq
 \frac{\big|[\bOm(\bt)\bv(\bt)]_m\big|^2}
 {\omega_m(\bt)}\nonumber\\
&\quad+\frac{N[\bOm^2(\bt)]_{m,m}}{\omega_m(\bt)},
\label{eq:cm}\\
d(\bt)&\triangleq\frac{N-M}
 {N-M+N\tr(\bOm(\bt))}\nonumber\\
&\quad\times\big(N-\bv^H(\bt)\bOm(\bt)\bv(\bt)\big),
\label{eq:d}
\end{align}
and $\bv(\bt)\triangleq\bL^H(\bt)\gb(\bt)=\bK^{1/2}\Hb^H(\bt)\gb(\bt)$. Accordingly, the ergodic wiretap rate of Eve for $s_m$ is approximated by
```


## Section 4: Section-by-Section Professional IEEE Writing Refactoring (De-AI-fication)

Most prohibited words are absent from this source. Do not invent occurrences or substitute verbs mechanically. The observed phrase "bridge this gap" is removed in Section1. Section2 owns the technical qualifications in the derivation and algorithm; Section5 owns the complete simulation paragraphs. The following tickets cover the remaining observed defects.

### Ticket 4.1: Introduction opening and related work

**Location:** manuscript/main.tex, original lines 108--108. AN introduces interference rather than changing the propagation channel. Remove vague promotion and use present-tense method descriptions. Preserve every citation key.

[ORIGINAL]
```latex
\IEEEPARstart{P}{hysical} layer security (PLS) exploits the randomness and spatial characteristics of wireless channels to protect confidential messages against eavesdropping, thereby complementing upper-layer cryptography~\cite{Wyner1975,Mukherjee2014,WuJSAC2018}. In multi-antenna systems, PLS is typically achieved by secure precoding and artificial noise (AN)~\cite{Goel2008,Zhou2010}, which steer the confidential signals toward the legitimate users (LUs) and degrade the channel of the eavesdropper (Eve), respectively. However, the effectiveness of both techniques relies on the spatial separability between the LUs and Eve~\cite{Mukherjee2014}. When Eve is located in a direction close to that of an LU and the line-of-sight (LoS) propagation is dominant, their channels are highly correlated, and a conventional fixed-position antenna (FPA) array can hardly steer the information-bearing beams away from Eve without sacrificing the beamforming gain at the LU. Recently, movable antennas (MAs)~\cite{ZhuMag2024,ZhuTWC2024Model} and the closely related fluid antennas~\cite{WongTWC2021} have emerged as promising technologies to overcome this limitation, where adjusting the antenna positions within a given region reshapes the channel correlation among different receivers without additional radio-frequency (RF) chains~\cite{MaTWC2024,ZhuTWC2024MU,ZhuCL2023}. For PLS, the transmit beamforming and the antenna positions were jointly optimized in~\cite{HuSPL2024} to maximize the secrecy rate with perfect channel state information (CSI), and the case without the instantaneous CSI of the eavesdroppers was considered in~\cite{HuTMC2024}. More recently, a deterministic equivalent of the ergodic secrecy rate has been derived in~\cite{XieArxiv2026} for a multiple-input multiple-output MA system with a multi-antenna Eve and its statistical CSI, and a sensing-assisted secure design has been developed in~\cite{ChenArxiv2026}, where the antenna positions enhance both the estimation of the angles of departure (AoDs) of Eve and the secrecy rate. However, the designs in~\cite{HuSPL2024,HuTMC2024,XieArxiv2026} optimize the antenna positions based on the instantaneous CSI of the legitimate receivers. Under fast fading, such designs require the antennas to be repositioned in each channel coherence interval (CI), thereby incurring nonnegligible movement delay and energy consumption. Moreover, they require the CSI over the entire movable region, whose acquisition entails channel measurements at many antenna positions~\cite{ZhengTCOM2025,HuTVT2025}. On the other hand, the design in~\cite{ChenArxiv2026} assumes LoS channels and thus does not capture the small-scale fading.
```

[REPLACE WITH]
```latex
\IEEEPARstart{P}{hysical} layer security exploits wireless channel randomness and spatial selectivity to protect confidential messages, complementing upper-layer cryptography~\cite{Wyner1975,Mukherjee2014,WuJSAC2018}. In multi-antenna systems, secure precoding directs confidential signals toward legitimate users (LUs), while artificial noise (AN) introduces interference at an eavesdropper (Eve)~\cite{Goel2008,Zhou2010}. Both techniques depend on spatial separation between the LUs and Eve~\cite{Mukherjee2014}. When Eve and an LU have similar departure angles and line-of-sight (LoS) propagation dominates, their channels are strongly correlated. A fixed-position antenna (FPA) array then has limited ability to suppress leakage without reducing the desired-signal gain.

Movable antennas (MAs)~\cite{ZhuMag2024,ZhuTWC2024Model} and fluid antennas~\cite{WongTWC2021} adjust antenna positions within a prescribed region. This additional spatial freedom changes the channel correlations among receivers without increasing the number of radio-frequency (RF) chains~\cite{MaTWC2024,ZhuTWC2024MU,ZhuCL2023}. The secure design in~\cite{HuSPL2024} jointly optimizes transmit beamforming and antenna positions with perfect channel state information (CSI), while~\cite{HuTMC2024} considers unavailable instantaneous eavesdropper CSI. The analysis in~\cite{XieArxiv2026} derives a deterministic equivalent of the ergodic secrecy rate for a multiple-input multiple-output MA system with statistical CSI of a multi-antenna Eve. The sensing-assisted design in~\cite{ChenArxiv2026} optimizes positions to improve the estimation of Eve's angles of departure (AoDs) and the secrecy rate.

The designs in~\cite{HuSPL2024,HuTMC2024,XieArxiv2026} use instantaneous legitimate-channel CSI for position optimization. Tracking these designs under fast fading requires position adaptation on the channel coherence interval (CI), with associated movement delay and energy consumption. Acquiring channel information over the movable region also requires measurements at multiple antenna positions~\cite{ZhengTCOM2025,HuTVT2025}. The LoS model in~\cite{ChenArxiv2026} does not characterize the effect of small-scale fading on long-term secrecy.
```

### Ticket 4.2: Two-timescale context and mathematical challenges

**Location:** manuscript/main.tex, original lines 110--110. Remove the unverified exhaustive novelty assertion; state the missing secrecy objective and its coupled components.

[ORIGINAL]
```latex
To reduce the movement and CSI acquisition overhead, the two-timescale design, which has been widely studied for intelligent reflecting surfaces~\cite{ZhaoTWC2021}, has been extended to MA systems~\cite{ZhengTCOM2025,HuTVT2025}, where the antenna positions are optimized based on the statistical CSI, and the beamforming is designed based on the instantaneous CSI of the resulting effective channels. Specifically, the antenna positions of a multiuser downlink were optimized in~\cite{ZhengTCOM2025} to maximize the ergodic sum rate under maximum-ratio transmission and zero-forcing (ZF) precoding, and the multiuser uplink with linear and successive interference cancellation receivers was considered in~\cite{HuTVT2025}. However, these works focus on maximizing the ergodic sum rate without considering eavesdropping. To the best of our knowledge, the two-timescale design of MA-enabled secure transmission remains unexplored. Extending the two-timescale MA design to secure transmission is nontrivial for three reasons. First, the ergodic wiretap rate of Eve depends on the random precoding directions and AN subspace induced by the instantaneous CSI of the LUs, whereas the existing ergodic-rate approximations for ZF precoding~\cite{ZhangJSTSP2014,ZhengTCOM2025,HuTVT2025} characterize only the signal power received by the intended users. Second, the antenna positions improve the ergodic rate only by decorrelating the users in the rate-oriented design, and thus bring no gain for a single user~\cite[Remark~2]{ZhengTCOM2025}, whereas their impact on the information leakage and the AN received by Eve has not been characterized. Third, the optimal power allocation between the confidential signals and the AN depends on the antenna positions, which determine the information leakage and the AN received by Eve.
```

[REPLACE WITH]
```latex
Two-timescale designs reduce position-adaptation and CSI-acquisition overhead by separating slow statistical optimization from fast precoding. This approach is studied for intelligent reflecting surfaces in~\cite{ZhaoTWC2021} and for MA systems in~\cite{ZhengTCOM2025,HuTVT2025}. The antenna positions depend on statistical CSI, whereas the precoders depend on the instantaneous effective channels at those positions. The downlink design in~\cite{ZhengTCOM2025} maximizes the ergodic sum rate with maximum-ratio transmission or zero-forcing (ZF) precoding, and the uplink design in~\cite{HuTVT2025} considers linear and successive interference cancellation receivers. These rate objectives do not include information leakage to Eve.

A secrecy objective introduces three coupled requirements. First, Eve's ergodic wiretap rate depends on the random ZF directions and AN subspace induced by the LU channels; intended-user rate approximations~\cite{ZhangJSTSP2014,ZhengTCOM2025,HuTVT2025} do not determine this leakage. Second, position optimization must characterize both the confidential signal and the AN received by Eve. These effects remain relevant with one LU, for which the rate-oriented position design provides no gain under the adopted channel model~\cite[Remark~2]{ZhengTCOM2025}. Third, changing the positions changes the effective LU gains, leakage gains, and AN gain at Eve, which in turn changes the allocation of power between confidential signals and AN.
```

### Ticket 4.3: Spacing and mutual-coupling assumption

**Location:** manuscript/main.tex, original lines 206--206. Minimum spacing mitigates rather than eliminates mutual coupling; make the neglected residual explicit.

[ORIGINAL]
```latex
As illustrated in Fig.~\ref{fig:system}, we consider the downlink of a multiuser system, where a base station (BS) equipped with $N$ MAs serves $M$ single-antenna LUs in the presence of a single-antenna passive Eve. Let $\mathcal M\triangleq\{1,\ldots,M\}$ and $\mathcal N\triangleq\{1,\ldots,N\}$ denote the index sets of the LUs and the MAs, respectively, where $N\ge M+1$ is required to transmit AN in the null space of the channels of the LUs. The MAs are connected to the RF chains via flexible cables and can move within a two-dimensional square region $\mathcal C\triangleq[-A/2,A/2]\times[-A/2,A/2]$ of side length $A$~\cite{ZhuMag2024,ZhuTWC2024Model}. In the local Cartesian coordinate system of $\mathcal C$, the position of the $n$-th MA is denoted by $\bt_n\triangleq[x_n,y_n]^T\in\mathcal C$, and the positions of all the MAs are collected in $\bt\triangleq[\bt_1^T,\ldots,\bt_N^T]^T\in\mathbb R^{2N\times1}$. To avoid mutual coupling, the distance between any two MAs must be no smaller than a minimum distance $\Dmin$.
```

[REPLACE WITH]
```latex
As illustrated in Fig.~\ref{fig:system}, we consider a multiuser downlink in which a base station (BS) with $N$ MAs serves $M$ single-antenna LUs in the presence of a passive single-antenna Eve. The LU and MA index sets are $\mathcal M\triangleq\{1,\ldots,M\}$ and $\mathcal N\triangleq\{1,\ldots,N\}$. We require $N\ge M+1$ so that the LU-channel null space contains at least one AN dimension. The MAs connect to RF chains through flexible cables and move in $\mathcal C\triangleq[-A/2,A/2]\times[-A/2,A/2]$ with side length $A$~\cite{ZhuMag2024,ZhuTWC2024Model}. MA $n$ has position $\bt_n\triangleq[x_n,y_n]^T\in\mathcal C$, and the stacked position vector is $\bt\triangleq[\bt_1^T,\ldots,\bt_N^T]^T\in\mathbb R^{2N\times1}$. Pairwise spacing is constrained to be at least $\Dmin$ to mitigate mutual coupling; residual coupling is neglected in the adopted channel model.
```

### Ticket 4.4: Rician-model transition

**Location:** manuscript/main.tex, original lines 212--212. Introduce the equation directly.

[ORIGINAL]
```latex
where $\lambda$ is the carrier wavelength. As in~\cite{ZhengTCOM2025,HuTVT2025}, the channel from the BS to the $m$-th LU is modeled by Rician fading, i.e.,
```

[REPLACE WITH]
```latex
where $\lambda$ is the carrier wavelength. Following~\cite{ZhengTCOM2025,HuTVT2025}, we adopt the Rician channel model
```

### Ticket 4.6: Protocol-caption acronym reuse

**Location:** manuscript/main.tex, original lines 247--247. CI is already defined in the Introduction.

[ORIGINAL]
```latex
\caption{Two-timescale transmission protocol (CI: coherence interval).}
```

[REPLACE WITH]
```latex
\caption{Two-timescale transmission protocol.}
```

### Ticket 4.7: Single-LU matrix type

**Location:** manuscript/main.tex, original lines 417--417. Retain the exact LU-rate argument and its scope.

[ORIGINAL]
```latex
If $M=1$, then $\bPhi(\bt)=N(\kappa_1+1)$ is a scalar, and $\eta_1=\zeta_1(N-1)(\kappa_1+1)$ does not depend on $\bt$.\footnote{For $M=1$, even the exact ergodic rate $\E\{\log_2(1+p_1\|\bh_1(\bt)\|^2/\sigma_1^2)\}$ does not depend on $\bt$, because the distribution of $\|\bh_1(\bt)\|^2$ depends on $\hb_1(\bt)$ only through $\|\hb_1(\bt)\|^2=N$.} In contrast,
```

[REPLACE WITH]
```latex
For $M=1$, the sole entry of $\bPhi(\bt)$ is $[\bPhi(\bt)]_{1,1}=N(\kappa_1+1)$, so $\eta_1=\zeta_1(N-1)(\kappa_1+1)$ is independent of $\bt$.\footnote{For $M=1$, the exact ergodic rate $\E\{\log_2(1+p_1\|\bh_1(\bt)\|^2/\sigma_1^2)\}$ is also independent of $\bt$, because the distribution of $\|\bh_1(\bt)\|^2$ depends on $\hb_1(\bt)$ only through $\|\hb_1(\bt)\|^2=N$.} In contrast,
```

### Ticket 4.8: Conclusion

**Location:** manuscript/main.tex, original lines 704--704. Use present tense and state the proven objective-value convergence instead of unspecified solution optimality.

[ORIGINAL]
```latex
This paper investigated two-timescale secure transmission for an MA-enabled multiuser downlink system with a passive Eve. The derived closed-form approximation of the ergodic wiretap rate revealed that, beyond decorrelating the LUs, the MAs enhance secrecy by reducing the information leakage and increasing the AN received by Eve. Based on this result, we developed an AO algorithm, which combines secrecy water-filling with a two-stage position update and exhibits fast and monotonic convergence. Simulation results demonstrated that the proposed secrecy-aware positioning significantly outperforms the rate-oriented two-timescale MA design, AS, and FPA arrays, enhances the secrecy even for a single LU, and reduces the AN power and the number of antennas required for secure transmission. Since this paper assumes a single-antenna Eve and perfect CSI of the LUs, extending the design to multiple multi-antenna eavesdroppers and imperfect CSI is an important direction for future work.
```

[REPLACE WITH]
```latex
This paper investigates two-timescale secure transmission for an MA-enabled multiuser downlink with statistical CSI of a passive Eve. A closed-form wiretap-rate approximation characterizes how antenna positions affect information leakage and the AN received by Eve, in addition to the LU ZF gains. The resulting deterministic objective supports an AO method that combines optimal per-user power allocation for fixed AN power, sampled AN-power search, and grid-assisted MM position updates. Feasibility-preserving updates and an acceptance test produce nondecreasing, bounded objective values. The reported simulations show secrecy gains over the rate-oriented MA design, AS, and FPA arrays, including gains with one LU and lower AN-power fractions in the evaluated settings. Extending the model to multiple multi-antenna eavesdroppers and imperfect LU CSI requires new leakage analysis and uncertainty-aware optimization.
```

### Ticket 4.9: Appendix A independence proof

**Location:** manuscript/main.tex, original lines 710--710. Specify properness and dimensions; do not imply unconditional independence.

[ORIGINAL]
```latex
Let $\mathbf U\triangleq[\mathbf u_1,\ldots,\mathbf u_{N-M}]$ be an orthonormal basis of the null space of $\bH^H(\bt)$. Then, $\PHp=\mathbf U\mathbf U^H$ and $Y=\sum_{i=1}^{N-M}|\mathbf u_i^H\bg(\bt)|^2$. Moreover, $\wb_m$ is a unit-norm vector in the column space of $\bH(\bt)$, so that $\mathbf Q\triangleq[\wb_m,\mathbf U]$ has orthonormal columns. On the other hand, since $\gtl$ is independent of $\bH(\bt)$, \eqref{eq:g} yields $\bg(\bt)|\bH(\bt)\sim\CN(\sqrt{\kappa_e\tilde\beta_e}\,\gb(\bt),\tilde\beta_e\bI_N)$. Consequently, $\mathbf Q^H\bg(\bt)$ is conditionally Gaussian with covariance matrix $\tilde\beta_e\mathbf Q^H\mathbf Q=\tilde\beta_e\bI_{N-M+1}$, i.e., its entries $\wb_m^H\bg(\bt),\mathbf u_1^H\bg(\bt),\ldots,\mathbf u_{N-M}^H\bg(\bt)$ are conditionally independent. Hence, $X_m=|\wb_m^H\bg(\bt)|^2$ and $Y$ are conditionally independent. Finally, \eqref{eq:EX} and~\eqref{eq:EY} follow from $\E\{|z|^2\}=|\mu|^2+\tilde\beta_e$ and $\mathrm{Var}\{|z|^2\}=\tilde\beta_e^2+2|\mu|^2\tilde\beta_e$ for $z\sim\CN(\mu,\tilde\beta_e)$, together with $\sum_{i=1}^{N-M}|\mathbf u_i^H\gb(\bt)|^2=\bar Y$.
```

[REPLACE WITH]
```latex
Let $\mathbf U=[\mathbf u_1,\ldots,\mathbf u_{N-M}]\in\mathbb C^{N\times(N-M)}$ have orthonormal columns spanning the null space of $\bH^H(\bt)$. Then $\PHp=\mathbf U\mathbf U^H$ and $Y=\sum_{i=1}^{N-M}|\mathbf u_i^H\bg(\bt)|^2$. The unit-norm ZF direction $\wb_m$ lies in the column space of $\bH(\bt)$. Thus, $\mathbf Q\triangleq[\wb_m,\mathbf U]\in\mathbb C^{N\times(N-M+1)}$ satisfies $\mathbf Q^H\mathbf Q=\bI_{N-M+1}$.

Since $\gtl$ is independent of $\bH(\bt)$, the conditional distribution induced by~\eqref{eq:g} is proper complex Gaussian with mean $\sqrt{\kappa_e\tilde\beta_e}\,\gb(\bt)$ and covariance $\tilde\beta_e\bI_N$. Conditioned on $\bH(\bt)$, $\mathbf Q^H\bg(\bt)$ is therefore proper complex Gaussian with covariance $\tilde\beta_e\bI_{N-M+1}$. Its entries are conditionally independent, so $X_m=|\wb_m^H\bg(\bt)|^2$ is conditionally independent of $Y$. For a proper scalar $z\sim\CN(\mu,\tilde\beta_e)$, the identities $\E\{|z|^2\}=|\mu|^2+\tilde\beta_e$ and $\mathrm{Var}\{|z|^2\}=\tilde\beta_e^2+2|\mu|^2\tilde\beta_e$ yield~\eqref{eq:EX} and~\eqref{eq:EY}, using $\sum_{i=1}^{N-M}|\mathbf u_i^H\gb(\bt)|^2=\bar Y$.
```

### Ticket 4.10: Published sensing-assisted reference

**Location:** manuscript/main.tex, original lines 824--825. Replace the arXiv-only metadata with the published version; preserve the key. Verification: [IEEE DOI record](https://doi.org/10.1109/TWC.2026.3688454).

[ORIGINAL]
```latex
\bibitem{ChenArxiv2026}
Y. Chen, G. Zhang, M. Cui, H. Fu, Q. Wu, and R. Zhang, ``Sensing-assisted secure communication in MA-aided ISAC: CRB analysis and robust design,'' Apr. 2026, \emph{arXiv:2604.23663}.
```

[REPLACE WITH]
```latex
\bibitem{ChenArxiv2026}
Y. Chen, G. Zhang, M. Cui, H. Fu, Q. Wu, and R. Zhang, ``Sensing-assisted secure communication in MA-aided ISAC: CRB analysis and robust design,'' \emph{IEEE Trans. Wireless Commun.}, vol.~25, pp.~16400--16416, 2026, doi: 10.1109/TWC.2026.3688454.
```

**Acronym normalization after exact patches:** The revised Introduction defines NLoS, AO, MM, ESSR, AS, SNR, and SINR; remove later repeated expansions if they survive Section2/5 replacements. At original263 replace the exact phrase "signal-to-interference-plus-noise ratio (SINR)" with "SINR". At original426 replace "signal-to-noise ratio (SNR)" with "SNR". These are targeted phrase changes, not deletion of definitions from the Introduction or Abstract. The two scopes define each abbreviation independently; do not force unused abbreviations into the Abstract.

**Section-wide writing acceptance:** Preserve bibliography titles verbatim, even when they contain an acronym or a word prohibited in manuscript prose. Use present tense for the model, method, and figure observations. Sentence-initial figure citations use Figure~\ref{...}; sentence-interior citations use Fig.~\ref{...}. The original sentence-initial occurrences at634,645,657,659,671,673,685,689 are addressed by Section5's full paragraph rewrites. No Eq. or equation (n) references occur in the original prose. Use \eqref{...} within sentences and Equation~\eqref{...} only at sentence starts. Keep Section, Table, Algorithm, Lemma, Proposition, Theorem, and Appendix capitalized. Do not repeat original-source patches inside paragraphs already replaced by another ticket.



### Ticket 4.11: Reuse the SINR definition from the Introduction

**Location:** `main.tex`, original line 263. Remove only the repeated expansion; preserve the complete mathematical sentence.

[ORIGINAL]
```latex
The signal received at the $m$-th LU is $y_m=\bh_m^H(\bt)\bx+n_m$, where $n_m\sim\CN(0,\sigma_m^2)$ is the additive white Gaussian noise. The resulting signal-to-interference-plus-noise ratio (SINR) of the $m$-th LU is
```

[REPLACE WITH]
```latex
The signal received at the $m$-th LU is $y_m=\bh_m^H(\bt)\bx+n_m$, where $n_m\sim\CN(0,\sigma_m^2)$ is the additive white Gaussian noise. The resulting SINR of the $m$-th LU is
```


### Ticket 4.12: Reuse the SNR definition from the Introduction

**Location:** `main.tex`, original line 426. Remove only the repeated expansion; preserve the complete mathematical sentence.

[ORIGINAL]
```latex
Consider the information--AN power splitting with equal power among the LUs, i.e., $p_m=\alpha\Ptot/M$ and $q=(1-\alpha)\Ptot/(N-M)$, where $\alpha\in(0,1)$ is the power-splitting factor. In the high signal-to-noise ratio (SNR) regime, i.e., as $\Ptot\to\infty$, we have
```

[REPLACE WITH]
```latex
Consider the information--AN power splitting with equal power among the LUs, i.e., $p_m=\alpha\Ptot/M$ and $q=(1-\alpha)\Ptot/(N-M)$, where $\alpha\in(0,1)$ is the power-splitting factor. In the high SNR regime, i.e., as $\Ptot\to\infty$, we have
```


### Ticket 4.13: Align the power-comparison setup, caption, and linear gains

**Location:** `main.tex`, original line 689. Use Figure at sentence start, avoid redefining EP after its caption, and distinguish positive linear channel gains from their decibel values.

[ORIGINAL]
```latex
Fig.~\ref{fig:sep_pa}(b) evaluates the benefit of the proposed long-term power allocation, i.e., the secrecy water-filling in Proposition~\ref{prop:wf} combined with the optimized AN power. It is compared with two equal-power (EP) benchmarks with $p_m=\alpha\Ptot/M$ and $q=(1-\alpha)\Ptot/(N-M)$, where $\alpha$ is either optimized by a one-dimensional search, similar to~\cite{Zhou2010}, or fixed to $0.5$, similar to~\cite{ChenArxiv2026}. For all the schemes, the antenna positions are optimized by Algorithm~\ref{alg:ao}, where the objective of the EP benchmarks retains $[\cdot]^+$ (see Section~\ref{sec:discussion}). The large-scale fading of the LUs is $[\beta_1,\beta_2,\beta_3]=[0,-\varsigma/2,-\varsigma]$~dB, where $\varsigma$ is the fading spread.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:sep_pa}(b) compares the proposed long-term power allocation with two EP benchmarks. The proposed design combines the fixed-AN-power secrecy water-filling solution in Proposition~\ref{prop:wf} with the finite AN-power search. The EP benchmarks use $p_m=\alpha\Ptot/M$ and $q=(1-\alpha)\Ptot/(N-M)$, where $\alpha$ is selected by a finite one-dimensional search, as in the power-splitting approach of~\cite{Zhou2010}, or fixed to $0.5$, as in~\cite{ChenArxiv2026}. Each scheme uses its own power-allocation rule during the position updates, and the EP objective retains $[\cdot]^+$ as discussed in Section~\ref{sec:discussion}. The linear large-scale fading coefficients are $\beta_1=1$, $\beta_2=10^{-\varsigma/20}$, and $\beta_3=10^{-\varsigma/10}$, corresponding to gains of $0$, $-\varsigma/2$, and $-\varsigma$~dB. The fading spread $\varsigma$ is specified in decibels.
```


## Section 5: Simulation Mechanism Rewrites & Code Synchronization

### 5.1 Paper-Code Parameter Synchronization

**Evidence status.** All 21 supplied MATLAB-v7 result files are inspected, including their parameter structures and stored arrays. They contain 100 AoD drops, 5000 evaluation samples in the saved default parameter structure, and three initializations; `fig3_accuracy.m` overrides the actual evaluation sample count to 10000. The manuscript contains no simulation parameter table: compare the paragraphs of `main.tex:618--622` against the code rather than inventing a table discrepancy. No MATLAB/Octave run is claimed. Saved aggregate results establish numerical consistency, but cannot certify every original design's geometry and power feasibility because the sweep files omit those designs. The assertions and persistence changes below close that evidence gap on rerun.

| Quantity or experiment | Paper/source evidence | Code and saved-data evidence | Required synchronization |
|---|---|---|---|
| Defaults | `main.tex:618`: N=8, M=3, A=4λ, Dmin=λ/2; κ=10 dB; β=1; SNR=20 dB; equal noise | `default_params.m:7--34`, `build_scenario.m:9--23`; all applicable MAT files agree | Preserve defaults; state that κ=10 dB means linear κ=10 and β=1 means 0 dB; λ and noise are normalized to one. |
| AoDs and Δ | `main.tex:618` calls Δ angular separation | `gen_scenario.m:14--25` adds Δcosφ and Δsinφ to the elevation and azimuth coordinates | Call Δ a coordinate-angle offset; it is not generally the physical three-dimensional angle between wave vectors. Apply the terminology edit to figure captions and other occurrences. |
| AO/MM/search | `main.tex:620`: 50, 20, 10^-4, 10^-6, δ0=1, grid=0.1λ, Q=41 | `default_params.m:37--49` agrees; bisection uses 60 iterations; `power_opt.m` uses two Q-point grids | Add the 60-iteration bisection and two-stage finite-grid qualification. Do not call q search globally optimal. |
| AS subset ranking | `main.tex:622` attributes Algorithm 1 power allocation to all schemes | `as_select.m:62--68` ranks subsets using `asGrid=21` uniform q values; only the winner receives Q=41 coarse/fine optimization | Disclose the two budgets explicitly; retain the supplied method. Exhaustive subset enumeration does not imply global subset selection under the final refined metric. |
| MC sample count | `main.tex:620` says 5000 for each design | `fig3_accuracy.m:17` uses max(S,10000); saved `prm.S` alone is insufficient to recover this override | Explicitly state 10000 in Fig. 3, 5000 in the other rate evaluations; persist actual count. Fig. 4 is an analytic-objective experiment and has no MC sample count. |
| Convergence initialization | `main.tex:620` universally specifies 2×(N/2) | `fig4_convergence.m:33` uses 2×4 for N=8 and 3×4 for N=12; the N-sweep uses 2×(N/2) | State the Fig. 4 exception; the three-start protocol applies to rate comparisons, not the single-start convergence curves. |
| Fig. 4 stopping | Main text says all cases converge in about 15 iterations | `fig4_convergence.mat.res.itStop` mean=[[16.31,13.02],[15.87,12.51]], maximum=50 | Separate near-stabilization of averaged curves from per-drop stopping. All supplied histories are nondecreasing; no stationary/global optimum follows. |
| AS-region metadata | Default Imax=50 | `extra_as_region.mat.prm.aoMaxIter=60` | This file uses only AS and never invokes AO, so the difference does not affect its rates. Record this provenance; do not report it as a numerical inconsistency. |
| Fig. 6(b) | N=4:2:16, AS only N≤10 | All seven `extra_num_antennas_N*.mat` agree; merged absent AS entries are NaN | Verify merge by scheme names, not column position: the main-scheme order differs between some saved files. Do not interpolate missing AS values. |
| Fig. 7(b) and PA text | Spread0:5:20 at SNR0,10; spread20 across SNR0:5:30 | `extra_pa_spread_0dB.mat`, `extra_pa_spread_10dB.mat`, `fig7_pa_hetero.mat` agree | At SNR0/spread0 and5, optimized EP slightly exceeds the proposed PA in exact-MC ESSR despite a lower surrogate objective. Preserve these crossings and explain them. |
| Robustness | TIN; erroneous Eve directions; independent Eve | `fig5_snr.mat.essr_tin`, `extra_eve_aod_error.mat`, `extra_random_eve_M{1,3}.mat` agree with the quoted rounded values | These are evaluations of the existing statistical-CSI designs; they do not establish robust optimization guarantees. |

**Numerical provenance ledger (supplied results).** At 20 dB, proposed/rate-oriented/AS/FPA/sparse-FPA ESSRs are 20.74973927/18.07564351/17.23780248/15.81796776/17.74577800 bit/s/Hz. The proposed gains are 14.7939% over rate-oriented and 31.1783% over FPA. Their paired gain standard errors are 0.09784183 and 0.16812468 bit/s/Hz, respectively; the proposed ESSR standard error is 0.11309465 bit/s/Hz (0.5450%). The AN fractions are 0.2699375/0.43075/0.4278125/0.47115/0.4020875. Four MAs yield 18.44290328, exceeding the 12-antenna FPA value 17.91955677; eight MAs yield 20.74973927, exceeding the 16-antenna rate-oriented value 20.52219846. These are sample averages under the stated geometry, not universal antenna-count guarantees. Every numerical literal below must be regenerated from the revised result files after an algorithm change; never alter a curve to retain an existing ranking.

#### Ticket 5.1-A: State the experiment-specific evaluation protocol

- **Location:** `manuscript/main.tex:620`; match the complete block once.
- **Reason and consequence:** The default sample count and multi-start initialization do not describe Fig. 3 or Fig. 4. The replacement separates the design objective from exact-SINR evaluation and gives the measured sampling uncertainty.

[ORIGINAL]
```latex
For Algorithm~\ref{alg:ao}, the grid spacing in Stage~1 is $d_{\mathrm g}=\lambda/10$, i.e., less than one third of the shortest phase period in Section~\ref{sec:position}, and the remaining parameters are $\delta_0=1$, $\epsilon_{\mathrm{in}}=10^{-6}$, $I_{\mathrm{in}}=20$, $\epsilon=10^{-4}$, $I_{\max}=50$, and $Q=41$. Algorithm~\ref{alg:ao} is executed from a $2\times(N/2)$ uniform planar array (UPA) with $\lambda/2$ spacing and two sets of random feasible positions, and the best solution is selected. All the results are averaged over $100$ random realizations of the AoDs shared by all the schemes, i.e., the comparisons are paired, and the standard error of the average ESSR of the proposed design at $20$~dB is $0.5\%$ of its value. Since the closed-form approximations are used only for optimization, the ergodic rates of each design are evaluated with the exact SINRs in~\eqref{eq:snr} and~\eqref{eq:sinre} over $5\times10^3$ channel realizations.
```

[REPLACE WITH]
```latex
For Algorithm~\ref{alg:ao}, Stage~1 uses a grid spacing of $d_{\mathrm g}=\lambda/10$. The remaining parameters are $\delta_0=1$, $\epsilon_{\mathrm{in}}=10^{-6}$, $I_{\mathrm{in}}=20$, $\epsilon=10^{-4}$, and $I_{\max}=50$. The AN-power search uses a coarse grid and a local refinement grid, each containing $Q=41$ points, and the water-level bisection uses $60$ iterations. For the rate comparisons, Algorithm~\ref{alg:ao} starts from a $2\times(N/2)$ uniform planar array (UPA) with $\lambda/2$ spacing and two random feasible configurations; the configuration with the largest surrogate objective is retained. Figure~\ref{fig:conv} instead uses a single UPA initialization, with $2\times4$ and $3\times4$ elements for $N=8$ and $N=12$, respectively. All schemes share $100$ AoD realizations. At $20$~dB, the sample standard error of the proposed ESSR is $0.113$~bit/s/Hz, or approximately $0.55\%$ of its mean. The statistical-CSI approximations determine the designs, whereas the reported ergodic rates use the exact SINRs in~\eqref{eq:snr} and~\eqref{eq:sinre}. Each rate evaluation uses $5000$ independent channel realizations, except in Fig.~\ref{fig:acc}, which uses $10000$. The objective values in Fig.~\ref{fig:conv} are evaluated analytically.
```

#### Ticket 5.1-B: Disclose the AS selection and refinement budgets

- **Location:** `manuscript/ma_secrecy_matlab/functions/as_select.m:5`; match the complete block once.
- **Reason and consequence:** The algorithm enumerates every subset but scores them with a reduced AN-power grid. Preserve this implementation and report its numerical-search limitation. A denser or common-budget AS sensitivity experiment is useful if a close AS comparison is central; do not invent that experiment or silently upgrade the baseline.

[ORIGINAL]
```matlab
%   metric is the same as for the proposed design, i.e., the approximate ESSR (P3) with
%   the long-term power allocation of Algorithm 1 (secrecy water-filling for each q on
%   a coarse grid of prm.asGrid points, evaluated for all subsets in a vectorized way).
%   The power allocation of the selected subset is then refined by power_opt.m.
```

[REPLACE WITH]
```matlab
%   metric is the approximate ESSR (P3). Every subset is ranked using secrecy
%   water-filling at prm.asGrid uniformly spaced q values (21 by default).
%   Only the selected subset is refined by power_opt.m, whose coarse and local
%   refinement grids each contain prm.nGrid points (41 by default).
%   Exhaustive subset enumeration does not certify the best subset under the
%   final refined power-search metric or the continuous-q optimum.
```

#### Ticket 5.1-C: Describe the implemented AS benchmark precisely

- **Location:** `manuscript/main.tex:622`; match the complete block once.
- **Reason and consequence:** The original metric hides the reduced AS q-grid budget and conflates physical candidate elements with active RF chains. The replacement preserves the measured method and discloses the resulting baseline limitation.

[ORIGINAL]
```latex
We compare the proposed design with four benchmarks: 1) \textbf{Rate-oriented MA}: The antenna positions maximize the approximate ergodic sum rate of the LUs with equal power, i.e., $\sum_{m=1}^M\log_2(1+\eta_m(\bt)\Ptot/M)$, which ignores Eve~\cite{ZhengTCOM2025}. For a fair comparison, this problem is tackled by the position update in Section~\ref{sec:position} with the same initializations. This benchmark reveals the gain of the secrecy-aware positioning enabled by Proposition~\ref{prop:eve}. 2) \textbf{AS}: Similar to~\cite{ChenArxiv2026}, the BS selects $N$ of $2N$ candidate antennas, which form a UPA with $4$ rows, $N/2$ columns, and $\lambda/2$ spacing, by an exhaustive search over all the $\binom{2N}{N}$ subsets, e.g., $12870$ for $N=8$, where the selection metric is the approximate ESSR in (P3). AS requires no antenna movement but twice as many antennas and an RF switching network. 3) \textbf{Sparse FPA}: A $2\times(N/2)$ UPA spans $\mathcal C$ with spacings $2A/(N-2)$ and $A$ along the $x$- and $y$-axes, respectively. This benchmark has the same aperture as the MAs and thus separates the gain of the optimized positions from that of the large aperture. 4) \textbf{FPA}: The BS adopts the $2\times(N/2)$ UPA with $\lambda/2$ spacing. All the schemes adopt the power allocation in Algorithm~\ref{alg:power}, so that their performance differences are caused only by the antenna positions.
```

[REPLACE WITH]
```latex
We compare the proposed design with four benchmarks. 1) \textbf{Rate-oriented MA}: The antenna positions maximize $\sum_{m=1}^{M}\log_2(1+\eta_m(\bt)\Ptot/M)$, which excludes Eve from the position objective~\cite{ZhengTCOM2025}. The same position-update method and initial configurations are used, after which Algorithm~\ref{alg:power} allocates power. 2) \textbf{AS}: The BS enumerates all $\binom{2N}{N}$ subsets of $N$ antennas from a $4\times(N/2)$ candidate UPA with $\lambda/2$ spacing~\cite{ChenArxiv2026}. Each subset is scored by the approximate ESSR using secrecy water-filling at $21$ uniformly spaced AN-power values. Algorithm~\ref{alg:power} then refines the power allocation only for the selected subset using its two $41$-point grids. This procedure searches all subsets under the coarse metric; it does not certify the best subset under the refined metric or the optimum over continuous AN power. For $N=8$, there are $12870$ subsets. 3) \textbf{Sparse FPA}: A $2\times(N/2)$ UPA spans $\mathcal C$, with spacings $2A/(N-2)$ and $A$ along the $x$- and $y$-axes. 4) \textbf{FPA}: A $2\times(N/2)$ UPA has $\lambda/2$ spacing. All schemes use the same final power-allocation procedure after their positions or antenna subsets are selected. The numerical position and subset searches have the budgets stated above. The AS benchmark uses $2N$ physical candidate elements and $N$ selected transmission branches.
```

#### Ticket 5.1-D: Enforce geometry and power feasibility and retain mechanism statistics

- **Location:** `manuscript/ma_secrecy_matlab/functions/evaluate_schemes.m:72`; match the complete block once.
- **Reason and consequence:** Current sweep files cannot establish per-drop feasibility and discard the exact-MC leakage/AN moments already computed by mc_rates. These guards fail rather than silently plotting an invalid design; they do not impose unproved approximation-accuracy thresholds.

[ORIGINAL]
```matlab
    [Rb, Re, essr, st] = mc_rates(scTrue, T, p, q, prm.S, seed);
    r.essr = essr;  r.Rb = Rb;  r.Re = Re;
```

[REPLACE WITH]
```matlab
    % Reject invalid designs before exact-SINR evaluation.
    assert(isequal(size(T), [sc.N, 2]) && all(isfinite(T(:))) && isreal(T));
    assert(all(abs(T(:)) <= sc.A/2 + 1e-8));
    D2 = (T(:,1) - T(:,1).').^2 + (T(:,2) - T(:,2).').^2;
    D2(1:sc.N+1:end) = inf;
    assert(all(D2(:) >= sc.Dmin^2 - 1e-8));
    assert(numel(p) == sc.M && all(isfinite(p(:))) && all(p(:) >= -1e-10));
    assert(isscalar(q) && isfinite(q) && q >= -1e-10);
    assert(sum(p) + (sc.N - sc.M)*q <= sc.P + 1e-8*max(1, sc.P));
    [Rb, Re, essr, st] = mc_rates(scTrue, T, p, q, prm.S, seed);
    assert(all(isfinite([Rb(:); Re(:); essr; st.an])));
    assert(all(Rb >= -1e-10) && all(Re >= -1e-10) && st.an >= -1e-8);
    r = struct();
    r.essr = essr;  r.Rb = Rb;  r.Re = Re;
    r.leak = st.leak; r.an = st.an;
    r.evaluationSamples = prm.S;
    r.seed = seed;
```

#### Ticket 5.1-E1: Preserve evaluation provenance

- **Location:** `manuscript/ma_secrecy_matlab/functions/sweep_schemes.m:18`; match the complete block once.
- **Reason and consequence:** Persist actual designs and empirical leakage/AN moments so the physical interpretation and feasibility checks can be reproduced. A filename plus default prm is insufficient to prove the evaluated configuration.

[ORIGINAL]
```matlab
res.essr_tin = zeros(numel(values), K);
for i = 1:numel(values)
```

[REPLACE WITH]
```matlab
res.essr_tin = zeros(numel(values), K);
res.designs = cell(numel(values), K, prm.numDrops);
res.leak = zeros(numel(values), K, prm.M);
res.an = zeros(numel(values), K);
res.parameterField = field;
res.evaluationSamples = prm.S;
res.algorithmVersion = 'revision-v1';
for i = 1:numel(values)
```

#### Ticket 5.1-E2: Save the per-drop evidence

- **Location:** `manuscript/ma_secrecy_matlab/functions/sweep_schemes.m:37`; match the complete block once.
- **Reason and consequence:** The saved Monte Carlo moments directly test claims about leakage suppression and AN reception, instead of inferring every internal mechanism from the ESSR curve.

[ORIGINAL]
```matlab
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
```

[REPLACE WITH]
```matlab
            res.F(i, k)      = res.F(i, k)      + r.F/prm.numDrops;
            res.designs{i, k, dI} = struct('T', r.T, 'p', r.p, 'q', r.q, ...
                'hist', r.hist, 'seed', r.seed, 'evaluationSamples', r.evaluationSamples, ...
                'Rb', r.Rb, 'Re', r.Re, 'leak', r.leak, 'an', r.an);
            res.leak(i, k, :) = res.leak(i, k, :) + reshape(r.leak, 1, 1, prm.M)/prm.numDrops;
            res.an(i, k) = res.an(i, k) + r.an/prm.numDrops;
```

#### Ticket 5.1-F: Record the actual Fig. 3 sample count

- **Location:** `manuscript/ma_secrecy_matlab/fig3_accuracy.m:15`; match the complete block once.
- **Reason and consequence:** The saved prm.S=5000 does not encode the actual 10000-sample accuracy experiment.

[ORIGINAL]
```matlab
S = max(prm.S, 10000);
res.vsP = zeros(numel(res.Pvec), 6);
```

[REPLACE WITH]
```matlab
S = max(prm.S, 10000);
res.evaluationSamples = S;
res.numDrops = prm.numDrops;
res.algorithmVersion = 'revision-v1';
res.vsP = zeros(numel(res.Pvec), 6);
```

#### Ticket 5.1-G: Make the MM-only branch explicit

- **Location:** `manuscript/ma_secrecy_matlab/functions/position_sweep.m:23`; match the complete block once.
- **Reason and consequence:** The convergence ablation intentionally sets gridStep=0. Avoid constructing a zero-increment colon expression before the disabling guard; verify both full and MM-only branches in the actual MATLAB/Octave runtime. No failure of the supplied Octave run is inferred from this source pattern.

[ORIGINAL]
```matlab
xs = -sc.A/2 : prm.gridStep : sc.A/2;
[X, Y] = meshgrid(xs, xs);
G = [X(:).'; Y(:).'];                                  % grid over C, 2 x K
```

[REPLACE WITH]
```matlab
assert(isscalar(prm.gridStep) && isfinite(prm.gridStep) && prm.gridStep >= 0);
G = zeros(2, 0);
if prm.gridStep > 0
    xs = -sc.A/2 : prm.gridStep : sc.A/2;
    [X, Y] = meshgrid(xs, xs);
    G = [X(:).'; Y(:).'];                              % grid over C, 2 x K
end
```

#### Ticket 5.1-H1: Retain provenance when merging the N sweep

- **Location:** `manuscript/ma_secrecy_matlab/extra_num_antennas.m:30`; match the complete block once.
- **Reason and consequence:** The original merge would discard the newly persisted per-drop evidence. Missing AS values must remain absent, not become zeros.

[ORIGINAL]
```matlab
res.essrDrops = nan(I, K, prm.numDrops);
for i = 1:I
```

[REPLACE WITH]
```matlab
res.essrDrops = nan(I, K, prm.numDrops);
res.designs = cell(I, K, prm.numDrops);
res.leak = nan(I, K, prm.M);
res.an = nan(I, K);
res.parameterField = 'N';
res.evaluationSamples = prm.S;
res.algorithmVersion = 'revision-v1';
for i = 1:I
```

#### Ticket 5.1-H2: Reject a merge that mixes old and new provenance

- **Location:** `manuscript/ma_secrecy_matlab/extra_num_antennas.m:41`; match the complete block once.
- **Reason and consequence:** A mixture of historical and revised result files cannot validate the revised per-drop feasibility and mechanism evidence.

[ORIGINAL]
```matlab
    res.essrDrops(i, k, :) = S.r.essrDrops;
```

[REPLACE WITH]
```matlab
    res.essrDrops(i, k, :) = S.r.essrDrops;
    assert(isfield(S.r, 'designs') && isfield(S.r, 'leak') && isfield(S.r, 'an'), ...
        'Regenerate this N result with the revised provenance fields before merging');
    assert(S.r.evaluationSamples == prm.S && S.pr.numDrops == prm.numDrops);
    res.designs(i, k, :) = S.r.designs;
    res.leak(i, k, :) = S.r.leak;
    res.an(i, k) = S.r.an;
```

#### Ticket 5.1-I: Remove the README claim of automatic approximation fairness

- **Location:** `manuscript/ma_secrecy_matlab/readme.tex:40`; match the complete block once.
- **Reason and consequence:** Exact-SINR evaluation removes direct use of approximate rates in the reported metric. It does not eliminate surrogate selection error or guarantee ranking fidelity; the EP crossings provide a concrete counterexample.

[ORIGINAL]
```latex
\item 性能评估：所有方案都只用统计 CSI（闭式近似）做优化，然后在真实信道样本上用\textbf{精确的} ZF 预编码 + 零空间 AN（式 (12)、(13)）做蒙特卡洛评估，因此近似误差不会“美化”结果。
```

[REPLACE WITH]
```latex
\item 性能评估：所有方案都只用统计 CSI（闭式近似）做优化，然后在真实信道样本上用\textbf{精确的} ZF 预编码 + 零空间 AN（式 (12)、(13)）做蒙特卡洛评估。这样可以避免直接用近似速率报告性能，但近似目标仍可能选出真实 ESSR 较低的设计，因此不能据此保证近似目标与真实 ESSR 的方案排序一致。
```

#### Ticket 5.1-J: State normalization and the coordinate-angle model

- **Location:** `manuscript/main.tex:618`; match the complete block once.
- **Reason and consequence:** The original normalized-LoS-correlation bound 0.94 is not stored per drop, and Delta is not a coordinate-invariant separation angle. Preserve the actual sampling model without claiming an unverified deterministic correlation threshold.

[ORIGINAL]
```latex
Unless otherwise specified, we set $N=8$, $M=3$, $A=4\lambda$, $\Dmin=\lambda/2$, $\kappa_m=\kappa_e=10$~dB, $\beta_m=\beta_e=1$, and $\sigma_m^2=\sigma_e^2=\sigma^2$, such that $\Ptot/\sigma^2$ is the transmit SNR, which is $20$~dB by default. The elevation and azimuth AoDs of the LUs are independently and uniformly distributed within $[-\pi/3,\pi/3]$. Similar to~\cite{ChenArxiv2026}, Eve is located in a direction close to that of LU~$1$ to model the challenging case in Section~\ref{sec:intro}. Specifically, its AoDs are $\theta_e=\theta_1+\Delta\cos\tilde\phi$ and $\phi_e=\phi_1+\Delta\sin\tilde\phi$, i.e., they deviate from those of LU~$1$ by the angular separation $\Delta$ in the direction specified by $\tilde\phi$, which is uniformly distributed over $[0,2\pi)$. By default, $\Delta=0.1$~rad, for which the normalized LoS correlation $|\hb_1^H(\bt)\gb(\bt)|/N$ between Eve and LU~$1$ exceeds $0.94$ for the FPA, i.e., Eve lies well within the main lobe of the beam steered toward LU~$1$. The case where the AoDs of Eve are independent of those of the LUs is considered in Section~\ref{sec:sim_rob}.
```

[REPLACE WITH]
```latex
Unless otherwise specified, $N=8$, $M=3$, $A=4\lambda$, $\Dmin=\lambda/2$, $\kappa_m=\kappa_e=10$~dB, $\beta_m=\beta_e=1$, and $\sigma_m^2=\sigma_e^2=\sigma^2$. The default transmit SNR $\Ptot/\sigma^2$ is $20$~dB. The implementation normalizes $\lambda=1$ and $\sigma^2=1$; the Rician factors are converted from dB to linear values before channel generation. The elevation and azimuth AoDs of the LUs are independently uniform on $[-\pi/3,\pi/3]$. To examine a near-aligned eavesdropper~\cite{ChenArxiv2026}, we set $\theta_e=\theta_1+\Delta\cos\tilde\phi$ and $\phi_e=\phi_1+\Delta\sin\tilde\phi$, where $\tilde\phi$ is uniform on $[0,2\pi)$. Here, $\Delta$ denotes an offset in the elevation--azimuth coordinates rather than the physical three-dimensional angle between propagation directions. Its default value is $0.1$~rad. For a compact FPA, this setting produces strongly correlated LoS responses from Eve and LU~$1$. Independent Eve and LU directions are considered in Section~\ref{sec:sim_rob}.
```

#### Ticket 5.1-K1: Align the simulation heading with the sampled parameter

- **Location:** `manuscript/main.tex:675`; match the complete block once.
- **Reason and consequence:** The subsection studies a coordinate-angle offset, not a true geodesic or wave-vector angle.

[ORIGINAL]
```latex
\subsection{Impact of the Angular Separation}\label{sec:sim_sep}
```

[REPLACE WITH]
```latex
\subsection{Impact of the Coordinate-Angle Offset}\label{sec:sim_sep}
```

#### Ticket 5.1-K2: Correct the Fig. 7 parameter description

- **Location:** `manuscript/main.tex:681`; match the complete block once.
- **Reason and consequence:** The caption must identify the same coordinate parameter as the generator and setup.

[ORIGINAL]
```latex
\caption{(a) ESSR versus the angular separation $\Delta$ between Eve and LU~$1$ for $M=3$ and $M=1$. (b) ESSR of the proposed power allocation (PA) and two equal-power (EP) benchmarks versus the fading spread $\varsigma$.}
```

[REPLACE WITH]
```latex
\caption{(a) ESSR versus the coordinate-angle offset $\Delta$ between Eve and LU~$1$ for $M=3$ and $M=1$. (b) ESSR of the proposed power allocation (PA) and two equal-power (EP) benchmarks versus the fading spread $\varsigma$.}
```

**Acceptance and regeneration for Section 5.1.** First archive the supplied results read-only, with checksums and their parameter structures; run revised experiments in a distinct results directory. `check_implementation` must produce passing quantitative checks for gradients, rank-one objectives, KKT residuals, power budgets, and every individual AO trajectory; a printed message alone is not a passing assertion. Exercise Q=2, 40, and 41 and confirm the full and MM-only branches run. At the default odd Q=41, the candidate-retention repair in Section 2 should preserve the selected fine-grid solution and tie rule; verify this before treating historical outputs as unchanged. The code changes above add guards and provenance rather than changing the default search rules. Full numerical regeneration is required only when algorithmic outputs change, or to obtain missing design/feasibility evidence; do not claim a completed rerun until it actually succeeds. Validate every saved position and power against the original constraints, and regenerate plots from `.mat` arrays using scheme-name lookup. If any output changes, recompute every affected percentage, standard error, rounded rate, and cross-scheme antenna comparison appearing anywhere in Abstract, Introduction, Simulation Results, or Conclusion. Report the derivative and moment-approximation errors without imposing an unproved universal tolerance. Preserve the order of expectation and positive-part operations used in the manuscript ESSR definition: `sum(max(mean(Rb_samples)-mean(Re_samples),0))`; do not substitute the mean of instantaneous positive differences.

### 5.2 Physical Mechanism Analysis Rewrites

The following numerical replacements are supported by the supplied arrays. If revised numerical outputs change, replace numerical literals using the regenerated measurements and adjust any ordering or trend that changes. Keep the mathematical qualifications even when the new curves have the same ranking.

#### Ticket 5.2-A: Separate empirical accuracy from a mathematical secrecy bound

- **Location:** `manuscript/main.tex:634`; match the complete block once.
- **Reason and consequence:** An approximate LU bound plus an approximate Eve rate does not imply a lower bound on ESSR. The old universal claim that the gap is smaller than all gains is false for close comparisons and especially for low N. The saved Fig. 3 data quantify aggregate error only for the selected proposed configurations.

[ORIGINAL]
```latex
Fig.~\ref{fig:acc} evaluates the accuracy of Lemma~\ref{lem:lu} and Proposition~\ref{prop:eve} at the designs obtained by Algorithm~\ref{alg:ao}. Proposition~\ref{prop:eve} closely matches the Monte Carlo results over the entire ranges of the SNR and the Rician factor, indicating that it accurately captures the LoS correlation between Eve and the LUs. In contrast, Lemma~\ref{lem:lu} underestimates the ergodic sum rate of the LUs, and the gap grows with the Rician factor. The reason is that, besides Jensen's inequality, the central Wishart approximation in Lemma~\ref{lem:lu} is exact for Rayleigh fading but overestimates $\E\{[(\bH^H(\bt)\bH(\bt))^{-1}]_{m,m}\}$ by a factor approaching $N/(N-M)$ as the LoS components dominate. Hence, the approximate ESSR in~\eqref{eq:esrapprox} is a conservative estimate of the actual ESSR. Nevertheless, this gap is similar for all the schemes and smaller than the gains of the proposed design, so that the approximation remains a suitable design objective.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:acc} compares the approximate and Monte Carlo rates at the configurations selected by Algorithm~\ref{alg:ao}. Over the tested SNRs and Rician factors, the largest absolute differences between the approximate and simulated wiretap sum rates are $0.053$ and $0.013$~bit/s/Hz, respectively. These comparisons support the approximation in the tested configurations; they do not establish a bound for arbitrary positions or channel statistics. Lemma~\ref{lem:lu} underestimates the simulated LU sum rate, with a larger discrepancy as the LoS component becomes stronger. Its derivation combines Jensen's inequality with a central-Wishart replacement, whose inverse-moment expression is exact for Rayleigh channels but is generally approximate for Rician channels. Consequently, the resulting ESSR is a surrogate objective rather than a certified lower bound on the true ESSR. At $20$~dB, the proposed configuration has a Monte Carlo ESSR of $20.75$~bit/s/Hz and a surrogate value of $18.98$~bit/s/Hz. Approximation errors can change the ranking of close designs; the reported comparisons therefore use the exact-SINR Monte Carlo rates.
```

#### Ticket 5.2-B: Report measured convergence without global-basin claims

- **Location:** `manuscript/main.tex:645`; match the complete block once.
- **Reason and consequence:** Saved individual runs need up to 50 iterations. A finite-grid best candidate cannot be called the best basin over the continuous region; objective convergence and stationarity are different claims.

[ORIGINAL]
```latex
Fig.~\ref{fig:conv} shows the objective value of (P3) versus the number of iterations of Algorithm~\ref{alg:ao}, which is run without the stopping criterion. For all the settings, the objective value increases monotonically and converges within about $15$ iterations. The fast convergence is due to the global search in Stage~1, which moves each MA directly to the best basin of $F(\bt_n)$ instead of letting it traverse the movable region through local updates. In contrast, with only the MM updates, the objective value increases much more slowly and remains lower, since the MAs are trapped in the local maxima near their initial positions.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:conv} reports the objective of (P3), with the outer stopping test disabled to retain $50$ iterations. Every stored trajectory is nondecreasing, consistent with the acceptance tests for the position and power updates. The averaged curves are close to their final values after approximately $15$ iterations: their remaining increases are between $0.024$ and $0.034$~bit/s/Hz. This observation does not imply that every realization meets the default stopping test within $15$ iterations. The average stopping indices are $16.31$ and $13.02$ for $N=8$ at $10$ and $20$~dB, and $15.87$ and $12.51$ for $N=12$; some realizations reach the $50$-iteration limit. The feasible-grid stage examines positions beyond the neighborhood accessible to a local MM update. It therefore provides a higher initial improvement in these experiments, while the MM-only variant attains a lower objective. A finite spatial grid does not certify the best continuous attraction region, and monotonic objective convergence does not by itself establish stationarity.
```

#### Ticket 5.2-C: Explain SNR gains through the actual surrogate coefficients

- **Location:** `manuscript/main.tex:657`; match the complete block once.
- **Reason and consequence:** Do not infer that all c_m decrease and d increases simultaneously from ESSR alone. The empirical 20dB gains are verified; remove unqualified highest-over-entire-range language because full and no-AN are numerically almost equal at 0dB and finite-start solutions can cross.

[ORIGINAL]
```latex
Fig.~\ref{fig:snr}(a) shows that the proposed design achieves the highest ESSR over the entire SNR range, e.g., about $31\%$ higher than that of the FPA at $20$~dB. Although the rate-oriented MA exploits the same movable region, its gain over the FPA is less than half of that of the proposed design. The reason is that the rate-oriented positions only decorrelate the LUs, whereas the proposed positions additionally reduce the information leakage and increase the AN received by Eve (see Remark~\ref{rem:mech}). AS achieves an even smaller gain, because its $2N$ candidates form a compact array, whose spatial resolution is insufficient to decorrelate the LoS components of Eve and LU~$1$. The sparse FPA has the same aperture as the MAs but also achieves less than half of the gain of the proposed design over the FPA, because its fixed positions cannot adapt the LoS correlations to the AoDs of the LUs and Eve. Hence, the secrecy gain of the MAs results mainly from the optimized positions rather than from the large aperture. Moreover, the absolute ESSR gains of the proposed design approach constants at high SNR, since the antenna positions improve the constant term rather than the slope of the ESSR (see Remark~\ref{rem:highsnr}). In contrast, without AN, i.e., with $q=0$ in Algorithm~\ref{alg:ao}, the ESSR of the proposed design saturates at high SNR, because the SINRs of the LUs and Eve then grow at the same rate with the transmit power~\cite{Goel2008}.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:snr}(a) compares the exact-SINR Monte Carlo ESSRs. At $20$~dB, the proposed, rate-oriented, and compact-FPA designs achieve $20.75$, $18.08$, and $15.82$~bit/s/Hz, respectively. The proposed gain is $14.8\%$ over the rate-oriented design and $31.2\%$ over the compact FPA. The rate-oriented objective improves the legitimate-channel geometry through $\eta_m(\bt)$, whereas the secrecy objective also accounts for the leakage coefficients $c_m(\bt)$ and the AN coefficient $d(\bt)$. Position changes can trade these quantities against one another; the formulation does not require every user's leakage to decrease at every iteration. The sparse FPA achieves $17.75$~bit/s/Hz at the same aperture, showing that aperture alone does not reproduce the gain of the adaptive positions in this setting. The compact AS candidates provide a different, discretely constrained set of spatial configurations. At high SNR, the simulated absolute gains change slowly, consistent with the constant-offset comparison in Remark~\ref{rem:highsnr} under its stated assumptions. With $q=0$, the worst-case Eve model yields a secrecy-rate ceiling because the desired and leakage signal powers both scale with the transmit power~\cite{Goel2008}.
```

#### Ticket 5.2-D: Quantify AN use and qualify the design criterion

- **Location:** `manuscript/main.tex:659`; match the complete block once.
- **Reason and consequence:** The reported q is surrogate-optimal over finite candidates, rather than the minimum AN power needed for a true-ESSR guarantee. The physical dependence must be tied to the actual numerator/denominator.

[ORIGINAL]
```latex
Fig.~\ref{fig:snr}(b) shows that the optimized AN power fraction increases with the SNR and saturates, as predicted by~\eqref{eq:alphastar}. The proposed design requires much less AN power than all the benchmarks, whose AN power fractions are comparable to that of the FPA. This result verifies the AN-saving effect in Remark~\ref{rem:highsnr}: since the proposed positions reduce the information leakage and increase the AN received by Eve, less AN suffices, leaving more power for the confidential signals.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:snr}(b) reports the AN power selected by the surrogate optimization, with each resulting design evaluated as in Fig.~\ref{fig:snr}(a). At $20$~dB, the proposed AN fraction is $0.270$, compared with $0.471$ for the compact FPA and $0.431$ for the rate-oriented MA. Thus, the proposed design allocates approximately $42.7\%$ less power to AN than the compact FPA at this SNR. In Proposition~\ref{prop:eve}, the wiretap rate decreases when the leakage coefficient falls or the effective AN denominator increases. Spatial control therefore changes the tradeoff between confidential-signal power and AN power. The observed fractions level off at high SNR, consistent with~\eqref{eq:alphastar} within the assumptions of Remark~\ref{rem:highsnr}. These fractions are selected by the approximate objective and are not certified minimizers of AN power for a prescribed true ESSR.
```

#### Ticket 5.2-E: Distinguish feasible-set expansion from optimizer guarantees

- **Location:** `manuscript/main.tex:671`; match the complete block once.
- **Reason and consequence:** The original explains all improvement as decorrelation and equates candidate-element counts with transmission hardware. The replacement states the geometric degrees of freedom, the statistical surrogate tradeoff, and the exact smallest-region coincidence.

[ORIGINAL]
```latex
Fig.~\ref{fig:region}(a) shows the ESSR versus the side length $A$ of the movable region, where we also consider AS with region-wide candidates, i.e., a $4\times4$ candidate UPA spanning $\mathcal C$, whereas the FPA and AS with the compact candidate array do not depend on $A$. The gain of the proposed design grows with $A$, because a larger region provides more spatial degrees of freedom for decorrelating the LoS components of Eve and the LUs. In contrast, the ESSRs of the rate-oriented MA and the sparse FPA increase much more slowly, since the former exploits the enlarged region only to decorrelate the LUs, and the latter cannot adapt its positions to the AoDs. AS with region-wide candidates also benefits from the enlarged aperture and its Eve-aware selection metric, but the proposed design outperforms it with half the number of antennas, because the MAs can be placed at arbitrary positions in $\mathcal C$ rather than at fixed candidate positions. Only for the smallest region, where the candidate array covers the entire region, does AS perform comparably to the proposed design.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:region}(a) varies $A$ while retaining $N=8$, $M=3$, and $\Dmin=\lambda/2$. It also includes AS with $16$ candidates on a $4\times4$ UPA spanning $\mathcal C$. A larger region expands the phase differences available for controlling the weighted LoS Gram matrix and its correlation with Eve. The secrecy-aware optimizer can therefore trade legitimate-channel conditioning against leakage suppression and AN reception. The rate-oriented design uses the expanded region only through its LU-rate objective, while the sparse FPA samples a fixed geometry for each $A$. The proposed ESSR increases from $17.27$ to $21.98$~bit/s/Hz over $A/\lambda=1.5$ to $6$ in this experiment. The feasible continuous-position set expands with $A$, but a finite-start algorithm need not produce a monotone curve for every realization. AS with region-wide candidates also benefits from its larger candidate aperture; its comparison with the proposed design concerns continuous versus discrete positioning and $N$ active elements versus $2N$ physical candidate elements. At $A=1.5\lambda$, the compact and region-wide candidate UPAs coincide.
```

#### Ticket 5.2-F: Qualify antenna-count and grating-lobe interpretations

- **Location:** `manuscript/main.tex:673`; match the complete block once.
- **Reason and consequence:** A larger N changes AN dimension, array gain and (for compact FPA) aperture simultaneously. Grating-lobe suppression depends on spacing and direction, rather than an unconditional effect of antenna count.

[ORIGINAL]
```latex
Fig.~\ref{fig:region}(b) shows the ESSR versus the number of MAs $N$, where AS is shown only for $N\le10$, because the number of subsets in its exhaustive search grows exponentially with $N$. All the schemes benefit from more antennas, which provide a larger array gain and more dimensions for the AN. The gain of the proposed design over the FPA decreases with $N$, because the aperture of the FPA grows with $N$, so that the FPA can better separate Eve from LU~$1$ even without position optimization. Nevertheless, the proposed design with $N=4$ MAs outperforms the FPA with $N=12$ antennas, and that with $N=8$ MAs outperforms the rate-oriented MA with $N=16$ MAs, i.e., the secrecy-aware positioning can substantially reduce the number of antennas and RF chains required for a target ESSR. Moreover, the sparse FPA, whose grating lobes are strong for small $N$, outperforms the rate-oriented MA for $N\ge12$, because more antennas in $\mathcal C$ suppress them.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:region}(b) varies $N$ at $M=3$ and $A=4\lambda$. AS is evaluated only for $N\le10$ because the number of candidate subsets grows as $\binom{2N}{N}$. Increasing $N$ improves the legitimate-channel array gain and enlarges the null space available for AN. The compact FPA aperture also increases with $N$, so this comparison changes both the number of elements and its angular response. In the supplied data, four optimized MAs achieve $18.44$~bit/s/Hz, exceeding the $17.92$~bit/s/Hz of a compact FPA with $12$ antennas. Eight optimized MAs achieve $20.75$~bit/s/Hz, compared with $20.52$~bit/s/Hz for the rate-oriented design with $16$ MAs. These comparisons identify attainable average rates for the specified geometry rather than a universal antenna-count reduction. For the sparse FPA, increasing $N$ reduces the horizontal element spacing at fixed aperture, changing its sidelobe and grating-lobe structure. This effect can improve separation from Eve without establishing uniform sidelobe suppression for every AoD.
```

#### Ticket 5.2-G: Correct angular meaning and single-user interpretation

- **Location:** `manuscript/main.tex:685`; match the complete block once.
- **Reason and consequence:** The code offsets coordinate angles, not the physical angle between propagation directions. Section2 qualifies the single-user moment formulas; the simulation paragraph must not restore their false exact-identity interpretation.

[ORIGINAL]
```latex
Fig.~\ref{fig:sep_pa}(a) shows the ESSR versus the angular separation $\Delta$ for $M=3$ and $M=1$. For $M=3$, all the schemes benefit from a larger $\Delta$, because Eve becomes more separable from LU~$1$. When Eve is almost aligned with LU~$1$, the proposed design outperforms the rate-oriented MA only slightly, because even an aperture of $4\lambda$ can hardly decorrelate their LoS components. As $\Delta$ increases, the gain of the proposed design first increases and then decreases, because Eve eventually becomes separable even with Eve-unaware positions. For $M=1$, the rate-oriented MA coincides with the FPA, since the ergodic rate of the LU does not depend on the antenna positions (see Remark~\ref{rem:single}). In contrast, the proposed design significantly improves the ergodic secrecy rate by reducing the LoS correlation $|\hb_1^H(\bt)\gb(\bt)|^2$ in~\eqref{eq:c1} and~\eqref{eq:d1}. This result confirms that the MAs enhance secrecy even for a single LU. The sparse FPA also benefits from its large aperture for $M=1$, but the proposed design achieves a further gain by adapting the positions to the AoDs of the LU and Eve.
```

[REPLACE WITH]
```latex
Figure~\ref{fig:sep_pa}(a) varies the coordinate-angle offset $\Delta$ between Eve and LU~$1$. This parameter is the Euclidean offset in the elevation--azimuth coordinates used in Section~\ref{sec:sim_setup}; the corresponding physical separation also depends on the nominal direction. For $M=3$, the proposed and rate-oriented ESSRs are close at $\Delta=0.02$~rad, since the finite aperture limits the phase differences between nearly aligned LoS components. Their gap grows at intermediate offsets and narrows when the rate-oriented positions already provide sufficient separation. For $M=1$, the LU's marginal ergodic rate is independent of position, so the rate-oriented implementation retains the compact UPA. Secrecy-aware positioning still changes the LU--Eve LoS correlation and hence the approximate leakage and AN terms. At $\Delta=0.1$~rad, the proposed single-user ESSR is $7.48$~bit/s/Hz, compared with $4.22$~bit/s/Hz for the compact FPA and $6.45$~bit/s/Hz for the sparse FPA. These rates use exact-SINR evaluation and do not require the finite-Rician moment approximations to satisfy an exact complementary-projection identity.
```

#### Ticket 5.2-H: Preserve measured EP crossings and explain surrogate mismatch

- **Location:** `manuscript/main.tex:691`; match the complete block once.
- **Reason and consequence:** Exact-MC evaluation can reverse close surrogate rankings. The old narrative suppresses this observed exception and overstates high-SNR equal-power conclusions.

[ORIGINAL]
```latex
EP with optimized $\alpha$ performs comparably to the proposed power allocation for small fading spreads, because the LUs then have similar effective channel gains, which are further balanced by the optimized positions. In contrast, the gain of the proposed power allocation increases with $\varsigma$, since it switches off or reduces the power of the LUs whose effective channel gains are comparable to that of Eve (Proposition~\ref{prop:wf}). This gain decreases with the SNR, e.g., from $40\%$ at $0$~dB to $14\%$ at $10$~dB and to below $1\%$ at $20$~dB for $\varsigma=20$~dB. The reason is that, at high SNR, all the LUs achieve positive secrecy rates and nearly equal powers become optimal, similar to classic water-filling. EP with $\alpha=0.5$ performs worst in all the cases, especially at $0$~dB, where little or no AN is needed. Hence, both components of the long-term power allocation are important: the information--AN power splitting improves the ESSR in all cases, and the per-user power allocation further benefits heterogeneous LUs at low-to-moderate SNR.
```

[REPLACE WITH]
```latex
At $0$~dB and fading spreads of $0$ and $5$~dB, EP with optimized $\alpha$ attains Monte Carlo ESSRs of $4.425$ and $2.944$~bit/s/Hz, slightly above the proposed PA values of $4.379$ and $2.884$~bit/s/Hz. Its surrogate objectives are lower in both cases. The power-allocation optimum for fixed positions therefore does not imply dominance in the true ESSR after finite-start position optimization. At a $20$-dB fading spread, the proposed PA exceeds optimized EP by $40.3\%$, $13.9\%$, and $0.78\%$ at SNRs of $0$, $10$, and $20$~dB, respectively. The secrecy water-filling rule assigns no power when a user's surrogate legitimate gain does not exceed its effective leakage gain, and reallocates power among the remaining users. This adaptation is useful when the effective gains differ substantially. The smaller measured gains at higher SNRs depend on the tested effective gains and optimized power splits. The equal-user-power expansion in Remark~\ref{rem:highsnr} does not establish that equal user powers are generally asymptotically optimal. EP with $\alpha=0.5$ also expends power on AN at low SNR when the optimized split can select little or no AN. The experiment thus distinguishes the benefit of AN-power selection from that of per-user power adaptation without asserting universal true-ESSR superiority.
```

#### Ticket 5.2-I: Restrict the TIN claim to its actual evidence

- **Location:** `manuscript/main.tex:695`; match the complete block once.
- **Reason and consequence:** The 1.6 maximum excludes the no-AN benchmark, which differs by over13bit/s/Hz at30dB. AN indispensability is conditional on the secrecy model and target, not a universal consequence of these curves.

[ORIGINAL]
```latex
Finally, we examine whether the gain of the proposed design relies on the worst-case eavesdropper model, the accurate statistical CSI of Eve, and the location of Eve close to an LU. First, we evaluate the designs against an Eve that treats the signals of the other LUs as interference (TIN), i.e., whose SINR has the additional term $\sum_{i\neq m}p_i|\bg^H(\bt)\wb_i|^2$ in the denominator of~\eqref{eq:sinre}. For $\Ptot/\sigma^2\in\{10,20,30\}$~dB, the ESSRs of all the schemes increase by at most $1.6$~bps/Hz, and the proposed design still achieves the highest ESSR, i.e., its gain is not an artifact of the worst-case model. Moreover, the proposed design benefits the least from the TIN Eve, e.g., by $0.5$ versus $1.5$~bps/Hz for the rate-oriented MA at $20$~dB, because its positions reduce the leakage of all the LUs and thus also the inter-user interference received by Eve. Without AN, however, its ESSR against the TIN Eve keeps increasing with the SNR, e.g., to $27.1$~bps/Hz at $30$~dB, because the inter-user interference then acts as AN, whereas it saturates at about $14$~bps/Hz under the worst-case model (see Fig.~\ref{fig:snr}(a)). Hence, the AN is indispensable for a secrecy guarantee that does not rely on the decoding capability of Eve.
```

[REPLACE WITH]
```latex
We first evaluate the same designs against an Eve that decodes each stream by treating interference as noise (TIN), adding $\sum_{i\ne m}p_i|\bg^H(\bt)\wb_i|^2$ to the denominator of~\eqref{eq:sinre}. For the five AN-enabled designs at SNRs of $10$, $20$, and $30$~dB, the ESSR increases by at most $1.6$~bit/s/Hz. At $20$~dB, the increases are $0.49$ and $1.47$~bit/s/Hz for the proposed and rate-oriented designs. The smaller increase for the proposed design is consistent with lower received inter-user leakage, which also reduces the interference protecting a stream against a TIN receiver. For the no-AN design at $30$~dB, the TIN and worst-case ESSRs are $27.14$ and $13.85$~bit/s/Hz, respectively. Inter-user interference can therefore protect the evaluated TIN receiver, whereas the worst-case model excludes that protection. The need for AN at high SNR follows from the specified eavesdropper model and does not establish that every secrecy target requires AN.
```

#### Ticket 5.2-J: Qualify statistical-CSI robustness

- **Location:** `manuscript/main.tex:697`; match the complete block once.
- **Reason and consequence:** Smoothness does not bound performance loss after nonconvex optimization. Preserve the measured rates and identify exactly which design components depend on Eve CSI.

[ORIGINAL]
```latex
Second, all the schemes are designed with AoDs of Eve that deviate from the true ones by $\varepsilon_{\mathrm e}$ in a random direction, as modeled for $\Delta$ in Section~\ref{sec:sim_setup}, and are evaluated with the true AoDs. The ESSRs of the benchmarks hardly change, because only their power allocation and the antenna subset of AS depend on the AoDs of Eve. In contrast, the ESSR of the proposed design decreases with $\varepsilon_{\mathrm e}$, because its positions are tailored to the AoDs of Eve. Nevertheless, at $20$~dB, it decreases by only $3\%$ for $\varepsilon_{\mathrm e}=0.05$~rad and still exceeds those of all benchmarks for $\varepsilon_{\mathrm e}=\Delta=0.1$~rad ($18.73$ versus at most $17.93$~bps/Hz). This robustness is due to the smooth variation of the LoS correlations with the AoDs of Eve.
```

[REPLACE WITH]
```latex
We next perturb the Eve direction available to the BS by a coordinate-angle offset $\varepsilon_{\mathrm e}$ in a uniformly random direction, using the construction in Section~\ref{sec:sim_setup}. The designs use the perturbed statistical CSI and the rate evaluations use the true CSI. At $20$~dB, the proposed ESSR decreases from $20.75$ to $20.13$~bit/s/Hz at $\varepsilon_{\mathrm e}=0.05$~rad, a $3.0\%$ reduction, and to $18.73$~bit/s/Hz at $0.1$~rad. It remains above the largest benchmark value, $17.93$~bit/s/Hz, in this experiment. Errors affect the proposed positions as well as the power allocation; the rate-oriented and fixed-position schemes depend on the perturbed Eve CSI only through power allocation, and AS also depends on it through subset selection. Smooth LoS phases explain continuity of the rate evaluation at fixed designs, but do not alone guarantee a small optimization loss or robustness to arbitrary errors. These experiments establish tolerance for the tested offsets rather than a worst-case robust-design guarantee.
```

#### Ticket 5.2-K: Replace aperture necessity with a geometry-dependent interpretation

- **Location:** `manuscript/main.tex:699`; match the complete block once.
- **Reason and consequence:** The results show average gains, not necessity of a particular aperture. The independent-Eve numerical values and ratios are verified in the supplied MAT files.

[ORIGINAL]
```latex
Third, when the AoDs of Eve are independent of those of the LUs and follow the same distribution, the proposed design still outperforms all the benchmarks, e.g., by $10\%$ and $18\%$ compared with the rate-oriented MA and the sparse FPA for $M=3$, whereas AS performs close to the proposed design for $M=1$. In this case, Eve is mostly well separated from the LUs, so that the compact candidates of AS can already decorrelate it from a single LU, whereas the large aperture of the MAs is essential when Eve is close to an LU.
```

[REPLACE WITH]
```latex
Finally, Eve's elevation and azimuth are drawn independently of the LUs from $[-\pi/3,\pi/3]$. For $M=3$, the proposed, rate-oriented, and sparse-FPA ESSRs are $22.30$, $20.23$, and $18.91$~bit/s/Hz, giving proposed gains of $10.3\%$ and $17.9\%$. For $M=1$, AS achieves $8.49$~bit/s/Hz, close to the proposed value of $8.67$~bit/s/Hz. Independent directions reduce the frequency of near alignment, allowing the compact AS candidates to separate Eve from a single LU in more realizations. These averages complement the near-alignment experiment; they do not imply that a large movable aperture is necessary in every individual geometry.
```

**Global dependent terminology edits.** In `main.tex`, replace the words `angular separation` attached to Δ by `coordinate-angle offset` in the setup, Section `sec:sim_sep`, its caption, and corresponding readme descriptions; do not change actual three-dimensional angle statements unrelated to Δ. Preserve every existing label and citation. Retain the supplied `fig:acc`, `fig:conv`, `fig:snr`, `fig:region`, and `fig:sep_pa` labels. Run LaTeX after this section, inspect the rendered figures and their legends against regenerated array columns, and confirm all references resolve. Acceptance requires a report distinguishing actual executable checks from unavailable-runtime steps; do not treat missing MATLAB/Octave or a failed LaTeX launcher as a successful numerical or compilation check.
