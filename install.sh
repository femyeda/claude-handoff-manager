#!/bin/bash
set -e

REPO="femi/session-manager"
INSTALL_DIR="${INSTALL_DIR:-$HOME/.local/bin}"
CLONE_DIR="${CLONE_DIR:-$HOME/.session-manager}"

echo "Installing session-manager..."

# Clone or update the repository
if [ -d "$CLONE_DIR" ]; then
    echo "Updating existing installation..."
    git -C "$CLONE_DIR" pull --quiet
else
    echo "Cloning repository..."
    git clone --quiet "https://github.com/$REPO.git" "$CLONE_DIR"
fi

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Create symlinks for all scripts
for script in "$CLONE_DIR/scripts/"*; do
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
echo "Run 'create-handoff --help' to get started."
