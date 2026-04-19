#!/bin/bash

QUIET=false
DISPLAY_SLEEP=false
FLAGS="-disu"
MODE="Display sleep: prevented"
PIDFILE="$HOME/.cafe-pid"

say() {
  [[ "$QUIET" == false ]] || return 0
  printf "%s\n" "$1"
}

show_help() {
  say "Usage: $(basename "$0") [OPTIONS]"
  say "Cafe - Prevent macOS from sleeping"
  say "Options:"
  say "  -D, --allow-display-sleep   Allow display sleep"
  say "  -h, --help                 Show help"
  say "  -k, --kill                 Stop caffeinate and exit"
  say "  -q, --quiet, --no-banner   Suppress output"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -D|--allow-display-sleep)
      DISPLAY_SLEEP=true
      MODE="Display sleep: allowed"
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    -k|--kill)
      say "☕ Closing up shop..."
      killall caffeinate 2>/dev/null
      exit 0
      ;;
    -q|--quiet|--no-banner)
      QUIET=true
      ;;
    *)
      say "Unknown option: $1"
      show_help
      exit 1
      ;;
  esac
  shift
done

killall caffeinate 2>/dev/null
say "☕ Cafe booting. . ."

if [[ "$DISPLAY_SLEEP" == true ]]; then
  FLAGS="-isu"
  MODE="Display sleep: allowed"
else
  FLAGS="-disu"
  MODE="Display sleep: prevented"
fi

say "Brewing: $MODE"
say "Flavor profile: Strong and black."

caffeinate $FLAGS > /dev/null 2>&1 &
PID=$!
say "Chugging. PID: $PID. Store at: $PIDFILE"

echo "$PID" > "$PIDFILE"
say "Ready for the grind, partner."
