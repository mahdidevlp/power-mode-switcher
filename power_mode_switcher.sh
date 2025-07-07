#!/bin/bash

# Power Mode Switcher for Linux Mint
# Switches between system power management modes (Performance, Balanced, Power Saver)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if powerprofilesctl is available
check_power_profiles() {
    if ! command -v powerprofilesctl &> /dev/null; then
        echo -e "${RED}powerprofilesctl is not available on this system${NC}"
        echo -e "${YELLOW}You may need to install power-profiles-daemon${NC}"
        exit 1
    fi
}

# Get available power profiles
get_available_profiles() {
    powerprofilesctl list | grep -E "^\s*\*?\s*[a-zA-Z-]+:$" | sed 's/^\s*\*\?\s*//' | cut -d':' -f1
}

# Get current power profile
get_current_profile() {
    powerprofilesctl get 2>/dev/null
}

# Show current power status
show_status() {
    local current_profile=$(get_current_profile)
    local available_profiles=$(get_available_profiles)
    
    echo -e "${BLUE}=== Power Management Status ===${NC}"
    echo -e "Current Profile: ${GREEN}$current_profile${NC}"
    echo
    echo -e "${CYAN}Available Profiles:${NC}"
    
    # Show all available profiles with descriptions
    while read -r profile; do
        if [[ "$profile" == "$current_profile" ]]; then
            echo -e "  ${GREEN}● $profile${NC} (active)"
        else
            echo -e "  ○ $profile"
        fi
        
        # Add descriptions for each profile
        case $profile in
            "performance")
                echo -e "    ${YELLOW}Maximum CPU performance, higher power consumption${NC}"
                ;;
            "balanced")
                echo -e "    ${YELLOW}Balance between performance and battery life${NC}"
                ;;
            "power-saver")
                echo -e "    ${YELLOW}Optimize for battery life, reduced performance${NC}"
                ;;
        esac
    done <<< "$available_profiles"
    echo
}

# Set specific power profile
set_power_profile() {
    local target_profile="$1"
    local available_profiles=$(get_available_profiles)
    
    # Check if target profile is available
    if ! echo "$available_profiles" | grep -q "^$target_profile$"; then
        echo -e "${RED}Profile '$target_profile' is not available${NC}"
        echo -e "${YELLOW}Available profiles: $(echo "$available_profiles" | tr '\n' ' ')${NC}"
        exit 1
    fi
    
    powerprofilesctl set "$target_profile"
    if [[ $? -eq 0 ]]; then
        echo -e "${GREEN}✓ Power profile set to: $target_profile${NC}"
        
        # Show profile description
        case $target_profile in
            "performance")
                echo -e "${YELLOW}  - Maximum CPU performance${NC}"
                echo -e "${YELLOW}  - Higher power consumption${NC}"
                echo -e "${YELLOW}  - Best for demanding tasks${NC}"
                ;;
            "balanced")
                echo -e "${YELLOW}  - Balanced performance and efficiency${NC}"
                echo -e "${YELLOW}  - Good for general use${NC}"
                echo -e "${YELLOW}  - Default recommended setting${NC}"
                ;;
            "power-saver")
                echo -e "${YELLOW}  - Optimized for battery life${NC}"
                echo -e "${YELLOW}  - Reduced CPU performance${NC}"
                echo -e "${YELLOW}  - Best for extending battery life${NC}"
                ;;
        esac
    else
        echo -e "${RED}✗ Failed to set power profile to: $target_profile${NC}"
        exit 1
    fi
}

# Toggle between power profiles
toggle_power_profile() {
    local current_profile=$(get_current_profile)
    local available_profiles=$(get_available_profiles)
    local profile_array=()
    
    # Convert available profiles to array
    while read -r profile; do
        profile_array+=("$profile")
    done <<< "$available_profiles"
    
    # Find current profile index
    local current_index=-1
    for i in "${!profile_array[@]}"; do
        if [[ "${profile_array[$i]}" == "$current_profile" ]]; then
            current_index=$i
            break
        fi
    done
    
    # Calculate next profile index
    local next_index=$(( (current_index + 1) % ${#profile_array[@]} ))
    local next_profile="${profile_array[$next_index]}"
    
    echo -e "${BLUE}Switching from '$current_profile' to '$next_profile'...${NC}"
    set_power_profile "$next_profile"
}

# Cycle through specific profiles (performance -> balanced -> power-saver -> performance)
cycle_common_profiles() {
    local current_profile=$(get_current_profile)
    local next_profile
    
    case $current_profile in
        "performance")
            next_profile="balanced"
            ;;
        "balanced")
            next_profile="power-saver"
            ;;
        "power-saver")
            next_profile="performance"
            ;;
        *)
            next_profile="balanced"
            ;;
    esac
    
    # Check if next profile is available
    local available_profiles=$(get_available_profiles)
    if ! echo "$available_profiles" | grep -q "^$next_profile$"; then
        echo -e "${YELLOW}Profile '$next_profile' not available, using toggle instead${NC}"
        toggle_power_profile
        return
    fi
    
    echo -e "${BLUE}Cycling from '$current_profile' to '$next_profile'...${NC}"
    set_power_profile "$next_profile"
}

# Show help
show_help() {
    echo -e "${BLUE}Power Mode Switcher${NC}"
    echo
    echo "Usage: $0 [OPTION] [PROFILE]"
    echo
    echo "Options:"
    echo "  -s, --status           Show current power profile status"
    echo "  -t, --toggle           Toggle between available profiles"
    echo "  -c, --cycle            Cycle through common profiles (performance → balanced → power-saver)"
    echo "  -p, --profile PROFILE  Set specific power profile"
    echo "  -h, --help             Show this help message"
    echo
    echo "Common Profiles:"
    echo "  performance            Maximum CPU performance"
    echo "  balanced               Balance between performance and battery life"
    echo "  power-saver            Optimize for battery life"
    echo
    echo "Examples:"
    echo "  $0 --status                    Show current status"
    echo "  $0 --toggle                    Toggle between profiles"
    echo "  $0 --cycle                     Cycle through common profiles"
    echo "  $0 --profile performance       Set to performance mode"
    echo "  $0 --profile balanced          Set to balanced mode"
    echo "  $0 --profile power-saver       Set to power-saver mode"
}

# Main function
main() {
    check_power_profiles
    
    case "${1:-}" in
        -s|--status)
            show_status
            ;;
        -t|--toggle)
            toggle_power_profile
            echo
            show_status
            ;;
        -c|--cycle)
            cycle_common_profiles
            echo
            show_status
            ;;
        -p|--profile)
            if [[ -z "$2" ]]; then
                echo -e "${RED}Error: Profile name required${NC}"
                echo "Usage: $0 --profile <profile_name>"
                exit 1
            fi
            set_power_profile "$2"
            echo
            show_status
            ;;
        -h|--help)
            show_help
            ;;
        "")
            show_status
            echo "Use --help for usage information"
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
