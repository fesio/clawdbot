# Bot Readiness Check - Visual Studio Code Setup

**Language:** English | [Polski](VSCODE-SETUP-PL.md)

## Problem Statement
"CHECK IF THE BOT IS READY TO RUN BY OPENING VISUAL CODE"

## Solution

This document provides a complete guide to verify that Clawdbot is ready to run in Visual Studio Code.

## Step 1: Check System Requirements

### Required:
- **Node.js ≥ 22.12.0**
- **npm** (installed with Node.js)
- **Visual Studio Code**

### Recommended:
- **pnpm** (faster package manager)
- **Git**

### Check Versions:

```bash
# Check Node.js
node --version
# Should be: v22.12.0 or higher

# Check npm
npm --version

# Check pnpm (optional)
pnpm --version
```

## Step 2: Automatic Verification

Use the verification script:

```bash
cd /path/to/clawdbot
bash scripts/verify-vscode-ready.sh
```

This script checks:
- ✓ Node.js version
- ✓ npm/pnpm availability
- ✓ Dependencies installed
- ✓ Project built
- ✓ VSCode configuration
- ✓ Environment file (.env)
- ✓ Git status

### Example Output:

```
🦞 Clawdbot - Readiness Check
==============================

Checking Node.js version... ✓ Node.js 24.13.0 (>= 22.12.0 required)
Checking npm... ✓ npm 11.6.2
Checking pnpm (recommended)... ✓ pnpm 10.23.0
Checking dependencies... ✓ Dependencies installed
Checking TypeScript... ✓ TypeScript available
Checking build artifacts... ✓ Project is built
Checking VSCode configuration... ✓ VSCode configuration exists
Checking environment configuration... ✓ .env file exists
Checking git status... ✓ Working tree is clean

==============================
✅ All checks passed! Bot is ready to run.
```

## Step 3: Install Dependencies (if needed)

If verification shows missing dependencies:

```bash
# Preferred way (with pnpm)
pnpm install

# Or with npm
npm install
```

## Step 4: Build Project (if needed)

```bash
# Build TypeScript code
npm run build

# Optionally: build UI
npm run ui:build
```

## Step 5: Configure Visual Studio Code

### Automatic Setup:

```bash
bash scripts/setup-vscode.sh
```

This creates `.vscode/` directory with:
- `settings.json` - Project settings
- `launch.json` - Debug configurations
- `tasks.json` - Build/test tasks
- `extensions.json` - Recommended extensions

### Manual Setup:

```bash
cp -r .vscode.example .vscode
```

## Step 6: Open in Visual Studio Code

```bash
# From terminal
code .

# Or open VSCode and select File -> Open Folder
```

## Step 7: Install Extensions

When you open the project in VSCode:

1. VSCode will ask: "Do you want to install the recommended extensions?"
2. Click **"Install"** or **"Show Recommendations"**

Recommended extensions:
- ESLint - Linting
- Prettier - Code formatting
- Vitest Explorer - Running tests
- GitLens - Enhanced Git integration

## Step 8: Verify Bot is Ready

### Method 1: Run Build Task

1. Press **Cmd/Ctrl+Shift+B**
2. Select **"Build"**
3. Check Output in VSCode terminal

If build succeeds - bot is ready! ✅

### Method 2: Run Tests

1. Press **Cmd/Ctrl+Shift+T**
2. Or run task: **"Test"**
3. Tests should pass without errors

### Method 3: Run Gateway in Debug Mode

1. Press **F5** or go to **Run & Debug** (Cmd/Ctrl+Shift+D)
2. Select **"Debug Gateway"**
3. Click green arrow ▶️
4. Gateway should start in terminal

If you see something like this - it works! ✅
```
Gateway listening on ws://0.0.0.0:18789
```

### Method 4: Run Gateway from VSCode Terminal

In VSCode terminal:

```bash
npm run gateway:watch
```

This runs gateway in development mode with auto-reload.

## Step 9: Test Bot Functionality

### Test 1: Check Gateway Status

```bash
npm run clawdbot gateway status
```

### Test 2: Run Simple Command

```bash
npm run clawdbot -- --version
```

### Test 3: Test AI Agent (requires configuration)

```bash
npm run clawdbot agent --message "Hello, are you working?" --thinking high
```

## Troubleshooting

### Issue: "Cannot find module"

**Solution:**
```bash
npm install
npm run build
```

### Issue: "Port 18789 already in use"

**Solution:**
```bash
# Stop existing gateway
npm run clawdbot gateway stop

# Or find and kill process
lsof -i :18789
kill -9 <PID>
```

### Issue: "TypeScript errors"

**Solution:**
```bash
# Clean and rebuild
rm -rf dist
npm run build
```

### Issue: "VSCode doesn't detect TypeScript"

**Solution:**
1. Open any `.ts` file
2. Press **Cmd/Ctrl+Shift+P**
3. Type: "TypeScript: Select TypeScript Version"
4. Select: "Use Workspace Version"

### Issue: "Tests not working"

**Solution:**
```bash
# Install Vitest extension in VSCode
# Or run from terminal
npm test
```

## Quick Start Checklist

Use this checklist to ensure everything works:

- [ ] Node.js ≥ 22.12.0 installed
- [ ] `npm install` completed
- [ ] `npm run build` succeeded
- [ ] `.vscode/` directory exists
- [ ] VSCode opened in project directory
- [ ] Recommended extensions installed
- [ ] `Cmd/Ctrl+Shift+B` builds without errors
- [ ] `F5` starts debugger
- [ ] Gateway starts on port 18789
- [ ] `npm test` passes

## Next Steps

After verifying the bot is ready:

1. **Read documentation:**
   - [Getting Started](https://docs.clawd.bot/start/getting-started)
   - [Contributing Guide](CONTRIBUTING.md)
   - [VSCode Setup README](.vscode.example/README.md)

2. **Configure the bot:**
   ```bash
   npm run clawdbot onboard
   ```

3. **Start developing:**
   - Set breakpoints in code
   - Modify and test
   - Use `npm run gateway:watch` for auto-reload

## VSCode Documentation

Detailed VSCode configuration documentation:
- [README.md](.vscode.example/README.md) - English
- [README-PL.md](.vscode.example/README-PL.md) - Polish

## Help

If you have issues:
1. Run: `bash scripts/verify-vscode-ready.sh`
2. Read Troubleshooting section
3. Check [GitHub Issues](https://github.com/clawdbot/clawdbot/issues)
4. Join [Discord](https://discord.gg/clawd)

---

**Status:** ✅ Bot is ready to run in Visual Studio Code!
