---
description: Phase 4 — IEEE language and formatting pass, section by section
argument-hint: [section to edit, e.g. abstract-intro | II | III | IV | V | VI | refs | all]
---
Phase 4 (language and formatting). Scope: $ARGUMENTS. Follow the style rules in CLAUDE.md.
Do not change equations, numbers, assumptions or citations' meaning.
1. Abstract and Introduction: if the `ieee-wireless-abstract-intro` skill is installed, use it as
   the checklist and review sentence by sentence against the supervisor's style before
   rewriting. Contributions start with "In this paper" and do not repeat the abstract.
2. Body sections: tighten sentences, use high-frequency IEEE wording, alternate active and
   passive voice, remove absolute words that are not strictly true, fix connectors, split long
   sentences, keep "observation → reason" structure in Section V.
3. Formatting: index terms alphabetical; abstract ≤ 250 words; equation punctuation; consistent
   "Fig."/"Section"/"(eq)" referencing; IEEEtran conventions; BibTeX with IEEEtran.bst and
   IEEEabrv; consistent capitalization in headings and captions.
4. Show the edits for each section as a compact before → after list of the changed sentences
   only (not the full section), then apply. Recompile after each section.
5. Optional, only if I ask: run the `academic-humanizer` skill on Introduction and Conclusion to
   remove templated phrasing, keeping every claim, number and citation.
6. Update ISSUES.md and CHANGELOG.md; commit `rev-4: <scope>`.
