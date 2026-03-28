#!/bin/bash
set -e  # Exit on error

echo "🚀 macOS Setup Script - 2026 Edition"
echo "======================================"

# Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✓ Homebrew already installed"
fi

echo ""
echo "🖥️  Installing Applications..."
echo "======================================"

# Productivity Apps
brew install --cask google-chrome
brew install --cask arc
brew install --cask visual-studio-code
brew install --cask notion
brew install --cask slack

# Developer Tools
echo "🛠️  Installing Claude Code..."
brew install --cask claude

echo ""
echo "⌨️  Installing Terminal Tools..."
echo "======================================"

# Zsh tools
brew install zsh zsh-completions

# Terminal productivity tools
echo "Installing fzf (fuzzy finder)..."
brew install fzf
$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

echo "Installing zoxide (smart cd)..."
brew install zoxide
if ! grep -q "zoxide init zsh" ~/.zshrc; then
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
fi

echo "Installing tmux (terminal multiplexer)..."
brew install tmux

echo "Installing fd (modern find)..."
brew install fd

echo "Installing htop (process viewer)..."
brew install htop

echo "Installing btop (resource monitor)..."
brew install btop

echo "Installing duf (disk usage)..."
brew install duf

echo "Installing lsof (list open files)..."
brew install lsof

echo "Installing jq (JSON processor)..."
brew install jq

echo "Installing tldr (simplified man pages)..."
brew install tldr

echo "Installing hyperfine (benchmarking)..."
brew install hyperfine

echo "Installing mise (version manager)..."
brew install mise
if ! grep -q "mise activate zsh" ~/.zshrc; then
    echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
fi

echo "Installing AWS CLI..."
brew install awscli

echo "Installing Docker..."
brew install --cask docker

# Prompt
echo "Installing starship (prompt)..."
brew install starship
if ! grep -q "starship init zsh" ~/.zshrc; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Font & terminal themes
echo "Installing JetBrains Mono Nerd Font..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

echo ""
echo "✅ Setup Complete!"
echo "======================================"
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Configure your terminal to use JetBrains Mono Nerd Font"
echo "  3. Open the installed applications and sign in"
echo "  4. Check README.md for tutorials on CLI tools"
echo ""
echo "Installed applications:"
echo "  • Google Chrome"
echo "  • Arc Browser"
echo "  • Visual Studio Code"
echo "  • Claude Code"
echo "  • Notion"
echo "  • Slack"
echo "  • Docker"
echo ""
echo "Installed CLI tools:"
echo "  • fzf, zoxide, tmux, fd, htop, btop"
echo "  • duf, lsof, jq, tldr, hyperfine"
echo "  • mise, awscli, starship"
echo ""
