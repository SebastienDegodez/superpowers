#!/usr/bin/env bash
set -e

# ==============================================================================
# 🦸 SUPERPOWERS FOR COPILOT - INSTALLER
# ==============================================================================
# This script installs Superpowers via the Copilot plugin system.
#
# WORKFLOW:
# 1. Detect if plugin is already installed via `copilot plugin list`
# 2. If not installed, add marketplace and install plugin via CLI commands
# 3. Patch workspace hooks.json to reference plugin installation
#
# LOCATION: ~/.copilot/installed-plugins/superpowers-dev/superpowers/
#
# USAGE:
#   ./install-copilot.sh           # Normal installation
#   ./install-copilot.sh --dry-run # Preview what would be done
#
# IDEMPOTENT: Run as often as needed, will skip if already installed.
# ==============================================================================

# --- CONFIGURATION ---
PLUGIN_NAME="superpowers"
DEFAULT_MARKETPLACE="obra/superpowers-marketplace"

# Plugin location will be determined dynamically based on detected marketplace
# Format: marketplace-name/plugin-name
PLUGIN_LOCATION=""
INSTALL_DIR=""

# Workspace Locations
HOOKS_DIR=".github/hooks"
HOOKS_FILE="$HOOKS_DIR/hooks.json"

# Marketplace will be auto-detected or use default
MARKETPLACE=""

# --- PARSE ARGUMENTS ---
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "🔍 DRY-RUN MODE: No changes will be made"
    echo ""
fi

# --- HELPER FUNCTIONS ---

# Execute or preview command
execute_or_preview() {
    local description="$1"
    shift
    
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY-RUN] Would execute: $*"
    else
        echo "  ▶ $description"
        "$@"
    fi
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Auto-detect marketplace that has superpowers plugin
detect_marketplace() {
    if ! command_exists copilot; then
        echo ""
        return 1
    fi
    
    # Try to list marketplaces
    if ! copilot plugin marketplace list >/dev/null 2>&1; then
        echo ""
        return 1
    fi
    
    local marketplace_list
    marketplace_list=$(copilot plugin marketplace list 2>&1 || true)
    
    # Look for "superpowers" in marketplace list
    # Format is typically: "  • marketplace-name (GitHub: owner/repo)"
    # We want to extract "owner/repo" from the GitHub part
    local detected
    detected=$(echo "$marketplace_list" | grep -i "superpowers" | sed -n 's/.*GitHub: \([^)]*\).*/\1/p' | head -n 1 || true)
    
    if [ -n "$detected" ]; then
        echo "$detected"
        return 0
    fi
    
    # Fallback: check if default marketplace exists in the list
    if echo "$marketplace_list" | grep -q "$DEFAULT_MARKETPLACE"; then
        echo "$DEFAULT_MARKETPLACE"
        return 0
    fi
    
    echo ""
    return 1
}

# Merge or create hooks.json with SessionStart hook
merge_hooks_json() {
    local hooks_file="$1"
    local session_start_hook="$2"
    
    # If file doesn't exist, create new one using jq for proper formatting
    if [ ! -f "$hooks_file" ]; then
        jq -n \
          --arg cmd "$session_start_hook" \
          '{
            "hooks": {
              "SessionStart": [
                {
                  "matcher": "startup|resume|clear|compact",
                  "hooks": [
                    {
                      "type": "command",
                      "command": $cmd,
                      "async": true
                    }
                  ]
                }
              ]
            }
          }'
        return 0
    fi
    
    # File exists - merge intelligently
    if command_exists jq; then
        # Create new hook structure
        local new_hook=$(jq -n \
          --arg cmd "$session_start_hook" \
          '{
            "matcher": "startup|resume|clear|compact",
            "hooks": [
              {
                "type": "command",
                "command": $cmd,
                "async": true
              }
            ]
          }')
        
        # Check if hooks.SessionStart already exists
        if jq -e '.hooks.SessionStart' "$hooks_file" >/dev/null 2>&1; then
            # SessionStart exists - check if our specific hook is already there
            local existing_command=$(jq -r '.hooks.SessionStart[].hooks[].command // empty' "$hooks_file" | grep -F "$session_start_hook" || true)
            
            if [ -n "$existing_command" ]; then
                # Our hook already exists - just return the file as-is
                jq '.' "$hooks_file"
            else
                # Add our hook to the SessionStart array
                jq --argjson new_hook "$new_hook" '.hooks.SessionStart += [$new_hook]' "$hooks_file"
            fi
        else
            # SessionStart doesn't exist - add it
            jq --argjson new_hook "$new_hook" '.hooks.SessionStart = [$new_hook]' "$hooks_file"
        fi
    else
        # Fallback without jq - basic merge
        echo "⚠️  Warning: jq not available - cannot merge hooks properly" >&2
        cat "$hooks_file"
        return 1
    fi
}

