---
description: Phase 0 — inventory the repo, record build/run commands, baseline compile, seed the issue list
---
Phase 0 (setup). Do not edit any manuscript text in this phase.
1. Create branch `revision-v1` from the current HEAD and tag the HEAD `pre-revision`.
2. Inventory, briefly: the .tex/.bib/.sty files under `manuscript/`, figure files and how each
   figure is generated (script → data file → figure), the simulation language and entry
   points, and whether the simulation can run here (e.g. `matlab -batch` or python env).
3. Compile `manuscript/main.tex`. Record the exact build and simulation commands in the
   "Build / run" section of CLAUDE.md. List errors, warnings, undefined references and
   overfull boxes.
4. Create `review/ISSUES.md` by copying the items in `review/SEED_ISSUES.md` into a table with
   columns: ID | severity | location | issue | status (open / needs-decision / fixed / wontfix).
   Create an empty `review/CHANGELOG.md`.
5. Commit: `rev-0: setup`. Reply with a 10-line summary: build status, simulation pipeline,
   anything blocking the later phases.
