#!/bin/bash
# Setup VSCode configuration for Clawdbot development

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🦞 Clawdbot - VSCode Setup"
echo "=========================="
echo ""

# Check if .vscode already exists
if [ -d "$PROJECT_ROOT/.vscode" ]; then
    echo "⚠️  .vscode directory already exists."
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
    rm -rf "$PROJECT_ROOT/.vscode"
fi

# Copy example configuration
echo "📁 Copying VSCode configuration..."
cp -r "$PROJECT_ROOT/.vscode.example" "$PROJECT_ROOT/.vscode"

echo "✅ VSCode configuration created!"
echo ""
echo "Next steps:"
echo "1. Open the project in VSCode"
echo "2. Install recommended extensions when prompted"
echo "3. Press Cmd/Ctrl+Shift+B to build"
echo "4. Press F5 to start debugging"
echo ""
echo "See .vscode/README.md for more information."
