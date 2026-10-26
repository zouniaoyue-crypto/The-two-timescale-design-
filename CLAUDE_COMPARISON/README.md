# Claude Code 对比入口

把这个文件夹交给 Claude Code：如需独立审阅后融合生成最终版本，读取 `CLAUDE_MERGE_PROMPT.md`；如仅需只读对比报告，读取 `CLAUDE_REVIEW_PROMPT.md`。

| 文件夹 | 内容 | 最先读取 |
|---|---|---|
| `01_original/` | 首次修改前的完整原稿和仿真源码、原始结果 | `main.tex`、`main_preview.pdf` |
| `02_revised/` | 当前已验收的论文、仿真源码、结果和九张图 | `main.tex`、`main_revised.pdf` |
| `03_review_notes/` | 修改规范、执行报告、实际差异、验证证据 | `FILE_COMPARISON_GUIDE.md`、`main.tex.diff` |

原始版本直接来自不可变备份 `original_project.zip`。修订版本逐字节复制自工作项目，并与最终验收的源码/PDF指纹核对一致。整理没有改动论文、公式、仿真代码或结果。

主源码 SHA-256：`236f32d5a1bd312df4c5ef9bb2b8a8665989df75da7296caeaca2e146bcdaffa`。

本目录不包含耗时仿真的运行缓存、编译中间文件、便携工具和历史试验过程。完整证据仍保留在 `C:/Users/lenovo/Desktop/GPT/4/manuscript/.revision_audit/` 以及工作项目的 results_revised_checkpointed/checkpoints/。准确率与收敛实验的设计缓存不随精简目录复制；如需复查原始缓存，可访问该工作项目。

已完成的82项替换、五个Phase和完整仿真无需为了对比而重复执行。作者姓名、单位和邮箱仍为占位内容。此前数值/编译验收通过不等同于新的独立学术审稿结论。
