# Cross-Platform Dotfiles

A unified dotfiles repository that works across WSL, macOS, and Windows.

## Features

- 🐧 **Linux/WSL Support** - Ubuntu, Debian, WSL2
- 🍎 **macOS Support** - Intel and Apple Silicon
- 🪟 **Windows Support** - Wezterm configuration
- 🐟 **Fish Shell** - Modern shell with completions
- 🖥️ **Tmux** - Terminal multiplexer with vim navigation
- 🎨 **Catppuccin Theme** - Consistent theming across tools
- 📁 **eza** - Modern ls replacement with icons

## Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Structure

```
dotfiles/
├── common/          # Shared configs across platforms
│   └── fish/        # Fish shell configuration
├── linux/           # Linux/WSL specific configs
│   ├── .tmux.conf   # Tmux configuration
│   └── eza/         # eza themes and config
├── macos/           # macOS specific configs
├── windows/         # Windows specific configs
│   └── .wezterm.lua # Wezterm terminal config
└── scripts/         # Installation scripts
```

## Platform Detection

The install script automatically detects your platform and installs appropriate configurations:

- **Linux/WSL**: Fish, Tmux, eza with Catppuccin theming
- **macOS**: Fish, Tmux (Mac-optimized), eza via Homebrew
- **Windows**: Wezterm configuration (manual setup required)

## Manual Setup

### Windows (Wezterm)
```powershell
# Copy wezterm config to Windows user directory
copy dotfiles\windows\.wezterm.lua $env:USERPROFILE\.wezterm.lua
```

### macOS Dependencies
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages
brew install fish tmux eza
```

### Linux/WSL Dependencies
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install fish tmux curl

# Install eza
curl -L https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz
sudo mv eza /usr/local/bin/
```

## Customization

- **Fish Shell**: Edit `common/fish/config.fish`
- **Tmux**: Edit `linux/.tmux.conf` or `macos/.tmux.conf`
- **Themes**: Modify files in `common/fish/themes/`
- **eza**: Update `linux/eza/theme.yml`

## Backup

The installer automatically backs up existing configurations to `~/.dotfiles-backup/`.

## Contributing

Feel free to submit issues and pull requests to improve cross-platform compatibility.

## License

MIT License - feel free to use and modify for your personal setup.