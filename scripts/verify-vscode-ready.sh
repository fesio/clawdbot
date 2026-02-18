#!/bin/bash
# Verify Clawdbot is ready to run in VSCode

set -e

PROJECT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
cd "$PROJECT_ROOT"

echo "🦞 Clawdbot - Readiness Check"
echo "=============================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Check Node.js version
echo -n "Checking Node.js version... "
NODE_VERSION=$(node --version | sed 's/v//')
REQUIRED_VERSION="22.12.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" = "$REQUIRED_VERSION" ]; then
    echo -e "${GREEN}✓${NC} Node.js $NODE_VERSION (>= $REQUIRED_VERSION required)"
else
    echo -e "${RED}✗${NC} Node.js $NODE_VERSION (>= $REQUIRED_VERSION required)"
    ERRORS=$((ERRORS + 1))
fi

# Check if npm is available
echo -n "Checking npm... "
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    echo -e "${GREEN}✓${NC} npm $NPM_VERSION"
else
    echo -e "${RED}✗${NC} npm not found"
    ERRORS=$((ERRORS + 1))
fi

# Check if pnpm is available (recommended)
echo -n "Checking pnpm (recommended)... "
if command -v pnpm &> /dev/null; then
    PNPM_VERSION=$(pnpm --version)
    echo -e "${GREEN}✓${NC} pnpm $PNPM_VERSION"
else
    echo -e "${YELLOW}⚠${NC} pnpm not found (recommended but optional)"
    echo "  Install with: npm install -g pnpm"
    WARNINGS=$((WARNINGS + 1))
fi

# Check if dependencies are installed
echo -n "Checking dependencies... "
if [ -d "node_modules" ]; then
    echo -e "${GREEN}✓${NC} Dependencies installed"
else
    echo -e "${RED}✗${NC} Dependencies not installed"
    echo "  Run: npm install"
    ERRORS=$((ERRORS + 1))
fi

# Check if TypeScript is available
echo -n "Checking TypeScript... "
if [ -f "node_modules/.bin/tsc" ] || command -v tsc &> /dev/null; then
    echo -e "${GREEN}✓${NC} TypeScript available"
else
    echo -e "${RED}✗${NC} TypeScript not found"
    ERRORS=$((ERRORS + 1))
fi

# Check if project is built
echo -n "Checking build artifacts... "
if [ -f "dist/entry.js" ]; then
    echo -e "${GREEN}✓${NC} Project is built"
else
    echo -e "${YELLOW}⚠${NC} Project not built"
    echo "  Run: npm run build"
    WARNINGS=$((WARNINGS + 1))
fi

# Check for VSCode configuration
echo -n "Checking VSCode configuration... "
if [ -d ".vscode" ]; then
    echo -e "${GREEN}✓${NC} VSCode configuration exists"
elif [ -d ".vscode.example" ]; then
    echo -e "${YELLOW}⚠${NC} VSCode example config available"
    echo "  Run: bash scripts/setup-vscode.sh"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${YELLOW}⚠${NC} VSCode configuration not found"
    WARNINGS=$((WARNINGS + 1))
fi

# Check for environment file
echo -n "Checking environment configuration... "
if [ -f ".env" ]; then
    echo -e "${GREEN}✓${NC} .env file exists"
elif [ -f ".env.example" ]; then
    echo -e "${YELLOW}⚠${NC} .env.example exists but .env not created"
    echo "  Copy: cp .env.example .env"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${YELLOW}⚠${NC} No environment file found"
    WARNINGS=$((WARNINGS + 1))
fi

# Check if git is clean (optional)
echo -n "Checking git status... "
if git diff-index --quiet HEAD -- 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Working tree is clean"
else
    echo -e "${YELLOW}⚠${NC} Uncommitted changes present"
fi

echo ""
echo "=============================="

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✅ All checks passed! Bot is ready to run.${NC}"
    echo ""
    echo "To start in VSCode:"
    echo "1. Open this project in VSCode"
    echo "2. Press F5 to start debugging"
    echo "   OR"
    echo "3. Run task: 'Start Gateway' (Cmd/Ctrl+Shift+P -> Tasks: Run Task)"
    echo ""
    echo "To start from terminal:"
    echo "  npm run gateway:watch"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠️  ${WARNINGS} warning(s) found but bot should run.${NC}"
    echo ""
    echo "To fix warnings, follow the suggestions above."
    exit 0
else
    echo -e "${RED}❌ ${ERRORS} error(s) found. Please fix them before running.${NC}"
    echo ""
    echo "Quick fix commands:"
    if [ ! -d "node_modules" ]; then
        echo "  npm install              # Install dependencies"
    fi
    if [ ! -f "dist/entry.js" ]; then
        echo "  npm run build           # Build the project"
    fi
    if [ ! -d ".vscode" ] && [ -d ".vscode.example" ]; then
        echo "  bash scripts/setup-vscode.sh  # Setup VSCode"
    fi
    exit 1
fi
