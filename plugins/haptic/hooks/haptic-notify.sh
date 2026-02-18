#!/bin/bash
# Claude Code hook — triggers MX Master 4 haptic feedback via HapticWebPlugin
#
# Reads hook JSON from stdin (unused — we just fire the haptic).
# Runs curl in background so it never blocks Claude Code.
#
# Configuration (env vars):
#   HAPTIC_HOST      — HapticWebPlugin URL (default: https://local.jmw.nz:41443)
#   HAPTIC_WAVEFORM  — waveform name (default: completed)
#
# Available waveforms:
#   sharp_collision, damp_collision, subtle_collision,
#   sharp_state_change, damp_state_change, completed,
#   knock, ringing, jingle, mad, firework,
#   happy_alert, angry_alert, wave, square

HAPTIC_HOST="${HAPTIC_HOST:-https://local.jmw.nz:41443}"
HAPTIC_WAVEFORM="${HAPTIC_WAVEFORM:-completed}"

# Fire and forget — don't block Claude Code
curl -s -X POST -d '' \
  --connect-timeout 1 \
  --max-time 2 \
  "${HAPTIC_HOST}/haptic/${HAPTIC_WAVEFORM}" \
  > /dev/null 2>&1 &

exit 0
