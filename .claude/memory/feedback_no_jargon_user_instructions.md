---
name: no-jargon-user-instructions
description: Define terms inline and write goal-phrased steps in manual user instructions
type: feedback
originSessionId: b73f03a2-9fcf-4ce2-81a1-038a3f1799f9
---
**Rule:** When writing manual user instructions: (a) define every uncommon term inline on first use, and (b) prefer goal-phrased steps ("grant the gist permission, set to read and write") over UI-step numbers ("click button 5, then radio 3"), since UI layouts rot. If a third-party UI doesn't match what you describe, treat that as a sign your description is stale, not the user's screen.

**Why:** This session, in setup walkthroughs (creating a Gist + a fine-grained PAT), I used unexplained jargon ("gist ID") and gave step-numbered UI instructions that didn't match the user's actual GitHub screen. User had to push back twice ("what the hell is a gist ID", "Step A: 5 i do not see a readonly option") to get usable guidance. The friction came from assuming familiarity and from prescribing UI clicks rather than the underlying goal.

**How to apply:** Before sending step-by-step instructions, scan for:
1. Acronyms or product names without a one-line definition (PAT, gist, SBOM, OCI, attestation, etc.).
2. Instructions phrased as "click X, then click Y" without the underlying goal.
3. Numbered field references that depend on a current UI layout.

Rewrite each into goal-phrased + term-defining form. When in doubt, name the goal, define the term in one clause, and let the user navigate the UI themselves.
