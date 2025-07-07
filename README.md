# Power Mode Switcher for Linux

A simple and elegant bash script to switch between system power management profiles on Linux systems. Designed for Linux Mint but compatible with any Linux distribution that uses `power-profiles-daemon`.

## 🚀 Features

- **Easy Power Profile Switching**: Toggle between available system power profiles
- **Colorful Output**: Clean, color-coded terminal interface
- **Multiple Usage Modes**: Toggle, cycle, or set specific profiles
- **Smart Profile Detection**: Automatically detects available power profiles
- **Comprehensive Status Display**: Shows current profile with descriptions
- **Error Handling**: Robust error checking and user feedback

## 📋 Requirements

- Linux system with `power-profiles-daemon` installed
- Bash shell
- `powerprofilesctl` command available

### Supported Distributions

- ✅ Linux Mint
- ✅ Ubuntu 20.04+
- ✅ Fedora 34+
- ✅ GNOME-based distributions
- ✅ Most modern Linux distributions with systemd

## 📦 Installation

### Quick Install

```bash
# Clone the repository
git clone https://github.com/mahdidevlp/power-mode-switcher.git
cd power-mode-switcher

# Make the script executable
chmod +x power_mode_switcher.sh

# Run it
./power_mode_switcher.sh --help
```

### System-wide Installation (Optional)

```bash
# Copy to system-wide location
sudo cp power_mode_switcher.sh /usr/local/bin/power-mode-switcher

# Now you can use it from anywhere
power-mode-switcher --toggle
```

## 🎯 Usage

### Basic Commands

```bash
# Show current power profile status
./power_mode_switcher.sh --status

# Toggle between available profiles
./power_mode_switcher.sh --toggle

# Set specific power profile
./power_mode_switcher.sh --profile balanced
./power_mode_switcher.sh --profile power-saver
./power_mode_switcher.sh --profile performance

# Show help
./power_mode_switcher.sh --help
```

### Command Line Options

| Option | Description |
|--------|-------------|
| `-s, --status` | Show current power profile status |
| `-t, --toggle` | Toggle between available profiles |
| `-c, --cycle` | Cycle through common profiles (performance → balanced → power-saver) |
| `-p, --profile PROFILE` | Set specific power profile |
| `-h, --help` | Show help message |

### Power Profile Types

| Profile | Description | Use Case |
|---------|-------------|----------|
| **Performance** | Maximum CPU performance, higher power consumption | Gaming, video editing, intensive tasks |
| **Balanced** | Balance between performance and battery life | General daily use |
| **Power Saver** | Optimize for battery life, reduced performance | Extended battery life, light tasks |

## 🖼️ Screenshots

### Status Display
```
=== Power Management Status ===
Current Profile: balanced

Available Profiles:
  ● balanced (active)
    Balance between performance and battery life
  ○ power-saver
    Optimize for battery life, reduced performance
```

### Profile Switching
```
Switching from 'balanced' to 'power-saver'...
✓ Power profile set to: power-saver
  - Optimized for battery life
  - Reduced CPU performance
  - Best for extending battery life
```

## ⚙️ Advanced Usage

### Creating Keyboard Shortcuts

#### GNOME/Cinnamon Desktop Environment
1. Open System Settings → Keyboard → Shortcuts
2. Add custom shortcut:
   - **Name**: Toggle Power Mode
   - **Command**: `/path/to/power_mode_switcher.sh --toggle`
   - **Key**: `Ctrl+Alt+P` (or your preference)

#### KDE Plasma
1. Open System Settings → Shortcuts → Custom Shortcuts
2. Add new shortcut with the command above

### Integration with System Tray

You can integrate this with system tray tools like `zenity` for GUI notifications:

```bash
# Example wrapper script for GUI integration
#!/bin/bash
RESULT=$(./power_mode_switcher.sh --toggle 2>&1)
zenity --info --text="$RESULT" --title="Power Mode Switcher"
```

## 🔧 Configuration

### Customizing Profiles

If your system supports additional power profiles, the script will automatically detect them. You can extend the script by modifying the profile descriptions in the `show_status()` function.

### Adding Custom Profiles

```bash
# Check available profiles on your system
powerprofilesctl list

# The script will automatically work with any available profiles
```

## 🛠️ Troubleshooting

### Common Issues

1. **"powerprofilesctl is not available"**
   ```bash
   # Install power-profiles-daemon
   sudo apt install power-profiles-daemon  # Ubuntu/Debian
   sudo dnf install power-profiles-daemon  # Fedora
   ```

2. **"Permission denied"**
   ```bash
   # Make script executable
   chmod +x power_mode_switcher.sh
   ```

3. **"Profile not available"**
   - Check available profiles: `powerprofilesctl list`
   - Your system may not support all profile types

### Debug Mode

For troubleshooting, you can check the power-profiles-daemon status:

```bash
# Check daemon status
systemctl status power-profiles-daemon

# List available profiles
powerprofilesctl list

# Get current profile
powerprofilesctl get
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

### Development Setup

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

### Code Style

- Follow bash best practices
- Use meaningful variable names
- Add comments for complex logic
- Test on multiple distributions when possible

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Thanks to the `power-profiles-daemon` developers
- Inspired by the need for simple power management on Linux
- Built for the Linux Mint community

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/mahdidevlp/power-mode-switcher/issues) page
2. Create a new issue with:
   - Your Linux distribution and version
   - Output of `powerprofilesctl list`
   - Error messages or unexpected behavior

## 🗺️ Roadmap

- [ ] GUI version using zenity/kdialog
- [ ] Desktop environment integration
- [ ] Battery percentage-based automatic switching
- [ ] Custom profile creation support
- [ ] System tray indicator
- [ ] Notification support

---

**Made with ❤️ for the Linux community**
