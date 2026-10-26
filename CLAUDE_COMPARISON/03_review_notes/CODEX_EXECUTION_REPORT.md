# Revision execution report

**Status: all authorized revision and acceptance work is complete.** Updated 2026-10-26T06:38:36.815890+00:00 (UTC).

The manuscript source, regenerated figures and published `main_revised.pdf` agree. All five Phase gates and final compilation pass. All full-default outputs, design records, numerical claims and required visual checks are accepted. Author names, affiliations and email remain placeholders, so this is not a submission-ready declaration.

## Specification execution

The immutable specification has 82 exact replacement entries: Phase 1: 2; Phase 2: 23; Phase 3: 20; Phase 4: 12; Phase 5: 25. Every manifest entry is `applied`. Each Phase passes two actual PDFLaTeX runs before the next Phase. Original source snapshots, replacement spans and hashes, and separate build logs are retained in `.revision_audit/run-20261019T123125Z/`.

The current source retains all 124 original labels and has 127 unique labels, with no missing labels, duplicate labels, undefined cross-references or undefined citation keys. The final build is `build-final-regenerated-20261026/`: both processes exit successfully, without Overfull hbox or the other prohibited warnings. The accepted build is explicitly copied to `main_revised.pdf`.

Additional recorded repairs complete the specification's intent: final notation normalization; exact-SINR conditioning checks; figure font/axis and scheme-name handling; source comment/reference synchronization; one paragraph page-break adjustment; the numerical rounding correction described below; and a sentence-ending period at (60). `In the supplied data` is updated to `In this setting` after regeneration. Existing labels and citation keys remain intact.

## Mathematical and implementation evidence

The original seven executed Octave checks pass: gradients, rank-one/direct objectives, fixed-AN KKT residuals, power budgets, original geometry constraints, candidate/incumbent/end-point retention, every recorded AO trajectory, full/MM-only behavior, single-user identities and saved provenance merging. Quantitative results remain in `numerical/test-results/VALIDATION_REPORT.md`; no unproved approximation tolerance or global convergence claim is introduced.

The Q=41 comparison retains identical results for 80 actual power allocations and 105 helper/tie fixtures. This is scoped comparison evidence, not a universal equivalence theorem. The numerical inverse guard rejects unsafe/nonfinite pivots or estimated reciprocal infinity-condition at most 1e-12. It fails the experiment rather than dropping or redrawing a sample. Tests include 4000 accepted inverse pages, six rejected fixtures and 30000 Monte Carlo samples with exact old/new agreement.

The adopted Eve-error output contains 2500 designs. All are reevaluated using 5000 channel samples each with the guard: 12.5 million channel samples, with zero change in their stored rates, leakage or AN values. Adoption is explicitly documented in `eve_error_adoption.json`.

## Completed numerical regeneration

All 21 queue jobs finish, including the supplementary study, followed by the final merge/replot and independent full validation. The last power-allocation job resumes from 598 completed durable calls and completes all 700; no duplicate queue is started. Cache tests establish exact outputs and RNG restoration across cold calls, hits and restarts, including corrupt/truncated records and abandoned temporary files.

The full inspection accepts 21 MAT files and 28800 saved design records. Of these, 3200 are repeated in the merged antenna-count artifact and have already been checked in the individual-N files; they are not claimed as additional independent experiments. Checks cover parameters, recorded seeds/sample counts, benchmark candidate geometry, region and spacing constraints, power constraints, no-AN/equal-power rules, surrogate histories and stopping, ESSR arithmetic, and AN/leakage aggregate reconstruction.

The aggregate-only accuracy and convergence files are linked to 1200 and 700 cached designs, respectively. Independent NumPy moment formulas reconstruct the 13 accuracy settings to within 2.49e-14. All 700 convergence trajectories match the cached outputs exactly, and every recorded default stopping index agrees. Scientific source/runtime fingerprints remain enforced.

The completed supplementary audit independently validates 66 designs: 12 grid-resolution designs and 54 designs from 27 paired closure comparisons. The earlier six smoke-test designs are separately retained. These use three drops and stated reduced optimization budgets; they are not substitutes for the full-default paper experiments. The closure comparison shows both signs of the measured rate difference and does not establish superiority.

Historical AS-region metadata differs from the current configuration, and those differences remain explicitly reported. Current result parameters match the current source. An audit-only singleton-dimension issue in single-user leakage arrays is corrected: the normalized stored/reconstructed difference is 6.66e-16. The checker also accounts explicitly for the power-allocation experiment's [0, -10, -20] dB gains. These repairs do not alter simulation data or relax scientific assertions.

## Numerical claims, figures and PDF

All 58 tracked manuscript numerical literals are recomputed from completed results using scheme names. No rounded mismatch remains. The inherited maximum wiretap approximation error of 0.053 is corrected to 0.052 bit/s/Hz, because the measured maximum is 0.0524089404038528. The other reported rounded gains, rates, standard error, AN fractions and cross-N comparisons remain supported. Existing qualifications, observed EP crossings and expectation-before-positive-part evaluation are preserved.

All nine figures are regenerated from completed, independently checked arrays and visually inspected. The manuscript loads `ma_secrecy_matlab/figures_revised_regenerated/`. Every published image is pixel-identical to the image produced by the completed finalizer. `provenance.json` records input and image fingerprints.

All 16 old and final PDF pages are rendered with the same Poppler runtime. Pages 12, 13 and 15 change and are visually inspected, including equations, plots, captions, column boundaries and page endings. The other 13 pages are pixel-identical to the previously accepted pages. The final PDF has no clipping, overlap or missing glyphs observed in these checks.

## Preservation and final artifacts

The original 21 MAT files remain byte-identical to the immutable original project ZIP. No external reference paper is modified. Final authoritative artifacts are `main.tex`, `main_revised.pdf`, `figures_revised_regenerated/`, and `results_revised_checkpointed/`. Full data/cache/claim checks, source fingerprints and raw logs remain alongside their outputs. The final gate summary is `.revision_audit/run-20261019T123125Z/final_acceptance.json`.

Source SHA-256: `236f32d5a1bd312df4c5ef9bb2b8a8665989df75da7296caeaca2e146bcdaffa`. PDF SHA-256: `53ca4545a220fe10af4ae58f422f9949611db4dc5d93abccc1db2a05290510ff`.

## Continuation status

The work finishes within the current usage allowance. The previous one-shot automation is deleted; a new 24-hour task is unnecessary and is not created. Resume records are marked complete to prevent repeated execution. The only remaining user-supplied information is genuine author/affiliation/email metadata at `main.tex:88-90`. Replace it before submission, then compile and inspect the affected first page. No author information is invented.
