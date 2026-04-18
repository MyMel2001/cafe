#!/bin/bash

ALLOW_DISPLAY_SLEEP=false
VERSION="v1.0"

show_help() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo
  echo "Cafe $VERSION"
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

echo "Going to the Cafe and picking up some coffee...."

if [ "$ALLOW_DISPLAY_SLEEP" = true ]; then
  FLAGS="-isu"
  MODE="Display sleep: allowed"
else
  FLAGS="-disu"
  MODE="Display sleep: prevented"
fi
echo.
echo.
echo "I got a coffee with the flavor of:"
echo "\"$MODE\"."
echo.
echo "What an odd flavor!"
echo.
echo.
echo "Chugging the coffee down....."
caffeinate $FLAGS > /dev/null 2>&1 &
echo.
echo.
echo "I am ready to go all day and all night long!"
echo 'Kill the "caffeinate" command for me to regain sleeping ability!'
