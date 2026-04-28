---
name: plan-first
description: Outline plan and get explicit user approval before any side-effecting action
type: feedback
originSessionId: b73f03a2-9fcf-4ce2-81a1-038a3f1799f9
---
**Rule:** NEVER write code, edit files, or run side-effecting commands (commit, push, workflow dispatch) until you have outlined a plan and the user has explicitly approved it. Approval signals are short and unambiguous (`go`, `jdi`, `do it`, a numeric option choice). Until then, stay in planning mode — answer questions, propose, refine.

**Why:** User has explicitly demanded plan-before-action 3+ times across two sessions:
- "Do not create anything just yet all I want is a plan." (current session)
- "audit them all and produce a functional future proof plan. do not change anything just produce the plan." (current session)
- "so plan what needs to be done to get those versions supported please." (Apr 20 session)

The pattern shows the user values the planning step distinctly from execution and expects to gate the transition.

**How to apply:** When given a non-trivial task, respond with a written plan (files to change, commands to run, expected outcome, risks) and stop. Resume only on an explicit approval token from the user. Trivial reads, searches, and clarifying questions are exempt; anything that writes, commits, or pushes is not.

When the user gives a multi-part answer to clarifying questions ("1. B / 2. yes"), confirm understanding of each before acting — see also: feedback on confirming multiple-choice answers.
