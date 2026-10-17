---
description: Phase 1 — independent review, citation and novelty check; no edits to the manuscript
---
Phase 1 (review only). Do not edit the manuscript.
1. Launch the `ieee-referee` subagent on the compiled PDF. Do not pass it SEED_ISSUES.md, so its
   review stays independent.
2. In parallel, check references (seed A1): for each bib entry confirm it exists and the cited
   claim matches the source, using web search. If a `citation-check` skill is installed, follow
   it. Mark each entry verified / mismatch / not found / unchecked. Never fix an entry by guessing.
3. Novelty check (seed A2): search 2025–2026 papers on movable or fluid antennas with
   two-timescale or statistical-CSI design for secrecy or artificial noise. List the closest
   works with one line each on how they differ from ours. If a `paper-search` skill is
   installed, use it.
4. Number trace (seed A3): for each number in Section V text, find the results file and value
   that produce it; list mismatches and numbers with no source.
5. Merge everything into `review/ISSUES.md`: deduplicate against the seed items, add new IDs,
   keep severities. Items that change technical content or need new simulations get status
   `needs-decision`.
6. Commit `rev-1: review`. Reply with: the referee's summary and likely decision, the counts by
   severity, and the list of `needs-decision` items as short questions I can answer in one line
   each. Then stop and wait for my decisions.