# --- HEADER ---
echo "🦸 Superpowers Installer for Copilot"
echo "====================================="
echo ""

# --- PHASE 1: DETECTION & PREREQUISITES ---
echo "📋 Phase 1: Detection & Prerequisites"
echo "──────────────────────────────────────"
echo ""

# Check if copilot CLI is available
if ! command_exists copilot; then
    echo "❌ Error: copilot CLI not found"
    echo ""
    echo "The 'copilot' command is required for installation."
    echo "Please ensure GitHub Copilot CLI is installed and in your PATH."
    echo ""
    exit 1
fi

echo "✓ copilot CLI found: $(command -v copilot)"

# Detect if plugin is already installed
echo ""
echo "Checking for existing installation..."
PLUGIN_INSTALLED=false

# Try to get plugin list
if copilot plugin list >/dev/null 2>&1; then
    PLUGIN_LIST=$(copilot plugin list 2>&1 || true)
    
    if echo "$PLUGIN_LIST" | grep -q "$PLUGIN_NAME"; then
        PLUGIN_INSTALLED=true
        echo "✓ Plugin '$PLUGIN_NAME' is already installed"
        
        # Verify installation directory exists
        if [ -d "$INSTALL_DIR" ]; then
            echo "✓ Installation directory verified: $INSTALL_DIR"
        else
            echo "⚠️  Warning: Plugin listed but directory not found at expected location"
            echo "   Expected: $INSTALL_DIR"
            echo "   This may indicate a different marketplace/version was used."
        fi
    else
        echo "○ Plugin '$PLUGIN_NAME' not found in plugin list"
    fi
else
    echo "⚠️  Warning: Could not query plugin list (copilot plugin list failed)"
    echo "   Will check installation directory directly..."
    
    # Fallback: Check directory existence
    if [ -d "$INSTALL_DIR" ]; then
        PLUGIN_INSTALLED=true
        echo "✓ Found installation at: $INSTALL_DIR"
    fi
fi

# Check if marketplace is configured
echo ""
echo "Checking marketplace configuration..."
MARKETPLACE_CONFIGURED=false

# First, try to detect existing marketplace with superpowers
DETECTED_MARKETPLACE=$(detect_marketplace)

if [ -n "$DETECTED_MARKETPLACE" ]; then
    MARKETPLACE="$DETECTED_MARKETPLACE"
    MARKETPLACE_CONFIGURED=true
    echo "✓ Detected marketplace: $MARKETPLACE"
else
    # No marketplace detected, will need to add default
    MARKETPLACE="$DEFAULT_MARKETPLACE"
    echo "○ No marketplace with superpowers detected"
    echo "  Will use default: $MARKETPLACE"
fi

# Set plugin location based on detected marketplace
# Extract marketplace short name (after last /)
MARKETPLACE_SHORT="${MARKETPLACE##*/}"
PLUGIN_LOCATION="$MARKETPLACE_SHORT/$PLUGIN_NAME"
INSTALL_DIR="$HOME/.copilot/installed-plugins/$PLUGIN_LOCATION"

echo "  Plugin location: $INSTALL_DIR"

# --- PHASE 2: INSTALLATION PLAN ---
echo ""
echo "📦 Phase 2: Installation Plan"
echo "──────────────────────────────────────"
echo ""

