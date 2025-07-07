# Changelog

All notable changes to Power Mode Switcher will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-07

### Added
- Initial release of Power Mode Switcher
- Power profile switching functionality for Linux systems
- Support for balanced and power-saver modes
- Colorful terminal interface with status display
- Multiple usage options: toggle, cycle, and direct profile setting
- Comprehensive error handling and validation
- System-wide installation script
- Complete documentation and README
- Contributing guidelines
- MIT license
- Desktop integration example using zenity
- Automatic power profile detection

### Features
- **Status Display**: Shows current power profile with descriptions
- **Toggle Mode**: Switch between available power profiles
- **Cycle Mode**: Rotate through performance → balanced → power-saver
- **Direct Setting**: Set specific power profiles by name
- **Smart Detection**: Automatically detects available system profiles
- **Error Handling**: Robust validation and user feedback
- **Cross-Distribution**: Works with any Linux system using power-profiles-daemon

### Supported Systems
- Linux Mint
- Ubuntu 20.04+
- Fedora 34+
- GNOME-based distributions
- Most modern Linux distributions with systemd

### Command Line Options
- `-s, --status` - Show current power profile status
- `-t, --toggle` - Toggle between available profiles
- `-c, --cycle` - Cycle through common profiles
- `-p, --profile PROFILE` - Set specific power profile
- `-h, --help` - Show help message

---

## Future Releases

### Planned Features
- GUI version using zenity/kdialog
- Desktop environment integration
- Battery percentage-based automatic switching
- Custom profile creation support
- System tray indicator
- Notification support
