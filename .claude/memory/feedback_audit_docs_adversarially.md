---
name: audit-docs-adversarially
description: Treat docs as suspect and tabulate before concluding match/mismatch
type: feedback
originSessionId: b73f03a2-9fcf-4ce2-81a1-038a3f1799f9
---
**Rule:** When auditing documentation against code (or against another doc), enumerate every claim in one and every behaviour in the other in a side-by-side table before drawing any conclusions. Treat divergence as the default until proven otherwise. Do not rationalise mismatches with "covered elsewhere" arguments without first showing the rationale explicitly.

**Why:** This session, when asked whether the README's Image variants section matched what each `initdb.sh` does, I rationalised a clear dbo-mention inconsistency away as "covered by prose above" and required three user prods ("compare that to the initdb.sh", "think about it!", "no thats not it") to see what was visually plain. The pattern was treating existing docs as probably consistent rather than as suspects to audit.

**How to apply:** When the task is consistency-checking, build the table first.

Columns: claim/row from the doc | behaviour/source from the code. Rows: every per-row description in the doc.

Mark each cell ✓ ✗ ?. Only after every cell is filled, articulate any "covered elsewhere" exceptions with the explicit citation of where they're covered. If a doc claim is not directly observable in the code (or vice versa), that's a divergence to flag, not a rationalisation to make.
