---
description: Phase 5 — fresh re-review, build checks, latexdiff and change summary for the advisor
argument-hint: [language of the advisor summary, default English]
---
Phase 5 (final verification).
1. Launch a NEW `ieee-referee` subagent on the current PDF (no access to earlier reports). Then
   compare its findings with `review/ISSUES.md`: list previously fixed issues that reappear and
   new H/M issues.
2. Mechanical checks: clean compile (no errors, undefined references, duplicate labels, overfull
   boxes > 1pt); every figure/table/equation label referenced and figures cited in order; every
   symbol defined before use (re-run the SYMBOLS.md check); every Section V number matches
   `results/`; every bib entry cited and verified.
3. Produce `review/diff.pdf` with latexdiff against tag `pre-revision`.
4. Write `review/CHANGES_FOR_ADVISOR.md` in the language given here (default English): one page,
   grouped as technical / simulations / notation / writing, plus open decisions.
5. Commit `rev-5: final`. Reply with: remaining open issues, and whether the draft is ready to
   send to my advisor.
