#!/bin/bash
set -e

INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing session-manager tools to $INSTALL_DIR"

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Create symlinks for all scripts
for script in "$SCRIPT_DIR/scripts/"*; do
    name=$(basename "$script")
    chmod +x "$script"
    ln -sf "$script" "$INSTALL_DIR/$name"
    echo "  Installed: $name"
done

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo "Add this to your shell config (~/.bashrc, ~/.zshrc, etc.):"
    echo ""
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    echo ""
fi

echo ""
echo "Installation complete!"
