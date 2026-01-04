# Analyze Session Transcript for Handoff

You are analyzing a Claude Code session transcript (JSONL format) to create a handoff document. The transcript will be provided to you. Your job is to extract the key context, learnings, and next steps.

## Input Format

The session is in JSONL format where each line is a JSON object with a `type` field:
- `user`: User messages
- `assistant`: Claude's responses
- `tool_use` / `tool_result`: Tool interactions

Focus on understanding:
- What task(s) were being worked on
- What changes were made (file edits, commands run)
- Key learnings or discoveries
- Where the work left off

## Output

Write a handoff document using this exact template structure. Output ONLY the markdown content, no preamble:

```markdown
---
date: [Current date and time with timezone in ISO format]
topic: "[Feature/Task Name] Handoff"
tags: [relevant, tags]
status: complete
type: handoff
---

# Handoff: {concise description}

## Task(s)

{description of the task(s) from the session, with status of each (completed, work in progress, planned/discussed)}

## Critical References

{List 2-3 most important files or documents referenced. Leave blank if none.}

## Recent Changes

{describe changes made to the codebase in file:line syntax}

## Learnings

{important things discovered - patterns, root causes, important information for the next session}

## Artifacts

{exhaustive list of files produced or updated as filepaths}

## Action Items & Next Steps

{list of what should happen next based on where the session left off}

## Other Notes

{other useful context that doesn't fit above categories}
```

## Guidelines

- **Be concise** - compress context without losing key details
- **Be precise** - include file paths and line references
- **Focus on actionable context** - what does the next session need to know?
- **Avoid code blocks** - prefer file:line references over pasting code
