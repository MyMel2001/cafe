#!/bin/bash

ALLOW_DISPLAY_SLEEP=false

show_help() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo
  echo "Prevent macOS from sleeping using caffeinate."
  echo
  echo "Options:"
  echo "  --allow-display-sleep   Allow the display to sleep while keeping the system awake"
  echo "  -h, --help              Show this help message and exit"
  echo
}

# Parse arguments
for arg in "$@"; do
  case $arg in
    --allow-display-sleep)
      ALLOW_DISPLAY_SLEEP=true
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Try '--help' for more information."
      exit 1
      ;;
  esac
done

# Choose flags
if [ "$ALLOW_DISPLAY_SLEEP" = true ]; then
  FLAGS="-isu"   # allow display sleep
else
  FLAGS="-disu"  # prevent display sleep
fi

caffeinate $FLAGS > /dev/null 2>&1 &

echo "Going to the Cafe and picking up some coffee...."
