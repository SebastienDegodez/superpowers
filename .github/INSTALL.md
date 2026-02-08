# Superpowers for Claude Code (Copilot Plugin System)

Complete guide for installing Superpowers via the Copilot plugin system.

## Quick Install

Run the automated installer:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.github/install-copilot.sh)
```

Or download and review first:

```bash
curl -fsSL https://raw.githubusercontent.com/obra/superpowers/main/.github/install-copilot.sh -o install-copilot.sh
chmod +x install-copilot.sh
./install-copilot.sh
```

## Manual Installation

### Prerequisites

- [Copilot CLI](https://github.com/obra/copilot-cli) installed and configured
- `jq` installed (for JSON processing)
  - macOS: `brew install jq`
  - Linux: `apt-get install jq` or `yum install jq`

### Installation Steps

```bash
# 1. Add the Superpowers marketplace
copilot plugin marketplace add obra/superpowers-marketplace

# 2. Install the Superpowers plugin
copilot plugin install superpowers@superpowers-marketplace

# 3. Configure SessionStart hook
mkdir -p .github/hooks

# Create hooks.json (or merge if it exists)
cat > .github/hooks/hooks.json << 'EOF'
{
  "SessionStart": [
    {
      "matcher": "startup|resume|clear|compact",
      "command": "bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh",
      "async": true
    }
  ]
}
EOF
```

**Note:** If `.github/hooks/hooks.json` already exists, manually add the SessionStart entry to avoid overwriting existing hooks.

### Verify Installation

```bash
# Check plugin is installed
copilot plugin list

# Expected output includes:
# superpowers@superpowers-marketplace (v4.3.1)

# Verify hooks configuration
cat .github/hooks/hooks.json | jq '.'

