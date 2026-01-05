#!/bin/bash
input=$(cat)

# Directory name
DIR_NAME=$(basename "$(pwd)")

# Git branch (if in a git repo)
GIT_INFO=""
if git rev-parse --git-dir >/dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null || echo 'HEAD')
    GIT_INFO=" \033[1;34mgit:(\033[31m${BRANCH}\033[34m)\033[0m"
fi

# Context percentage and session ID
CTX_INFO=""
SESSION_INFO=""
if [ -n "$input" ]; then
    CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size // 0' 2>/dev/null)

    if [ "$CONTEXT_SIZE" -gt 0 ] 2>/dev/null; then
        INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0' 2>/dev/null)
        OUTPUT_TOKENS=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0' 2>/dev/null)
        CACHE_CREATE=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0' 2>/dev/null)
        CACHE_READ=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0' 2>/dev/null)

        CURRENT_TOKENS=$((INPUT_TOKENS + OUTPUT_TOKENS + CACHE_CREATE + CACHE_READ))
        PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))

        CTX_INFO=" \033[90m(CTX: ${PERCENT_USED}%)\033[0m"
    fi

    # Session ID
    SESSION_ID=$(echo "$input" | jq -r '.session_id // ""' 2>/dev/null)
    if [ -n "$SESSION_ID" ]; then
        SESSION_INFO=" \033[90m(SESSION: ${SESSION_ID})\033[0m"
    fi
fi

# Output: directory, git branch, context, session
echo -e "\033[1;32m➜\033[0m \033[36m${DIR_NAME}\033[0m${GIT_INFO}${CTX_INFO}${SESSION_INFO}"
