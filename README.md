# Session Manager

CLI tools for managing Claude Code sessions.

## Tools

### create-handoff

Generate a handoff document from a Claude Code session and optionally resume work in a fresh session.

```bash
create-handoff <session_id>
```

**What it does:**
1. Reads the session transcript from `~/.claude/projects/{project}/{session_id}.jsonl`
2. Analyzes the transcript to extract tasks, changes, learnings, and next steps
3. Saves a structured handoff document to `thoughts/shared/handoffs/general/`
4. Launches a fresh Claude session with the handoff context loaded

**Finding session IDs:**
```bash
ls ~/.claude/projects/
# Then list sessions for a specific project:
ls ~/.claude/projects/{project-dir}/
```

## Installation

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/femi/session-manager/main/install.sh)"
```

This clones the repo to `~/.session-manager` and symlinks scripts to `~/.local/bin`.

**Custom install location:**
```bash
INSTALL_DIR=/usr/local/bin /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/femi/session-manager/main/install.sh)"
```

### From a local clone

```bash
git clone https://github.com/femi/session-manager.git
cd session-manager
./install-local.sh
```

## Requirements

- [Claude Code CLI](https://claude.ai/code) installed and configured
