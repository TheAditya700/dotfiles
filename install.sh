#!/bin/bash

# Cross-Platform Dotfiles Installer
# Supports Linux, macOS, and Windows (WSL)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    case "$(uname -s)" in
        Linux*)     
            if grep -q Microsoft /proc/version; then
                OS="wsl"
            else
                OS="linux"
            fi
            ;;
        Darwin*)   OS="macos" ;;
        CYGWIN*|MINGW*|MSYS*) OS="windows" ;;
        *)        
            print_error "Unsupported OS: $(uname -s)"
            exit 1
            ;;
    esac
    print_status "Detected OS: $OS"
}

# Create backup directory
create_backup() {
    BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    print_status "Created backup directory: $BACKUP_DIR"
}

# Backup existing file
backup_file() {
    local file="$1"
    if [ -f "$file" ] || [ -d "$file" ]; then
        cp -r "$file" "$BACKUP_DIR/"
        print_status "Backed up: $file"
    fi
}

# Install dependencies based on platform
install_dependencies() {
    print_status "Installing dependencies for $OS..."
    
    case $OS in
        "linux"|"wsl")
            # Check if we're on Ubuntu/Debian
            if command -v apt >/dev/null 2>&1; then
                print_status "Installing packages with apt..."
                sudo apt update
                sudo apt install -y fish tmux curl git
            elif command -v dnf >/dev/null 2>&1; then
                print_status "Installing packages with dnf..."
                sudo dnf install -y fish tmux curl git
            fi
            
            # Install eza
            if ! command -v eza >/dev/null 2>&1; then
                print_status "Installing eza..."
                curl -L https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz
                sudo mv eza /usr/local/bin/
            fi
            ;;
            
        "macos")
            # Install Homebrew if not present
            if ! command -v brew >/dev/null 2>&1; then
                print_status "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            
            print_status "Installing packages with Homebrew..."
            brew install fish tmux eza
            ;;
            
        "windows")
            print_warning "Windows detected. Please install dependencies manually:"
            echo "- Wezterm: https://wezfurlong.org/wezterm/"
            echo "- WSL with Ubuntu: https://aka.ms/wslubuntu"
            echo "- Then run this installer from within WSL"
            return
            ;;
    esac
}

# Setup Fish shell
setup_fish() {
    print_status "Setting up Fish shell..."
    
    # Create fish config directory
    mkdir -p "$HOME/.config/fish"
    
    # Backup existing fish config
    backup_file "$HOME/.config/fish/config.fish"
    backup_file "$HOME/.config/fish/fish_plugins"
    
    # Copy fish configuration
    cp "$SCRIPT_DIR/common/fish/config.fish" "$HOME/.config/fish/"
    cp "$SCRIPT_DIR/common/fish/fish_plugins" "$HOME/.config/fish/"
    
    # Copy themes
    mkdir -p "$HOME/.config/fish/themes"
    cp -r "$SCRIPT_DIR/common/fish/themes/"* "$HOME/.config/fish/themes/"
    
    # Install fish plugins if fisher is available
    if command -v fish >/dev/null 2>&1; then
        print_status "Installing Fish plugins..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
        fish -c "fisher update"
    fi
    
    print_success "Fish shell configured"
}

# Setup Tmux
setup_tmux() {
    print_status "Setting up Tmux..."
    
    # Determine which tmux config to use
    local tmux_config="$SCRIPT_DIR/linux/.tmux.conf"
    if [ "$OS" = "macos" ] && [ -f "$SCRIPT_DIR/macos/.tmux.conf" ]; then
        tmux_config="$SCRIPT_DIR/macos/.tmux.conf"
    fi
    
    # Backup existing tmux config
    backup_file "$HOME/.tmux.conf"
    
    # Copy tmux configuration
    cp "$tmux_config" "$HOME/.tmux.conf"
    
    # Install tmux plugin manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        print_status "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
    
    print_success "Tmux configured"
}

# Setup eza
setup_eza() {
    print_status "Setting up eza..."
    
    # Only setup eza for Linux/macOS
    if [ "$OS" = "windows" ]; then
        print_warning "eza setup skipped on Windows"
        return
    fi
    
    # Create eza config directory
    mkdir -p "$HOME/.config/eza"
    
    # Backup existing eza config
    backup_file "$HOME/.config/eza/theme.yml"
    backup_file "$HOME/.config/eza/catppuccin.yml"
    
    # Copy eza configuration
    if [ -d "$SCRIPT_DIR/linux/eza" ]; then
        cp -r "$SCRIPT_DIR/linux/eza/"* "$HOME/.config/eza/"
    fi
    
    print_success "eza configured"
}

# Setup Wezterm (Windows only)
setup_wezterm() {
    if [ "$OS" = "windows" ]; then
        print_status "Setting up Wezterm..."
        
        local wezterm_config="$SCRIPT_DIR/windows/.wezterm.lua"
        local windows_home="/mnt/c/Users/$(whoami)"
        
        if [ -f "$wezterm_config" ] && [ -d "$windows_home" ]; then
            backup_file "$windows_home/.wezterm.lua"
            cp "$wezterm_config" "$windows_home/.wezterm.lua"
            print_success "Wezterm configured for Windows"
        else
            print_warning "Could not setup Wezterm automatically"
            print_status "Please manually copy: $wezterm_config"
            print_status "To: ~/.wezterm.lua (in Windows)"
        fi
    fi
}

# Change default shell to fish
change_shell() {
    if command -v fish >/dev/null 2>&1; then
        if [ "$SHELL" != "$(which fish)" ]; then
            print_status "Changing default shell to Fish..."
            chsh -s "$(which fish)"
            print_success "Default shell changed to Fish"
        fi
    else
        print_warning "Fish not found, skipping shell change"
    fi
}

# Main installation function
main() {
    print_status "Starting dotfiles installation..."
    
    # Get script directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # Detect OS
    detect_os
    
    # Create backup
    create_backup
    
    # Install dependencies
    install_dependencies
    
    # Setup configurations
    setup_fish
    setup_tmux
    setup_eza
    setup_wezterm
    
    # Change shell (optional, ask user)
    if [ "$OS" != "windows" ]; then
        read -p "Change default shell to Fish? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            change_shell
        fi
    fi
    
    print_success "Dotfiles installation complete!"
    print_status "Backup location: $BACKUP_DIR"
    print_status "Please restart your terminal or run 'source ~/.config/fish/config.fish'"
    
    if [ "$OS" != "windows" ]; then
        print_status "To start tmux automatically, Fish is configured to launch it"
    fi
}

# Run main function
main "$@"