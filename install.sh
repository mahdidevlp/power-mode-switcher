#!/bin/bash

# Power Mode Switcher Installation Script
# Installs the power mode switcher script system-wide

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

SCRIPT_NAME="power_mode_switcher.sh"
INSTALL_PATH="/usr/local/bin/power-mode-switcher"
CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Power Mode Switcher Installation Script${NC}"
echo "========================================"
echo

# Check if script exists
if [[ ! -f "$CURRENT_DIR/$SCRIPT_NAME" ]]; then
    echo -e "${RED}Error: $SCRIPT_NAME not found in current directory${NC}"
    echo "Please run this script from the project directory."
    exit 1
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${YELLOW}Running as root - proceeding with installation${NC}"
else
    echo -e "${YELLOW}This script requires root privileges to install system-wide${NC}"
    echo "Please run: sudo $0"
    exit 1
fi

# Check if powerprofilesctl is available
if ! command -v powerprofilesctl &> /dev/null; then
    echo -e "${RED}Warning: powerprofilesctl is not available${NC}"
    echo -e "${YELLOW}You may need to install power-profiles-daemon:${NC}"
    echo "  Ubuntu/Debian: sudo apt install power-profiles-daemon"
    echo "  Fedora: sudo dnf install power-profiles-daemon"
    echo
    read -p "Continue anyway? (y/N): " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Create backup if file already exists
if [[ -f "$INSTALL_PATH" ]]; then
    echo -e "${YELLOW}Existing installation found. Creating backup...${NC}"
    cp "$INSTALL_PATH" "$INSTALL_PATH.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${GREEN}Backup created${NC}"
fi

# Install the script
echo -e "${BLUE}Installing power mode switcher...${NC}"
cp "$CURRENT_DIR/$SCRIPT_NAME" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

# Verify installation
if [[ -f "$INSTALL_PATH" && -x "$INSTALL_PATH" ]]; then
    echo -e "${GREEN}✓ Installation successful!${NC}"
    echo
    echo -e "${BLUE}Usage:${NC}"
    echo "  power-mode-switcher --status      Show current status"
    echo "  power-mode-switcher --toggle      Toggle between profiles"
    echo "  power-mode-switcher --help        Show help"
    echo
    echo -e "${BLUE}Testing installation...${NC}"
    if "$INSTALL_PATH" --help > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Installation test passed${NC}"
    else
        echo -e "${RED}✗ Installation test failed${NC}"
        exit 1
    fi
else
    echo -e "${RED}✗ Installation failed${NC}"
    exit 1
fi

echo
echo -e "${GREEN}Power Mode Switcher is now installed system-wide!${NC}"
echo "You can now use 'power-mode-switcher' from anywhere in your terminal."
