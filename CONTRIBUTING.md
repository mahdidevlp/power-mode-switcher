# Contributing to Power Mode Switcher

Thank you for your interest in contributing to Power Mode Switcher! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use the issue template** when creating new issues
3. **Provide detailed information**:
   - Linux distribution and version
   - Output of `powerprofilesctl list`
   - Error messages or logs
   - Steps to reproduce the issue

### Feature Requests

1. **Search existing issues** for similar requests
2. **Describe the feature** clearly and explain why it would be useful
3. **Consider the scope** - keep features focused and relevant
4. **Be open to discussion** about implementation approaches

### Code Contributions

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Write your code** following the style guidelines below
4. **Test your changes** on multiple distributions if possible
5. **Commit your changes** with clear, descriptive messages
6. **Push to your fork**: `git push origin feature/your-feature-name`
7. **Create a Pull Request** with a clear description

## 📋 Development Guidelines

### Code Style

- **Use bash best practices**
- **Follow existing code formatting**
- **Use meaningful variable names**
- **Add comments for complex logic**
- **Handle errors gracefully**
- **Use consistent indentation** (4 spaces)

### Script Structure

```bash
#!/bin/bash

# Brief description of what the script does
# Additional context if needed

# Global variables and constants
VARIABLE_NAME="value"

# Functions (in logical order)
function_name() {
    local variable="value"
    # Function implementation
}

# Main execution
main() {
    # Main logic
}

# Call main function
main "$@"
```

### Error Handling

- Always check command exit codes
- Provide meaningful error messages
- Use appropriate exit codes
- Validate input parameters

### Color Usage

Use the predefined color variables:
```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
```

## 🧪 Testing

### Manual Testing

1. **Test on different distributions** when possible
2. **Test all command-line options**
3. **Test error conditions**
4. **Verify help output**

### Test Cases

- Script runs without errors
- All options work as expected
- Error handling works correctly
- Help output is accurate and complete
- Script works with different power profiles

### Testing Environments

Priority testing environments:
1. Linux Mint (primary target)
2. Ubuntu 20.04+
3. Fedora 34+
4. Other GNOME-based distributions

## 📝 Documentation

### Code Comments

- Comment complex logic
- Explain non-obvious decisions
- Use TODO comments for known issues or planned improvements

### README Updates

- Update README.md for new features
- Add new command examples
- Update compatibility information
- Keep screenshots current

### Commit Messages

Follow conventional commit format:
```
type(scope): description

Examples:
feat: add GUI notification support
fix: resolve profile detection issue
docs: update installation instructions
refactor: improve error handling
test: add compatibility tests
```

## 🔧 Development Setup

### Prerequisites

```bash
# Install development tools
sudo apt install git bash shellcheck  # Ubuntu/Debian
sudo dnf install git bash ShellCheck  # Fedora

# Clone your fork
git clone https://github.com/yourusername/power-mode-switcher.git
cd power-mode-switcher
```

### Code Validation

Use ShellCheck to validate bash scripts:
```bash
shellcheck power_mode_switcher.sh
shellcheck install.sh
```

### Testing Your Changes

```bash
# Make script executable
chmod +x power_mode_switcher.sh

# Test basic functionality
./power_mode_switcher.sh --help
./power_mode_switcher.sh --status

# Test installation script
sudo ./install.sh
```

## 🎯 Areas for Contribution

### High Priority

- [ ] GUI version using zenity/kdialog
- [ ] Desktop environment integration
- [ ] Additional distribution testing
- [ ] Performance optimizations

### Medium Priority

- [ ] Battery percentage-based switching
- [ ] System tray indicator
- [ ] Notification support
- [ ] Configuration file support

### Low Priority

- [ ] Man page creation
- [ ] Package manager integration
- [ ] Custom profile creation
- [ ] Logging functionality

## 📞 Getting Help

### Communication Channels

1. **GitHub Issues** - For bugs and feature requests
2. **GitHub Discussions** - For questions and general discussion
3. **Pull Request Comments** - For code review and technical discussion

### Questions

If you have questions about:
- **Code structure**: Ask in the relevant pull request or issue
- **Feature decisions**: Open a GitHub discussion
- **Implementation details**: Comment on the specific code section

## 🏆 Recognition

Contributors will be recognized in:
- README.md acknowledgments section
- Release notes for significant contributions
- GitHub contributor statistics

## 📄 License

By contributing to Power Mode Switcher, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Power Mode Switcher! 🚀
