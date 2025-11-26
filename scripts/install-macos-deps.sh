#!/bin/bash

# macOS Dependencies Installer
# Installs required packages using Homebrew

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_status "Installing macOS dependencies..."

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Homebrew installed"
else
    print_status "Homebrew already installed, updating..."
    brew update
fi

# Install packages
print_status "Installing packages with Homebrew..."

# Core packages
brew install fish tmux eza git curl

# Additional useful tools
brew install neovim ripgrep fd bat

# Install Fish plugin manager
if ! fish -c "type -q fisher" 2>/dev/null; then
    print_status "Installing Fisher for Fish..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

print_success "macOS dependencies installed successfully!"

# Note about shell configuration
print_warning "Note: To use Fish as your default shell, run:"
echo "  chsh -s \$(which fish)"
echo ""
echo "Or add Fish to your terminal app's settings instead of changing system default."