---
description: Test and configure MX Master 4 haptic feedback
disable-model-invocation: true
---

# Haptic Feedback — Test & Config

## Test connection

Run this to verify HapticWebPlugin is running:

```bash
curl https://local.jmw.nz:41443/
```

## Trigger a test vibration

```bash
curl -X POST -d '' https://local.jmw.nz:41443/haptic/completed
```

## List available waveforms

```bash
curl https://local.jmw.nz:41443/waveforms
```

## Change waveform

Set the `HAPTIC_WAVEFORM` environment variable before starting Claude Code:

```bash
export HAPTIC_WAVEFORM=happy_alert
claude
```

Available: `completed`, `happy_alert`, `knock`, `firework`, `sharp_collision`, `ringing`, `jingle`, `mad`, `damp_collision`, `subtle_collision`, `sharp_state_change`, `damp_state_change`, `angry_alert`, `wave`, `square`
