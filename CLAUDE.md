# Project rules — Two-timescale MA secure transmission paper (IEEE TCOM draft)

Main file: `manuscript/main.tex`. Target: IEEE Transactions (long paper, CAS zone 2 or above).
Chat with me in English. Keep token use low: grep for `\label`/section names and read only the
lines you need; never reprint whole files; report changes as short diffs or bullet summaries.

## Build / run (fill in during /rev-0-setup)
- Compile: `<detected command, e.g. latexmk -pdf -interaction=nonstopmode main.tex>` (run in `manuscript/`)
- Simulations: MATLAB code in `manuscript/ma_secrecy_matlab/` (entry point `run_all.m`).
  This repo is used from Claude Code on the web, where MATLAB is not available: try GNU Octave
  (install it if possible) for audits and quick reduced runs; if a script cannot run, say so and
  give me the exact MATLAB command to run on my own computer, then read back the result files
  I commit. Never invent simulation outputs.
- `<fill in: how each figure is produced, results folder>`

## Hard rules (never break)
1. Shared state lives in `review/ISSUES.md` (IDs, severity, status). Read it at the start of every
   phase; update status when you fix something. Log every change in `review/CHANGELOG.md`
   (ID, file:line, what, why).
2. Do not change a technical claim, equation, assumption or reported number silently. If a fix
   changes meaning, propose it, mark the issue `needs-decision`, and wait.
3. Every number in Section V text must be traceable to a results file. Never type a number
   from memory or from the old text; recompute it.
4. Never invent, add or "complete" a reference. New citations only from sources I approve;
   unverifiable entries are flagged, not guessed.
5. Work on branch `revision-v1`; commit at the end of each phase with message `rev-<phase>: ...`.
   Compile after each batch of edits; a phase is not done while the build has errors,
   undefined references or new overfull boxes > 1pt.
6. Do not touch the supervisor-style rules below without asking.

## Mathematical style (my preference — reviewers in this area favor it)
- Emphasis on system modeling, formula derivation and optimization procedures.
- Few theorems/lemmas/proofs. Known results are cited inline ("it follows from [x] that ..."),
  not restated as lemmas. Approximations are presented as derivations, not as lemmas
  asserting "≈"; only genuinely new, exact statements get a formal environment.
- Every symbol is defined before first use, has exactly one meaning in the whole paper
  (main text and appendices), and uses standard glyphs (avoid ς, ϖ, ϑ, ϱ, Υ, and letters
  that look like digits such as o, l). Use one epsilon glyph only. Put notation macros in
  one place (e.g. `notation.tex`) so renames are global.
- Equations are punctuated as part of the sentence; displayed equations end with `,` or `.`.

## Supervisor's writing style (abstract, introduction, algorithm text)
- Abstract: organized around how the nonconvex problem is solved at a macroscopic level, not a
  chronological list of steps or contributions; no over-elaborated justifications (long
  "Since..." clauses); do not name only one constraint; no coined labels; state what the
  algorithm is used for. Sentences pair a main clause (the logical step) with a subordinate
  clause (the technical detail), e.g. "To solve this nonconvex problem, we first ..., where ...".
- Introduction flow: topic → enabling technology (one sentence ending in a "where" clause +
  citations, no elaboration) → what those works overlook → closest prior work and its
  limitation → "remains unexplored" → contributions. Every claim is backed by references;
  delete own-voice explanatory sentences.
- Contributions paragraph starts with "In this paper"; contributions are short and not
  redundant with the abstract. Model and problem are not packed into one long sentence.
- Common high-frequency IEEE vocabulary; alternate active and passive voice; no absolute words
  ("only", "always") unless strictly true; no chains of "and"; logically accurate connectors.
- Avoid: leverage, utilize, novel, delve, pivotal, paramount, showcase, seamless, holistic,
  plethora, "it is worth noting that", "in order to", stacked "Moreover/Furthermore".
- Prefer: "is formulated as", "subject to", "is given by", "in closed form", "without loss of
  generality", "it can be verified that", "is nonconvex due to", "is guaranteed to converge",
  "outperforms the benchmark schemes", "in the high-SNR regime".
