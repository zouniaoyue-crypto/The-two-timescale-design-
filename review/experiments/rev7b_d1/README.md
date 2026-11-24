# rev-7b quick verification: Stage-2 MM of Algorithm 2 (S0) vs. a Zheng-type surrogate (S1)

Small-scale experiment for decision item D1 of `review/revision_plan_rev7.md`. These are experiment copies; the production code in `manuscript/ma_secrecy_matlab/` is unchanged and is only called read-only (`objective_F`, `objective_F_n`, `grad_F_n`, `lin_constraints`, `proj_polygon`, `power_opt`, `mc_rates`, `gen_scenario`, `upa_positions`, `default_params`).

**Setup.**

- Default parameters (N = 8, M = 3, A = 4λ, κ = 10 dB, Δ = 0.1 rad, P_tot/σ² = 20 dB).
- Drops 1–10 with the production seeds.
- UPA initialization only.
- Algorithm 2 settings as in production: grid λ/10, N_MM = 20, ε_in = 1e-6, ε = 1e-4, N_AO = 50.
- Monte Carlo ESSR with 10³ channel samples.

**Variants** (`run_d1.m`, `position_sweep_v.m`):

| Name | Stage 1 | Stage 2 |
|---|---|---|
| `S0` | yes | production MM with backtracking |
| `Stage1only` | yes | none |
| `S1best` | yes | MM with a fixed curvature equal to the largest Hessian norm of F over C (oracle; the most favorable fixed curvature) |
| `S1zheng` | yes | Zheng et al.'s Lemma 1 plus a closed-form cosine-sum curvature for the LU terms (`zheng_lu.m`), a second-order Taylor bound with the oracle curvature for the Eve terms, subproblem solved by Octave `sqp` (stand-in for CVX) |
| `S1zhengLocal` | no | as `S1zheng` |
| `S0local` | no | as `S0` ("MM only") |

**Run** (Octave, from `manuscript/ma_secrecy_matlab`):

```
addpath(pwd); addpath(fullfile(pwd,'functions')); addpath('<this folder>');
run_d1('A', {'S0','Stage1only','S1best','S0local'}, 1:10, '<out>');
run_d1('B', {'S1zheng'}, 1:10, '<out>');
run_d1('C', {'S1zhengLocal'}, 1:10, '<out>');
summarize_d1({'<out>/d1_A.mat', '<out>/d1_B.mat', '<out>/d1_C.mat'})
```

The result files `d1_A.mat`, `d1_B.mat` and `d1_C.mat` are stored next to this README.

**Checks used in `review/rev7b_d1_report.md`** (same path setup):

| Script | What it prints |
|---|---|
| `summarize_d1.m`, `stats_d1.m` | the result tables of report §1.2 (means, paired differences with standard errors, iterations, times, curvature quartiles, step medians) |
| `check_zheng_surrogate(1:5, 100)` | validity of the Zheng-type LU surrogate: equality at the expansion point, gradient vs. finite differences, minorization at 4000 random positions |
| `check_an_prediction.m` (script; 10 drops, 30 dB) | AN fraction of Algorithm 1 at 30 and 80 dB vs. the high-SNR predictions (general root and mean-Ξ formula) |
| `pred_equal_power('results')` | high-SNR equal-power loss estimate of report §3.2 from the stored Fig. 5 AN fractions |
| `legend_widths` | legend strip widths of the three label sets (report §3.3) |

Logs of the three runs: `log_A.txt`, `log_B.txt`, `log_C.txt`.
