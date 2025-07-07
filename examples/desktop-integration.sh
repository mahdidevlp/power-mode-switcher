#!/bin/bash

# Desktop Integration Example for Power Mode Switcher
# This script demonstrates GUI integration using zenity

SCRIPT_PATH="/usr/local/bin/power-mode-switcher"

# Check if zenity is available
if ! command -v zenity &> /dev/null; then
    echo "zenity is required for GUI integration"
    echo "Install it with: sudo apt install zenity"
    exit 1
fi

# Check if power-mode-switcher is installed
if [[ ! -f "$SCRIPT_PATH" ]]; then
    zenity --error --text="Power Mode Switcher is not installed.\nPlease run the installation script first."
    exit 1
fi

# Get current status
CURRENT_STATUS=$("$SCRIPT_PATH" --status 2>&1)

# Show selection dialog
CHOICE=$(zenity --list \
    --title="Power Mode Switcher" \
    --text="Current Status:\n$CURRENT_STATUS\n\nChoose an action:" \
    --column="Action" \
    "Toggle Power Mode" \
    "Set Performance Mode" \
    "Set Balanced Mode" \
    "Set Power Saver Mode" \
    "Show Status" \
    --height=300 --width=400)

case "$CHOICE" in
    "Toggle Power Mode")
        RESULT=$("$SCRIPT_PATH" --toggle 2>&1)
        zenity --info --text="$RESULT" --title="Power Mode Switched"
        ;;
    "Set Performance Mode")
        RESULT=$("$SCRIPT_PATH" --profile performance 2>&1)
        zenity --info --text="$RESULT" --title="Performance Mode"
        ;;
    "Set Balanced Mode")
        RESULT=$("$SCRIPT_PATH" --profile balanced 2>&1)
        zenity --info --text="$RESULT" --title="Balanced Mode"
        ;;
    "Set Power Saver Mode")
        RESULT=$("$SCRIPT_PATH" --profile power-saver 2>&1)
        zenity --info --text="$RESULT" --title="Power Saver Mode"
        ;;
    "Show Status")
        STATUS=$("$SCRIPT_PATH" --status 2>&1)
        zenity --info --text="$STATUS" --title="Power Mode Status"
        ;;
    *)
        # User cancelled
        exit 0
        ;;
esac