# Check plugin directory exists
ls -la ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/
```

## Dry-Run Mode

Test the installation without making changes:

```bash
./install-copilot.sh --dry-run
```

This shows:
- Detection results (CLI, jq, marketplace)
- Installation plan
- Hooks configuration preview
- **No actual changes are made**

## How It Works

### Plugin System Architecture

**Plugin Location:** `~/.copilot/installed-plugins/{marketplace-name}/{plugin-name}/`

The Copilot plugin system:
1. Downloads plugins from GitHub marketplace repositories
2. Installs to `~/.copilot/installed-plugins/`
3. Automatically handles versioning and updates
4. Integrates with Copilot's hook system

**Superpowers Installation:**
- **Marketplace:** `obra/superpowers-marketplace`
- **Plugin:** `superpowers@superpowers-marketplace`
- **Install Path:** `~/.copilot/installed-plugins/superpowers-marketplace/superpowers/`
- **Content:** 14 skills + hooks + agents

### Hooks System

**Hook File:** `.github/hooks/hooks.json`

The SessionStart hook executes on:
- Startup (new session)
- Resume (after suspension)
- Clear (context cleared)
- Compact (context compacted)

**Hook Configuration:**
```json
{
  "SessionStart": [
    {
      "matcher": "startup|resume|clear|compact",
      "command": "bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh",
      "async": true
    }
  ]
}
```

The hook script (`session-start.sh`) initializes Superpowers by:
1. Loading skill metadata
2. Injecting context about available skills
3. Setting up tool mappings
4. Displaying welcome message

### Marketplace Auto-Detection

The installer automatically detects your marketplace configuration by:
1. Running `copilot plugin marketplace list`
2. Parsing GitHub repository information
3. Extracting marketplace short name (e.g., "superpowers-marketplace")
4. Configuring installation paths accordingly

No hardcoded paths - adapts to your marketplace setup.

## Usage

### Available Skills

After installation, 14 skills are available:

- `brainstorming` - Creative problem solving
- `dispatching-parallel-agents` - Multi-agent orchestration
- `executing-plans` - Structured plan execution
- `finishing-a-development-branch` - Branch completion workflows
- `receiving-code-review` - Code review processing
- `requesting-code-review` - Code review requests
- `subagent-driven-development` - SDD workflow
- `systematic-debugging` - Advanced debugging strategies
- `test-driven-development` - TDD best practices
- `using-git-worktrees` - Git worktree workflows
- `using-superpowers` - Core usage guide
- `verification-before-completion` - Quality checks
- `writing-plans` - Plan creation
- `writing-skills` - Skill authoring

### Skill Activation

Skills are automatically discovered and loaded based on their YAML frontmatter descriptions. Simply describe your task in natural language - Copilot will activate relevant skills automatically.

**Manual Loading:**
```
Load the systematic-debugging skill
```

**Implicit Loading:**
```
Help me debug why this test fails intermittently
```
→ Automatically loads `systematic-debugging`

### Personal Skills

Create custom skills in your workspace:

```bash
mkdir -p skills/my-skill
```

Create `skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill instructions here]
```

## Updating

Update to the latest version:

```bash
copilot plugin update superpowers@superpowers-marketplace
```

Or update all plugins:

```bash
copilot plugin update --all
```

The hooks configuration remains unchanged during updates.

## Uninstalling

### Remove Plugin

```bash
copilot plugin uninstall superpowers@superpowers-marketplace
```

### Remove Hooks Configuration

Edit `.github/hooks/hooks.json` and remove the SessionStart entry for Superpowers.

Or delete the entire hooks file if it only contains Superpowers:

```bash
rm .github/hooks/hooks.json
```

### Remove Marketplace (Optional)

```bash
copilot plugin marketplace remove obra/superpowers-marketplace
```

## Troubleshooting

### CLI Not Found

**Symptom:** `copilot: command not found`

**Solution:**
1. Install Copilot CLI: https://github.com/obra/copilot-cli
2. Ensure it's in your PATH
3. Verify: `which copilot`

### jq Not Found

**Symptom:** `jq: command not found`

**Solution:**
- macOS: `brew install jq`
- Debian/Ubuntu: `sudo apt-get install jq`
- RHEL/CentOS: `sudo yum install jq`
- Windows: Download from https://stedolan.github.io/jq/

### Marketplace Not Found

**Symptom:** `Error: marketplace 'obra/superpowers-marketplace' not found`

**Solution:**
```bash
copilot plugin marketplace add obra/superpowers-marketplace
```

### Invalid Plugin Spec

**Symptom:** `Error: invalid plugin spec 'superpowers'`

**Solution:**
Use the full plugin spec with marketplace:
```bash
copilot plugin install superpowers@superpowers-marketplace
```

### Plugin Not Loading

**Solution:**
1. Verify installation:
   ```bash
   copilot plugin list
   ls -la ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/
   ```

2. Check hooks configuration:
   ```bash
   cat .github/hooks/hooks.json | jq '.'
   ```

3. Verify hook path matches marketplace:
   ```bash
   ls -la ~/.copilot/installed-plugins/*/superpowers/hooks/session-start.sh
   ```

4. Restart Copilot session

### Hooks Not Executing

**Symptom:** SessionStart hook not running on startup

**Solution:**
1. Verify hooks.json exists: `cat .github/hooks/hooks.json`
2. Check JSON syntax: `jq '.' .github/hooks/hooks.json`
3. Ensure absolute path in command (no `${VARIABLE}` placeholders)
4. Check hook script is executable: `ls -l ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh`
5. Test hook manually:
   ```bash
   bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh
   ```

### JSON Formatting Issues

**Symptom:** Malformed hooks.json, incorrect indentation

**Solution:**
Regenerate with proper formatting:
```bash
jq '.' .github/hooks/hooks.json > temp.json && mv temp.json .github/hooks/hooks.json
```

Or use the installer to merge properly:
```bash
./install-copilot.sh
```

### Multiple Marketplaces

**Symptom:** Plugin location mismatch with different marketplace

**Solution:**
The installer auto-detects your marketplace configuration. If you use a different marketplace:
1. Ensure marketplace is added: `copilot plugin marketplace list`
2. Install with correct spec: `superpowers@your-marketplace-name`
3. Update hooks.json path to match: `~/.copilot/installed-plugins/your-marketplace-name/superpowers/`

### Permission Issues

**Symptom:** Cannot create `.github/hooks/hooks.json`

**Solution:**
```bash
mkdir -p .github/hooks
chmod 755 .github/hooks
```

### Duplicate Hook Entries

**Symptom:** Multiple SessionStart entries for Superpowers

**Solution:**
Edit `.github/hooks/hooks.json` and remove duplicates. The installer prevents duplicates by checking for existing entries.

## Advanced Configuration

### Custom Hook Matcher

Edit `.github/hooks/hooks.json` to customize when hooks run:

```json
{
  "SessionStart": [
    {
      "matcher": "startup",
      "command": "bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh",
      "async": true
    }
  ]
}
```

Matcher options: `startup`, `resume`, `clear`, `compact`, or regex patterns.

### Synchronous Hooks

Remove `"async": true` to run hooks synchronously (blocks session start):

```json
{
  "matcher": "startup",
  "command": "bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh"
}
```

### Multiple Hooks

Combine Superpowers with other hooks:

```json
{
  "SessionStart": [
    {
      "matcher": "startup|resume",
      "command": "bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh",
      "async": true
    },
    {
      "matcher": "startup",
      "command": "bash .github/hooks/custom-init.sh",
      "async": false
    }
  ]
}
```

## Getting Help

- **Issues:** https://github.com/obra/superpowers/issues
- **Main Documentation:** https://github.com/obra/superpowers
- **Copilot CLI:** https://github.com/obra/copilot-cli

## Testing

Verify your installation works:

```bash
# 1. Check plugin installed
copilot plugin list | grep superpowers

# Expected: superpowers@superpowers-marketplace (v4.3.1)

# 2. Validate hooks configuration
jq '.SessionStart[] | select(.command | contains("superpowers"))' .github/hooks/hooks.json

# Expected: JSON object with your SessionStart hook

# 3. Test hook script manually
bash ~/.copilot/installed-plugins/superpowers-marketplace/superpowers/hooks/session-start.sh

# Expected: Welcome message and skill listing

# 4. Start new Copilot session
# The SessionStart hook should execute automatically
# Look for "🦸 Superpowers loaded: 14 skills available" or similar message
```

## Comparison: Plugin vs. Symlink Installation

### Plugin System (This Method)

**Advantages:**
- ✅ Managed versioning and updates
- ✅ Central installation (`~/.copilot/installed-plugins/`)
- ✅ Marketplace ecosystem
- ✅ Automatic dependency resolution
- ✅ Clean uninstall process

**Disadvantages:**
- ❌ Requires Copilot CLI
- ❌ Additional marketplace configuration
- ❌ Less control over file locations

### Symlink Installation (Legacy)

**Advantages:**
- ✅ Direct Git repository access
- ✅ Easy development workflow
- ✅ No CLI dependencies
- ✅ Full file system control

**Disadvantages:**
- ❌ Manual update process (`git pull`)
- ❌ Symlink management complexity
- ❌ Platform-specific setup (Windows junctions)
- ❌ No version management

**Recommendation:** Use plugin system for production use, symlink method for development.
