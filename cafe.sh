#!/bin/bash

ALLOW_DISPLAY_SLEEP=false
QUIET=false
VERSION="v1.0"

show_help() {
  echo "Usage: $(basename "$0") [OPTIONS]"
  echo
  echo "Cafe $VERSION"
  echo "Prevent macOS from sleeping using caffeinate."
  echo
  echo "Options:"
  echo "  -D,--allow-display-sleep   Allow the display to sleep while keeping the system awake"
  echo "  -h,--help              Show this help message and exit"
  echo "  -q,--quiet,--no-banner suppresses informational output but still prints errors to stderr."
  echo
}

# Parse arguments
for arg in "$@"; do
  case $arg in
    -D|--allow-display-sleep)
      ALLOW_DISPLAY_SLEEP=true
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    -q|--quiet|--no-banner)
      QUIET=true
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Try '--help' for more information."
      exit 1
      ;;
  esac
done

if [ "$QUIET" = false ]; then
echo "Going to the Cafe and picking up some coffee...."
fi

if [ "$ALLOW_DISPLAY_SLEEP" = true ]; then
  FLAGS="-isu"
  MODE="Display sleep: allowed"
else
  FLAGS="-disu"
  MODE="Display sleep: prevented"
fi

if [ "$QUIET" = false ]; then
printf "\n"
echo "I got a coffee with the flavor of:"
echo "\"$MODE\"."
printf "\n"
echo "What an odd flavor!"
printf "\n\n"
echo "Chugging the coffee down....."
fi


caffeinate $FLAGS > /dev/null 2>&1 &

if [ "$QUIET" = false ]; then
printf "\n\n"
echo "I am ready to go all day and all night long!"
echo 'Kill the "caffeinate" command for me to regain sleeping ability!'
fi
