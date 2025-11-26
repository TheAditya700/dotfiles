#!/bin/bash

# Linux/WSL Dependencies Installer
# Installs required packages for Ubuntu/Debian and Fedora systems

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_status "Installing Linux/WSL dependencies..."

# Detect package manager
if command -v apt >/dev/null 2>&1; then
    print_status "Using apt package manager (Ubuntu/Debian)"
    
    # Update package list
    sudo apt update
    
    # Install core packages
    sudo apt install -y fish tmux curl git build-essential
    
    # Install eza
    if ! command -v eza >/dev/null 2>&1; then
        print_status "Installing eza..."
        
        # Get latest eza release
        EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep -oP '"tag_name": "\K[^"]*')
        ARCH="x86_64-unknown-linux-gnu"
        
        curl -L "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_${ARCH}.tar.gz" -o eza.tar.gz
        tar xzf eza.tar.gz
        sudo mv eza /usr/local/bin/
        rm eza.tar.gz
        
        print_success "eza installed"
    fi
    
elif command -v dnf >/dev/null 2>&1; then
    print_status "Using dnf package manager (Fedora/RHEL)"
    
    # Install core packages
    sudo dnf install -y fish tmux curl git gcc make
    
    # Install eza
    if ! command -v eza >/dev/null 2>&1; then
        print_status "Installing eza..."
        
        EZA_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | grep -oP '"tag_name": "\K[^"]*')
        ARCH="x86_64-unknown-linux-gnu"
        
        curl -L "https://github.com/eza-community/eza/releases/download/${EZA_VERSION}/eza_${ARCH}.tar.gz" -o eza.tar.gz
        tar xzf eza.tar.gz
        sudo mv eza /usr/local/bin/
        rm eza.tar.gz
        
        print_success "eza installed"
    fi
    
else
    echo "Unsupported package manager. Please install fish, tmux, and eza manually."
    exit 1
fi

print_success "Linux/WSL dependencies installed successfully!"