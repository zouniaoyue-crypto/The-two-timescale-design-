# Executed numerical validation — 2026-10-19

Runtime: GNU Octave 11.3.0, Windows x86_64, using:

`C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical/octave-portable/octave-11.3.0-w64/mingw64/bin/octave-cli.exe`

All results and logs in this directory are separate from the supplied paper
results. No production MATLAB source, manuscript source, or revision specification
was edited by this validation task. The full-default paper regeneration queue
was not launched.

All 21 supplied MAT files were also compared by SHA-256 with their entries in
the archived `original_project.zip`: every file is unchanged. Per-file hashes
are recorded in `historical_results_unchanged.json`. The production and harness
source fingerprints for the core checks are in `validated_production_sources.json`
and `validated_harness_sources.json`.

## Commands

Run from `C:/Users/lenovo/Desktop/GPT/4` in PowerShell. Each task below was actually
executed, and its log and `<task>_status.json` are retained here.

```powershell
$runtimePath = (Resolve-Path -LiteralPath 'manuscript/.revision_audit/numerical/octave-portable/octave-11.3.0-w64/mingw64/bin/octave-cli.exe').Path
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('phase2');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('phase5');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('implementation');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('legacy_equivalence');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('supplementary_smoke');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('supplementary_audit');"
& $runtimePath --no-gui --quiet --eval "addpath('C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/numerical'); audit_test_entry('inspect_supplementary');"
```

The runner sets `MA_RESULTS_DIR` to this directory. The merge fixture additionally
sets it to `merge_fixture/` while executing the actual merge implementation.
The runner records FAIL and exits nonzero if an assertion or runtime error occurs.

## Assertions and quantitative evidence

Every listed task passed. The final status JSON files are authoritative for elapsed
times; phase2 took 4.195 s, original `check_implementation` took 3.125 s,
legacy-equivalence took 5.714 s, supplementary smoke took 4.402 s, supplementary
audit took 107.214 s, and independent supplementary inspection took 0.717 s.

| Check | Executed evidence |
|---|---|
| Analytical gradients, full and LU subset | Maximum relative finite-difference errors `1.2596639118e-7` and `8.9543480252e-8`, both asserted below `1e-5` |
| Rank-one versus direct objective | Maximum absolute error `9.7699626167e-15`, asserted below `1e-9` |
| Fixed-q secrecy water-filling | Signal budget `70`, allocated `70`; active derivative spread `5.0941346206e-16`; inactive-user KKT inequality asserted |
| Boundary cases | No secrecy-active users, zero PI, zero eta/theta, and zero total system power asserted |
| Finite-grid retention | Actual private helper body exercised at `Q=2,4,40,41`; narrow coarse peak and both endpoints retained; all public power modes exercised at each Q |
| Default odd-Q historical behavior | Archived original power and water-filling bodies compared with revised production routine on 20 seeded feasible geometries × four modes: 80 exact-equality comparisons; 105 helper objectives including flat and symmetric ties also exactly equal at Q=41 |
| Position and power constraints | Shape, real finite coordinates, region bounds, minimum spacing, nonnegative powers and total budget asserted |
| AO monotonicity | Full, EPA, fixed split and no-AN histories asserted nondecreasing; pure MM branch also asserted, `8.25732705 → 8.38981049` |
| Single-user exact projector identity | 100 independent realizations, worst exact algebraic residual `8.8817841970e-16` |
| Declared single-user closure residual | N=2, kappa=1, C=0 fixture: declared `-1/6`, evaluated `-0.16666666666666675`; limitation retained rather than changed |
| Per-drop persistence | Small actual two-point/two-scheme sweep retains four complete designs, seeds, sample counts, Rb/Re and mechanism statistics |
| N merge provenance | Seven rows, two schemes with alternating source-column order; all merged scalar values, drop rates, leak, AN and complete design cells match by scheme name; unavailable AS stays NaN; removing old-style missing design provenance is rejected |
| Saved supplementary designs | All 72 smoke/audit designs independently inspected for geometry, spacing, power, objective/histories and ESSR aggregation |

The original `check_implementation` evaluates rates from 20,000 channel samples.
Its ESSR was `14.188` versus analytical approximation `12.027` bit/s/Hz in that
fixture. This difference is reported, not treated as an exactness or bound claim.

## Separate supplementary studies

These use smaller, explicitly saved optimization budgets, three paired AoD drops,
and independent common evaluation seeds; they do not replace full-default paper
curves or establish general rankings.

Grid-resolution study: N=8, M=3, one initialization, at most 10 AO iterations and
10 MM iterations per update, 5,000 evaluation realizations per design.

| Grid spacing | Mean exact-SINR MC ESSR | Across-drop standard error | Mean optimization seconds |
|---|---:|---:|---:|
| 0 (MM only) | 20.13755952 | 0.58421808 | 3.5998 |
| 0.2 | 20.59734350 | 0.50449965 | 3.5580 |
| 0.1 | 20.61472929 | 0.52007794 | 3.0167 |
| 0.05 | 20.61599476 | 0.51957383 | 3.1856 |

The paired average difference of spacing 0.05 minus 0.1 is `0.0012654691`
bit/s/Hz. Runtime comparisons are descriptive for this machine and concurrent
audit execution.

Single-user closure study: N in `{2,4,8}`, linear LU kappa in `{0,1,10}`, three
drops each, 24 identical feasible position candidates for both closures and the
same finite Q=41 power grids; 10,000 exact-SINR MC evaluation samples per closure
with common evaluation seeds. The identity-closed alternative is confined to
this study. It does not replace the production estimator.

Across 27 paired cases, exact ESSR difference (identity-closed minus retained)
ranges from `-0.0013141090` to `+0.0008341895` bit/s/Hz, with mean
`-0.0000837925`. The selected position candidate is the same in all cases;
power choices can differ. No superiority inference is made. The full nine-row
N/kappa summary is `single_user_closure_audit_summary.csv`; complete designs,
rates and mechanism statistics remain in the MAT files.

## Harness corrections

Audit helpers gained an optional output directory so artifacts stay isolated.
The merge fixture uses the production `MA_RESULTS_DIR` override in addition to
its audit-only helper path. An empty fixture `functions/` directory preserves
the copied entry point's relative path behavior without path warnings.
Only entry point names/call targets are changed in archived routine copies used
for the historical comparison. No production routine is changed by these fixes.

## Separate graphics diagnostic

`check_graphics_bootstrap.m` confirmed the Windows CLI startup workaround:
initialize gnuplot, create and close one explicit invisible gnuplot figure, then
select gnuplot again. Three ordinary figures and both actual Fig. 5 panels export
successfully afterward. The PNGs are in `graphics/`. Visual inspection found that
the Times New Roman family name is mishandled inside gnuplot enhanced italic
markup in axis labels; those diagnostic PNGs are not final paper figures. The
parent task is handling the font override and final rendering QA. This graphics
diagnostic does not affect the passing numerical assertions above.
