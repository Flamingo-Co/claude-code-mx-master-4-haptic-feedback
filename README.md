# claude-code-mx-master-4-haptic-feedback 🖱️💥

A [Claude Code](https://code.claude.com) plugin that makes your **Logitech MX Master 4** vibrate when Claude finishes a task. Feel your AI work — no need to watch the screen.

```
Claude Code (Stop hook) → shell script → HapticWebPlugin (localhost) → Logi Options+ → MX Master 4 💥
```

## Quick Start

### 1. Install HapticWebPlugin

[HapticWebPlugin](https://github.com/Fallstop/HapticWebPlugin) is an open-source Logi Options+ plugin that exposes your mouse's haptic motor via a local HTTP API.

#### Option A: Via Logi Marketplace (Recommended)

1. Open **Logi Options+** → click your **MX Master 4**
2. Go to **Haptic Feedback** in the sidebar → open haptic settings
3. Click **Install and Uninstall Plugins**
4. Find **HapticWebPlugin** in the marketplace and install it

#### Option B: Manual Install

1. Download `HapticWeb.lplug4` from [HapticWebPlugin Releases](https://github.com/Fallstop/HapticWebPlugin/releases)
2. Double-click the file — Logi Options+ will prompt you to install
3. Click **Continue**

> **Note:** Double-click install may not work on all systems. If it doesn't, use the marketplace method above.

Verify it works:

```bash
# Health check
curl https://local.jmw.nz:41443/

# Test vibration — your mouse should buzz
curl -X POST -d '' https://local.jmw.nz:41443/haptic/completed
```

### 2. Install this Plugin

```bash
# Step 1: Add the marketplace
/plugin marketplace add Flamingo-Co/claude-code-mx-master-4-haptic-feedback

# Step 2: Install the plugin
/plugin install haptic@flamingo-haptic
```

Or for local development:

```bash
git clone https://github.com/Flamingo-Co/claude-code-mx-master-4-haptic-feedback.git
claude --plugin-dir ./claude-code-mx-master-4-haptic-feedback
```

### 3. Done

Ask Claude anything. When it finishes responding, your mouse vibrates. ✅

## Configuration

### Change the Waveform

Set `HAPTIC_WAVEFORM` before starting Claude Code:

```bash
export HAPTIC_WAVEFORM=happy_alert
claude
```

Or edit `hooks/haptic-notify.sh` directly.

### Available Waveforms

| Waveform | Feel | Category |
|----------|------|----------|
| `completed` | Satisfying "done" pulse | Progress |
| `happy_alert` | Cheerful double-tap | Progress |
| `knock` | Subtle single knock | Incoming events |
| `firework` | Celebratory burst | Progress |
| `sharp_collision` | Quick precise click | Precision |
| `ringing` | Attention-grabbing ring | Incoming events |
| `jingle` | Playful jingle | Incoming events |
| `mad` | Angry rumble | Progress |
| `angry_alert` | Strong warning | Progress |
| `wave` | Smooth wave | Progress |
| `square` | Sharp square pulse | Progress |

Full list: `curl https://local.jmw.nz:41443/waveforms`

### Change When It Fires

Edit `hooks/hooks.json` to use different lifecycle events:

| Event | When it fires |
|-------|--------------|
| `Stop` | Every time Claude finishes a response (default) |
| `TaskCompleted` | When a task is explicitly completed |
| `PostToolUse` | After every tool call (file edit, command, etc.) |
| `Notification` | When Claude sends a notification |

Example — fire only on task completion:

```json
{
  "hooks": {
    "TaskCompleted": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "$PLUGIN_DIR/hooks/haptic-notify.sh"
          }
        ]
      }
    ]
  }
}
```

### Disable Temporarily

```bash
# Inside Claude Code
/plugin disable haptic
```

## Requirements

- Logitech MX Master 4
- [Logi Options+](https://www.logitech.com/software/logi-options-plus.html) installed
- [HapticWebPlugin](https://github.com/Fallstop/HapticWebPlugin) installed (`.lplug4`)
- [Claude Code](https://code.claude.com) ≥ 1.0.33
- macOS or Windows

## How It Works

1. **Claude Code** finishes responding → fires the `Stop` hook
2. **Hook script** runs `curl` in the background (never blocks Claude)
3. **HapticWebPlugin** receives the HTTP POST on `localhost:41443`
4. **Logi Plugin Service** translates it to a haptic waveform command
5. **MX Master 4** motor activates → you feel the buzz

The whole chain takes ~50ms.

## Troubleshooting

**Mouse doesn't vibrate:**
- Check HapticWebPlugin: `curl https://local.jmw.nz:41443/`
- Logi Options+ must be running
- Mouse connected via USB or Logi Bolt (not regular Bluetooth)

**Hook doesn't fire:**
- Check plugin is loaded: `/plugin list` in Claude Code
- Test manually: `echo '{}' | ./hooks/haptic-notify.sh`

**Port 41443 conflict:**
- `lsof -ti:41443` to find what's using it
- Restart Logi Plugin Service

## Credits

- [HapticWebPlugin](https://github.com/Fallstop/HapticWebPlugin) by Fallstop — HTTP bridge to Logi haptic API
- [Logi Actions SDK](https://logitech.github.io/actions-sdk-docs/) — Logitech's plugin framework
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks) — Anthropic's hook system

## License

MIT — see [LICENSE](LICENSE)

---

Built by [Flamingo Co](https://github.com/Flamingo-Co) 🦩
