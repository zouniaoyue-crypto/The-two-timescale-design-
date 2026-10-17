---
description: Phase 2 — notation table, symbol conflicts, rigor fixes and theorem-style reduction
---
Phase 2 (notation and rigor). Read CLAUDE.md and the open C-, B- and G1 items in review/ISSUES.md.
1. Build `review/SYMBOLS.md`: every symbol in main text and appendices with its meaning, the
   place it is first defined and the places it is used. Flag symbols used before definition,
   reused with different meanings, defined but unused, and unconventional glyphs.
2. Propose a rename table (old → new, reason) that resolves every conflict with standard
   IEEE-style glyphs. Show it to me and wait for approval before applying.
3. After approval: implement renames through macros in one notation file, update the Notation
   paragraph, figure labels/legends that use the symbols, and appendices. Recompile and grep to
   confirm no old symbol remains.
4. Apply the approved rigor items (B-items) and the approved theorem-style changes (G1): known
   results cited inline instead of restated as lemmas; approximations written as derivations;
   formal statements kept only for exact, new results; numbering and cross-references updated.
   Do not change any equation's meaning; if a derivation must change, show it first.
5. Update ISSUES.md statuses and CHANGELOG.md; compile cleanly; commit `rev-2: notation and rigor`.
   Reply with a short summary and anything still open.
