# Claude Handoff Manager

CLI tools for creating handoffs between Claude Code sessions.

## create-handoff

Generate a handoff document from a Claude Code session and resume work in a fresh session.

```bash
create-handoff <session_id>
create-handoff --list              # List recent sessions
create-handoff -k 25 <session_id>  # Keep last 25 assistant messages (default: 15)
create-handoff -m "continue X"     # Add instructions to the resume prompt
create-handoff --safe <session_id> # Run without --dangerously-skip-permissions
```

**What it does:**
1. Finds the session transcript from `~/.claude/projects/`
2. Prunes to recent messages and clears large content (tool results, documents)
3. Analyzes the transcript to extract tasks, changes, learnings, and next steps
4. Saves a structured handoff document
5. Launches a fresh Claude session with the handoff context loaded

**List recent sessions:**
```bash
create-handoff --list
```

## Installation

```bash
git clone https://github.com/femi/claude-handoff-manager.git
cd claude-handoff-manager
./install-local.sh
```

This symlinks scripts to `~/.local/bin`.

## Requirements

- [Claude Code CLI](https://claude.ai/code) installed and configured

## Optional: Status Line

A custom status line that shows your current directory, git branch, and context usage percentage.

**Setup:**

1. Copy the status line script:
   ```bash
   cp statusline/statusline.sh ~/.claude/statusline.sh
   ```

2. Add to your Claude settings (`~/.claude/settings.json`):
   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "~/.claude/statusline.sh"
     }
   }
   ```

The status line displays:
- Current directory name
- Git branch (if in a repo)
- Context usage percentage (green < 50%, yellow < 80%, red >= 80%)
