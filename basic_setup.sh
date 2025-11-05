# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Zsh tools
brew install zsh zsh-completions

# Terminal goodies
brew install fzf
$(brew --prefix)/opt/fzf/install --all

brew install zoxide
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc

brew install tmux

# Prompt
brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Font & terminal themes
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