ACTIONS_NEEDED=()

if [ "$MARKETPLACE_CONFIGURED" = false ]; then
    ACTIONS_NEEDED+=("add-marketplace")
fi

if [ "$PLUGIN_INSTALLED" = false ]; then
    ACTIONS_NEEDED+=("install-plugin")
fi

# Always need to configure hooks (even if plugin exists)
if [ ! -f "$HOOKS_FILE" ]; then
    ACTIONS_NEEDED+=("create-hooks")
elif ! grep -q "$INSTALL_DIR" "$HOOKS_FILE" 2>/dev/null; then
    ACTIONS_NEEDED+=("update-hooks")
fi

# Display plan
if [ ${#ACTIONS_NEEDED[@]} -eq 0 ]; then
    echo "✅ Everything is already configured!"
    echo ""
    echo "Plugin location: $INSTALL_DIR"
    echo "Hooks file: $HOOKS_FILE"
    echo ""
    echo "No actions needed."
    exit 0
fi

echo "The following actions will be performed:"
echo ""

for action in "${ACTIONS_NEEDED[@]}"; do
    case "$action" in
        add-marketplace)
            echo "  • Add marketplace: $MARKETPLACE"
            ;;
        install-plugin)
            echo "  • Install plugin: $PLUGIN_NAME"
            echo "    Target: $INSTALL_DIR"
            ;;
        create-hooks)
            echo "  • Create hooks configuration: $HOOKS_FILE"
            ;;
        update-hooks)
            echo "  • Update hooks configuration: $HOOKS_FILE"
            ;;
    esac
done

echo ""
echo "Plugin will be installed to: $INSTALL_DIR"
echo "Hooks will reference this path"
echo ""

# Confirm unless dry-run
if [ "$DRY_RUN" = false ]; then
    if [[ -t 0 ]]; then
        echo -n "✅ Proceed with installation? (Y/n): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]] && [ -n "$response" ]; then
            echo "Cancelled."
            exit 0
        fi
    fi
fi

# --- PHASE 3: EXECUTION ---
echo ""
echo "🔨 Phase 3: Execution"
echo "──────────────────────────────────────"
echo ""

