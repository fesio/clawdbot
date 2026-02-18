# VSCode Configuration for Clawdbot

This directory contains recommended VSCode configuration files for developing Clawdbot.

## Quick Setup

Copy these files to create your local VSCode workspace:

```bash
# From the project root
cp -r .vscode.example .vscode
```

Or use the setup script:

```bash
bash scripts/setup-vscode.sh
```

## What's Included

### `settings.json`
- TypeScript configuration
- File associations and exclusions
- Format on save
- Vitest integration
- Editor preferences

### `launch.json`
Debug configurations for:
- **Debug Gateway**: Run and debug the gateway server
- **Debug CLI**: Run and debug any CLI command
- **Debug Agent**: Run and debug the AI agent
- **Debug Tests**: Run and debug test files
- **Debug Current Test File**: Debug the currently open test file

### `tasks.json`
VSCode tasks for common operations:
- **Build**: Compile TypeScript (Cmd/Ctrl+Shift+B)
- **Build and Watch**: Compile with auto-reload
- **Lint**: Run oxlint on source code
- **Format**: Auto-format code with oxfmt
- **Test**: Run all tests (Cmd/Ctrl+Shift+T)
- **Test Watch**: Run tests in watch mode
- **Start Gateway**: Start gateway in dev mode
- **Build UI**: Build the control UI
- **Clean and Rebuild**: Fresh build

### `extensions.json`
Recommended VSCode extensions:
- ESLint
- Prettier
- Vitest Explorer
- GitLens
- Markdown support
- Path IntelliSense
- Spell checker
- And more...

## Usage

### Building the Project

1. **Install dependencies:**
   - Open Command Palette (Cmd/Ctrl+Shift+P)
   - Run task: "Install Dependencies"
   - Or use terminal: `npm install`

2. **Build TypeScript:**
   - Press Cmd/Ctrl+Shift+B (default build task)
   - Or run task: "Build"
   - Or use terminal: `npm run build`

### Running the Bot

1. **Start Gateway in Dev Mode:**
   - Run task: "Start Gateway"
   - Or use terminal: `npm run gateway:watch`
   - This auto-reloads on code changes

2. **Debug Gateway:**
   - Press F5 or go to Run & Debug panel
   - Select "Debug Gateway"
   - Set breakpoints in your code

### Testing

1. **Run All Tests:**
   - Press Cmd/Ctrl+Shift+T
   - Or run task: "Test"

2. **Debug a Test File:**
   - Open a test file (*.test.ts)
   - Press F5 or select "Debug Current Test File"
   - Set breakpoints as needed

3. **Watch Mode:**
   - Run task: "Test Watch"
   - Tests re-run on file changes

### Debugging

The debug configurations allow you to:

1. **Debug Gateway**: Full debugging of the gateway server
   - Set breakpoints in gateway code
   - Inspect variables
   - Step through code

2. **Debug CLI Commands**: Test any CLI command
   - When prompted, enter command like: `gateway status`
   - Debug the command execution

3. **Debug Agent**: Test AI agent functionality
   - Enter a message when prompted
   - Debug the agent's processing

## Keyboard Shortcuts

- **Build**: Cmd/Ctrl+Shift+B
- **Test**: Cmd/Ctrl+Shift+T
- **Debug**: F5
- **Command Palette**: Cmd/Ctrl+Shift+P
- **Quick Open**: Cmd/Ctrl+P

## Customization

Feel free to modify these files for your workflow:
- Add custom tasks
- Create new debug configurations
- Adjust editor settings
- Add more extensions

The `.vscode/` directory is gitignored, so your local changes won't be committed.

## Requirements

- **Node.js**: ≥22.12.0 (project requirement)
- **VSCode**: Latest stable version recommended
- **Extensions**: Install recommended extensions when prompted

## Troubleshooting

### "Cannot find module" errors
- Run task: "Install Dependencies"
- Or: `npm install` in terminal

### TypeScript errors
- Run task: "Build" to compile
- Check that `node_modules/typescript` is installed

### Tests not running
- Ensure Vitest extension is installed
- Check terminal for error messages

### Gateway won't start
- Check if port 18789 is already in use
- Run: `clawdbot gateway status`
- Stop existing instance: `clawdbot gateway stop`

## More Information

- [Contributing Guide](../CONTRIBUTING.md)
- [Documentation](https://docs.clawd.bot)
- [Getting Started](https://docs.clawd.bot/start/getting-started)
- [macOS Dev Setup](../docs/platforms/mac/dev-setup.md)
