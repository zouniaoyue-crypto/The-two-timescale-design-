---
description: Fix specific issues from review/ISSUES.md by ID
argument-hint: [issue IDs, e.g. C4 D6 F1]
---
Fix only these issues from `review/ISSUES.md`: $ARGUMENTS.
For each: read the minimum context, make the smallest correct edit, recompile, update its status
and add a CHANGELOG.md line. If an issue turns out to need a technical or content decision,
mark it `needs-decision`, explain in two lines, and skip it. Reply with one line per ID.
