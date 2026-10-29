# Manuscript — two-timescale MA secure transmission (IEEE TCOM draft)

## Files

| Path | Content |
|---|---|
| `main.tex` | manuscript (entry point; Figs. 1–2 are TikZ inside this file) |
| `notation.tex` | all notation macros, read by `main.tex` via `\input{notation}` |
| `main_preview.pdf` | compiled manuscript (14 pages) |
| `ma_secrecy_matlab/` | MATLAB/Octave code; `results/` holds the `.mat` files and the PNG figures used by `main.tex` (`\graphicspath`) |
| `ma_secrecy_matlab/readme.pdf` | code documentation (Chinese; source `readme.tex`, compile with XeLaTeX) |
| `../review/` | `ISSUES.md` (issue states), `CHANGELOG.md`, `MERGE_DECISIONS.md`, `VALIDATION.md` |

## Compile

```
cd manuscript
pdflatex main.tex
pdflatex main.tex
```

The bibliography is a `thebibliography` block inside `main.tex`, so BibTeX is not needed. Run
`pdflatex` twice, or three times after changing labels. The code readme is compiled with
`xelatex readme.tex` (twice) in `ma_secrecy_matlab/`.

## Reproduce the numbers and figures

In MATLAB or Octave, from `manuscript/ma_secrecy_matlab/`:

| Command | Purpose |
|---|---|
| `check_implementation` | self-test (gradient, water-filling, monotonicity), about 1 min |
| `verify_numbers` | recomputes every number quoted in Section V from `results/*.mat`, about 10 s |
| `replot_all` | redraws Figs. 3–7 from the stored results (Octave: `xvfb-run -a octave --no-gui --eval replot_all`) |
| `run_all` | reruns all simulations (several hours; see `readme.pdf`) |

## Information the author must supply

- Author names, IEEE membership grades, affiliations and e-mail addresses (`main.tex`, lines 43–45).
- A funding acknowledgment, if any.
- Decisions on the open items in `../review/ISSUES.md` (I33 robustness table, I34 extra
  simulations, I36 vector figures, I35 novelty search and full reference verification).