# Execute actions
for action in "${ACTIONS_NEEDED[@]}"; do
    case "$action" in
        add-marketplace)
            echo "Adding marketplace..."
            execute_or_preview "Add marketplace $MARKETPLACE" \
                copilot plugin marketplace add "$MARKETPLACE"
            echo ""
            ;;
            
        install-plugin)
            echo "Installing plugin..."
            
            # Extract marketplace short name (after last /)
            MARKETPLACE_SHORT="${MARKETPLACE##*/}"
            
            # Install using plugin@marketplace format
            execute_or_preview "Install plugin $PLUGIN_NAME@$MARKETPLACE_SHORT" \
                copilot plugin install "$PLUGIN_NAME@$MARKETPLACE_SHORT"
            echo ""
            
            # Verify installation
            if [ "$DRY_RUN" = false ]; then
                if [ -d "$INSTALL_DIR" ]; then
                    echo "✓ Installation verified: $INSTALL_DIR"
                else
                    echo "⚠️  Warning: Plugin installed but not found at expected location"
                    echo "   Expected: $INSTALL_DIR"
                    echo "   Actual location may differ. Check with: copilot plugin list"
                fi
                echo ""
            fi
            ;;
            
        create-hooks|update-hooks)
            echo "Configuring hooks..."
            
            # Create directory if needed
            if [ ! -d "$HOOKS_DIR" ]; then
                if [ "$DRY_RUN" = true ]; then
                    echo "  [DRY-RUN] Would create directory: $HOOKS_DIR"
                else
                    mkdir -p "$HOOKS_DIR"
                    echo "  ✓ Created directory: $HOOKS_DIR"
                fi
            fi
            
            # Backup existing file if present
            if [ -f "$HOOKS_FILE" ] && [ "$DRY_RUN" = false ]; then
                backup_file="${HOOKS_FILE}.backup-$(date +%Y%m%d-%H%M%S)"
                cp "$HOOKS_FILE" "$backup_file"
                echo "  ✓ Backed up existing hooks to: $backup_file"
            fi
            
            # Merge or create hooks.json
            SESSION_START_HOOK="$INSTALL_DIR/hooks/session-start.sh"
            
            if [ "$DRY_RUN" = true ]; then
                echo "  [DRY-RUN] Would merge/create hooks.json"
                if [ -f "$HOOKS_FILE" ]; then
                    echo "  [DRY-RUN] Existing hooks.json detected - would merge SessionStart hook"
                    echo "  [DRY-RUN] SessionStart hook path: $SESSION_START_HOOK"
                    if command_exists jq; then
                        echo "  [DRY-RUN] Using jq for intelligent merge (preserves existing hooks)"
                    else
                        echo "  [DRY-RUN] ⚠️  jq not available - basic merge only"
                    fi
                else
                    echo "  [DRY-RUN] Would create new hooks.json with SessionStart"
                fi
                echo "  [DRY-RUN] Preview of SessionStart hook:"
                echo "    Command: $SESSION_START_HOOK"
                echo "    Matcher: startup|resume|clear|compact"
            else
                # Generate merged content
                MERGED_CONTENT=$(merge_hooks_json "$HOOKS_FILE" "$SESSION_START_HOOK")
                
                # Validate it's proper JSON before writing
                if command_exists jq; then
                    if echo "$MERGED_CONTENT" | jq empty 2>/dev/null; then
                        echo "$MERGED_CONTENT" > "$HOOKS_FILE"
                        echo "  ✓ Hooks merged/created: $HOOKS_FILE"
                        
                        # Show what was done
                        if jq -e '.hooks.SessionStart' "$HOOKS_FILE" >/dev/null 2>&1; then
                            session_start_count=$(jq '.hooks.SessionStart | length' "$HOOKS_FILE")
                            echo "  ✓ SessionStart: $session_start_count hook(s) configured"
                        fi
                        
                        # Show all hook types configured
                        other_hooks=$(jq -r '.hooks | keys[] | select(. != "SessionStart")' "$HOOKS_FILE" 2>/dev/null || true)
                        if [ -n "$other_hooks" ]; then
                            echo "  ✓ Other hooks preserved: $(echo "$other_hooks" | tr '\n' ',' | sed 's/,$//')"
                        fi
                    else
                        echo "  ✗ Error: Generated JSON is invalid"
                        exit 1
                    fi
                else
                    # No jq available - write and hope for the best
                    echo "$MERGED_CONTENT" > "$HOOKS_FILE"
                    echo "  ✓ Hooks configured: $HOOKS_FILE"
                    echo "  ⚠️  Warning: jq not available - JSON validation skipped"
                fi
                
                echo "  ✓ Path: $SESSION_START_HOOK"
            fi
            echo ""
            ;;
    esac
done

# --- PHASE 4: SUMMARY ---
echo ""
echo "✅ INSTALLATION COMPLETE"
echo "═══════════════════════════════════════════════════════════════"
echo ""

if [ "$DRY_RUN" = true ]; then
    echo "🔍 DRY-RUN SUMMARY"
    echo ""
    echo "The following would have been configured:"
    echo ""
else
    echo "🎉 Superpowers is now installed!"
    echo ""
fi

echo "📍 Plugin Location"
echo "   $INSTALL_DIR"
echo ""

echo "🔗 Hooks Configuration"
echo "   $HOOKS_FILE"
echo "   → References: $INSTALL_DIR/hooks/session-start.sh"
echo ""

if [ "$DRY_RUN" = false ]; then
    echo "👉 NEXT STEPS"
    echo ""
    echo "1. Reload your Copilot session to activate hooks"
    echo "2. Start a new conversation to see Superpowers in action"
    echo "3. Verify installation with: copilot plugin list"
    echo ""
    echo "💡 To update in the future, run:"
    echo "   copilot plugin update $PLUGIN_NAME"
    echo ""
else
    echo "💡 To perform the installation, run without --dry-run:"
    echo "   ./install-copilot.sh"
    echo ""
fi

echo "✨ Done!"
